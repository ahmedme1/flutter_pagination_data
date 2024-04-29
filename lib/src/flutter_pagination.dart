import 'dart:async';
import 'package:flutter/material.dart';

typedef PaginationBuilder<T> = Future<List<T>> Function(int currentListSize);

class CustomPagination<T> extends StatefulWidget {
  const CustomPagination({
    Key? key,
    required this.itemBuilder,
    required this.onError,
    required this.onEmpty,
    required this.fetchMethod,
    this.isGridView = false,
    this.crossAxisCount = 1,
    this.mainAxisExtent = 100,
    this.mainAxisSpacing = 10,
    this.crossAxisSpacing = 10,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.padding = const EdgeInsets.all(0),
    this.initialData = const [],
    this.physics,
    this.separatorWidget = const SizedBox(height: 0, width: 0),
    this.onPageLoading = const Center(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: SizedBox(
          height: 25,
          width: 25,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 171, 100, 184)),
            backgroundColor: Colors.purple,
          ),
        ),
      ),
    ),
    this.onLoading = const SizedBox(
      height: 25,
      width: 25,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color.fromARGB(255, 171, 100, 184)),
        backgroundColor: Colors.purple,
      ),
    ),
  }) : super(key: key);



  final EdgeInsets padding;
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final List<T> initialData;
  final PaginationBuilder<T> fetchMethod;

  final Widget Function(BuildContext, T) itemBuilder;
  final Widget Function(dynamic) onError;
  final Widget onEmpty;
  final Widget separatorWidget;
  final Widget onPageLoading;
  final Widget onLoading;

  final bool shrinkWrap;
  final bool isGridView;
  final int crossAxisCount;
  final double mainAxisExtent;
  final double mainAxisSpacing;
  final double crossAxisSpacing;

  @override
  _CustomPaginationState<T> createState() => _CustomPaginationState<T>();
}

class _CustomPaginationState<T> extends State<CustomPagination<T>> with AutomaticKeepAliveClientMixin<CustomPagination<T>> {
  final List<T> _items = <T>[];
  dynamic _error;
  final StreamController<LoadingState> _streamController = StreamController<LoadingState>();

  @override
  void initState() {
    _items.addAll(widget.initialData);
    if (widget.initialData.isNotEmpty) _items.addAll(widget.initialData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<LoadingState>(
      stream: _streamController.stream,
      initialData: (_items.isEmpty) ? LoadingState.firstLoad : LoadingState.pageLoad,
      builder: (BuildContext context, AsyncSnapshot<LoadingState> snapshot) {
        if (!snapshot.hasData) {
          return widget.onLoading;
        }
        if (snapshot.data == LoadingState.firstLoad) {
          fetchPageData();
          return widget.onLoading;
        }
        if (snapshot.data == LoadingState.firstEmpty) {
          return widget.onEmpty;
        }
        if (snapshot.data == LoadingState.firstError) {
          return widget.onError(_error);
        }
        if (widget.isGridView) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: widget.crossAxisCount,
              mainAxisExtent: widget.mainAxisExtent,
              mainAxisSpacing: widget.mainAxisSpacing,
              crossAxisSpacing: widget.crossAxisSpacing,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (_items[index] == null && snapshot.data == LoadingState.pageLoad) {
                fetchPageData(offset: index);
                return widget.onPageLoading;
              }
              if (_items[index] == null && snapshot.data == LoadingState.pageError) {
                return widget.onError(_error);
              }
              return widget.itemBuilder(
                context,
                _items[index],
              );
            },
            shrinkWrap: widget.shrinkWrap,
            scrollDirection: widget.scrollDirection,
            physics: widget.physics,
            padding: widget.padding,
            itemCount: _items.length,
          );
        } else {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (_items[index] == null && snapshot.data == LoadingState.pageLoad) {
                fetchPageData(offset: index);
                return widget.onPageLoading;
              }
              if (_items[index] == null && snapshot.data == LoadingState.pageError) {
                return widget.onError(_error);
              }
              return widget.itemBuilder(
                context,
                _items[index],
              );
            },
            shrinkWrap: widget.shrinkWrap,
            scrollDirection: widget.scrollDirection,
            physics: widget.physics,
            padding: widget.padding,
            itemCount: _items.length,
            separatorBuilder: (BuildContext context, int index) => widget.separatorWidget,
          );
        }
      },
    );
  }

  void fetchPageData({int offset = 0}) {
    widget.fetchMethod(offset - widget.initialData.length).then(
          (List<T> list) {
        if (_items.contains(null)) {
          _items.remove(null);
        }
        list = list;
        if (list.isEmpty) {
          if (offset == 0) {
            _streamController.add(LoadingState.firstEmpty);
          } else {
            _streamController.add(LoadingState.pageEmpty);
          }
          return;
        }

        _items.addAll(list);
        _streamController.add(LoadingState.pageLoad);
      },
      onError: (dynamic error) {
        this._error = _error;
        if (offset == 0) {
          _streamController.add(LoadingState.firstError);
        } else {
          if (!_items.contains(null)) {
            // do no thing
          }
          debugPrint(error.toString());
          _streamController.add(LoadingState.pageError);
        }
      },
    );
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;
}

enum LoadingState {
  pageLoad,
  pageError,
  pageEmpty,
  firstEmpty,
  firstLoad,
  firstError,
}
