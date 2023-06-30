abstract class AdminStates{}

class InitialAdminState extends AdminStates{}

class GetAllCategoriesState extends AdminStates{}

class LoadingAllData extends AdminStates{}

class LoadedAllData extends AdminStates{}

class LoadingOrderState extends AdminStates{}

class LoadedOrderState extends AdminStates{}

class LoadingFurnitureState extends AdminStates{}

class LoadedFurnitureState extends AdminStates{}

class UploadingFurnitureInProgressState extends AdminStates{}

class UploadingFurnitureSuccessState extends AdminStates{}

class UploadingFurnitureErrorState extends AdminStates{}

class UpdatingFurnitureInProgressState extends AdminStates{}

class UpdatedFurnitureSuccessState extends AdminStates{}

class UpdatedFurnitureErrorState extends AdminStates{}

class UpdatingCategoryInProgressState extends AdminStates{}

class UpdatedCategorySuccessState extends AdminStates{}

class UpdatedCategoryErrorState extends AdminStates{}

class deletingFurnitureState extends AdminStates{}

class deletedFurnitureSucessfullyState extends AdminStates{}

class AddingCategory extends AdminStates{}

class AddedCategory extends AdminStates{}

class AddingOffer extends AdminStates{}

class AddedOffer extends AdminStates{}

class LoadingStatistics extends AdminStates{}

class LoadedStatistics extends AdminStates{}

class DeleteCategoryLoadingState extends AdminStates{}

class DeleteCategorySuccessState extends AdminStates{}

class DeleteCategoryErrorState extends AdminStates{}
