// ignore: unused_import
import 'package:admin/controllers/MenuAppController.dart';
import 'package:admin/controllers/repository.dart';
import 'package:aliafitness_shared_classes/aliafitness_shared_classes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ItemsManagerEvent {}

class FetchItemsEvent extends ItemsManagerEvent {}

class EditItem extends ItemsManagerEvent {
  final Item updatedItem;

  EditItem(this.updatedItem);
}

class DeleteItem extends ItemsManagerEvent {
  final Item item;

  DeleteItem(this.item);
}

abstract class ItemsManagerState {}

class ItemsManagerInitial extends ItemsManagerState {}

class ItemsManagerLoading extends ItemsManagerState {}

class ItemsManagerLoaded extends ItemsManagerState {
  final List<Item> items;

  ItemsManagerLoaded(this.items);
}

class ItemsManagerError extends ItemsManagerState {
  final String message;

  ItemsManagerError(this.message);
}

class ItemsManagerBloc extends Bloc<ItemsManagerEvent, ItemsManagerState> {
  final Repository repository;
  static final ItemsManagerBloc _instance = ItemsManagerBloc._internal();

  ItemsManagerBloc._internal()
      : repository = Repository(),
        super(ItemsManagerInitial()) {
    on<FetchItemsEvent>(_onLoadItems);
    on<EditItem>(_onEditItem);
    on<DeleteItem>(_onDeleteItem);
  }

  factory ItemsManagerBloc() {
    return _instance;
  }

  void _onLoadItems(
      FetchItemsEvent event, Emitter<ItemsManagerState> emit) async {
    try {
      emit(ItemsManagerLoading());
      final items = await repository.getItems();
      if (items == null) {
        emit(ItemsManagerError('Could not load items. Try again later.'));
      }
      emit(ItemsManagerLoaded(items!));
    } catch (e) {
      emit(ItemsManagerError(e.toString()));
    }
  }

  void _onEditItem(EditItem event, Emitter<ItemsManagerState> emit) async {
    try {
      await repository.putItem(event.updatedItem);
      // Reload items or update the list state
      add(FetchItemsEvent());
    } catch (e) {
      emit(ItemsManagerError(e.toString()));
    }
  }

  void _onDeleteItem(DeleteItem event, Emitter<ItemsManagerState> emit) async {
    try {
      await repository.delItem(event.item);
      // Reload items or update the list state
      add(FetchItemsEvent());
    } catch (e) {
      emit(ItemsManagerError(e.toString()));
    }
  }
}
