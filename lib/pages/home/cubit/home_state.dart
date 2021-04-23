part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.user
  });

  final User user;

  @override
  List<Object> get props => [user];

  HomeState copyWith({
    User user,
  }) {
    return HomeState(
      user: user ?? this.user
    );
  }
}