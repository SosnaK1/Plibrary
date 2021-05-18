import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plibrary/database_service/database_repository.dart';
import 'package:plibrary/database_service/models.dart';
import 'package:plibrary/database_service/models/library_item.dart';
import 'package:plibrary/navigation_drawer/bloc/nav_drawer_state.dart';
import 'package:plibrary/navigation_drawer/navigation_drawer.dart';
import 'package:plibrary/pages/home/cubit/home_cubit.dart';
import 'package:plibrary/pages/new_item/view/new_item_page.dart';
import 'package:plibrary/themes.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:plibrary/widgets/indicator.dart';

class HomePage extends StatefulWidget {
  FloatingActionButton homeFAB(BuildContext context) => FloatingActionButton(
        onPressed: () {
          Navigator.push(context, NewItemPage.route(NavItem.home));
        },
        child: Icon(Icons.add),
      );

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int touchedIndexPie = -1;
  int touchedIndexBar = -1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeCubit>(
      create: (context) => HomeCubit(context.read<DatabaseRepository>()),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return StreamBuilder<List<Movie>>(
              stream: state.moviesStream,
              builder: (context, snapshotMovies) {
                return StreamBuilder<List<Series>>(
                    stream: state.seriesStream,
                    builder: (context, snapshotSeries) {
                      return StreamBuilder<List<Book>>(
                          stream: state.booksStream,
                          builder: (context, snapshotBooks) {
                            return StreamBuilder<List<Game>>(
                                stream: state.gamesStream,
                                builder: (context, snapshotGames) {
                                  if (snapshotMovies.data == null ||
                                      snapshotSeries.data == null ||
                                      snapshotBooks.data == null ||
                                      snapshotGames.data == null) {
                                    return CircularProgressIndicator();
                                  }
                                  return SingleChildScrollView(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 40),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 8, 8, 0),
                                            child: Row(
                                              children: [
                                                getItemContainer(
                                                    context,
                                                    snapshotMovies.data,
                                                    "Movies",
                                                    Colors.red,
                                                    NavItem.movies),
                                                getItemContainer(
                                                    context,
                                                    snapshotSeries.data,
                                                    "Series",
                                                    Colors.blue,
                                                    NavItem.series)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                8, 0, 8, 8),
                                            child: Row(
                                              children: [
                                                getItemContainer(
                                                    context,
                                                    snapshotBooks.data,
                                                    "Books",
                                                    Colors.green,
                                                    NavItem.books),
                                                getItemContainer(
                                                    context,
                                                    snapshotGames.data,
                                                    "Games",
                                                    Colors.orange,
                                                    NavItem.games)
                                              ],
                                            ),
                                          ),

                                          Divider(
                                            height: 40,
                                            color: Colors.grey[700],
                                            thickness: 4,
                                          ),

                                          Text("Scores", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 20,),

                                          // Bar chart
                                          Container(
                                            height: 300,
                                            width: 300,
                                            child: BarChart(mainBarData(
                                                snapshotMovies,
                                                snapshotSeries,
                                                snapshotBooks,
                                                snapshotGames)),
                                          ),

                                          Divider(
                                            height: 40,
                                            color: Colors.grey[700],
                                            thickness: 4,
                                          ),

                                          Text("Items Count", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                                          SizedBox(height: 20,),

                                          // Pie chart
                                          if (snapshotMovies.data != null)
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Container(
                                                  width: 200,
                                                  height: 200,
                                                  child: PieChart(
                                                    PieChartData(
                                                        pieTouchData: PieTouchData(
                                                            touchCallback:
                                                                (pieTouchResponse) {
                                                          setState(() {
                                                            final desiredTouch = pieTouchResponse
                                                                        .touchInput
                                                                    is! PointerExitEvent &&
                                                                pieTouchResponse
                                                                        .touchInput
                                                                    is! PointerUpEvent;
                                                            if (desiredTouch &&
                                                                pieTouchResponse
                                                                        .touchedSection !=
                                                                    null) {
                                                              touchedIndexPie =
                                                                  pieTouchResponse
                                                                      .touchedSection
                                                                      .touchedSectionIndex;
                                                            } else {
                                                              touchedIndexPie =
                                                                  -1;
                                                            }
                                                          });
                                                        }),
                                                        borderData:
                                                            FlBorderData(
                                                          show: false,
                                                        ),
                                                        sectionsSpace: 0,
                                                        centerSpaceRadius: 40,
                                                        sections:
                                                            getPieChartSections(
                                                                snapshotMovies,
                                                                snapshotSeries,
                                                                snapshotBooks,
                                                                snapshotGames)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 8.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: const <Widget>[
                                                      Indicator(
                                                        color: Colors.red,
                                                        text: 'Movies',
                                                        isSquare: true,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Indicator(
                                                        color: Colors.blue,
                                                        text: 'Series',
                                                        isSquare: true,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Indicator(
                                                        color: Colors.green,
                                                        text: 'Books',
                                                        isSquare: true,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Indicator(
                                                        color: Colors.orange,
                                                        text: 'Games',
                                                        isSquare: true,
                                                      ),
                                                      SizedBox(
                                                        height: 18,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )
                                          else
                                            CircularProgressIndicator(),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          });
                    });
              });
        },
      ),
    );
  }

  int _getScoresData(
      double score,
      AsyncSnapshot<List<Movie>> snapshotMovies,
      AsyncSnapshot<List<Series>> snapshotSeries,
      AsyncSnapshot<List<Book>> snapshotBooks,
      AsyncSnapshot<List<Game>> snapshotGames) {
    int counter = 0;

    snapshotMovies.data.forEach((element) {
      if (element.score == score) counter++;
    });

    snapshotSeries.data.forEach((element) {
      if (element.score == score) counter++;
    });

    snapshotBooks.data.forEach((element) {
      if (element.score == score) counter++;
    });

    snapshotGames.data.forEach((element) {
      if (element.score == score) counter++;
    });

    return counter;
  }

  int _getMaxScoresCountData(
      AsyncSnapshot<List<Movie>> snapshotMovies,
      AsyncSnapshot<List<Series>> snapshotSeries,
      AsyncSnapshot<List<Book>> snapshotBooks,
      AsyncSnapshot<List<Game>> snapshotGames) {
    List<int> scoresCount = [];

    scoresCount.add(_getScoresData(
        0, snapshotMovies, snapshotSeries, snapshotBooks, snapshotGames));
    scoresCount.add(_getScoresData(
        1, snapshotMovies, snapshotSeries, snapshotBooks, snapshotGames));
    scoresCount.add(_getScoresData(
        2, snapshotMovies, snapshotSeries, snapshotBooks, snapshotGames));
    scoresCount.add(_getScoresData(
        3, snapshotMovies, snapshotSeries, snapshotBooks, snapshotGames));
    scoresCount.add(_getScoresData(
        4, snapshotMovies, snapshotSeries, snapshotBooks, snapshotGames));
    scoresCount.add(_getScoresData(
        5, snapshotMovies, snapshotSeries, snapshotBooks, snapshotGames));

    scoresCount.sort();

    return scoresCount.last;
  }

  List<PieChartSectionData> getPieChartSections(
      AsyncSnapshot<List<Movie>> snapshotMovies,
      AsyncSnapshot<List<Series>> snapshotSeries,
      AsyncSnapshot<List<Book>> snapshotBooks,
      AsyncSnapshot<List<Game>> snapshotGames) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndexPie;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.red,
            value: snapshotMovies.data.length.toDouble(),
            title: snapshotMovies.data.length.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: Colors.blue,
            value: snapshotSeries.data.length.toDouble(),
            title: snapshotSeries.data.length.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: Colors.green,
            value: snapshotBooks.data.length.toDouble(),
            title: snapshotBooks.data.length.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: Colors.orange,
            value: snapshotGames.data.length.toDouble(),
            title: snapshotGames.data.length.toString(),
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }

  Widget getItemContainer(BuildContext context, List<LibraryItem> items,
      String title, Color backgroundColor, NavItem navigateTo) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(navigateTo));
        },
        child: Container(
            height: 100,
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                if (items != null)
                  Text(
                    items.length.toString(),
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  )
                else
                  CircularProgressIndicator(
                    color: accentColor,
                  )
              ],
            ))),
      ),
    ));
  }

  // Bar Chart
  BarChartGroupData makeGroupData(
    int x,
    double y,
    double maxY, {
    bool isTouched = false,
    Color barColor = Colors.white,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [accentColorLight] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: maxY + 2,
            colors: [Colors.teal],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(
          AsyncSnapshot<List<Movie>> snapshotMovies,
          AsyncSnapshot<List<Series>> snapshotSeries,
          AsyncSnapshot<List<Book>> snapshotBooks,
          AsyncSnapshot<List<Game>> snapshotGames) =>
      List.generate(6, (i) {
        var maxScore = _getMaxScoresCountData(
                snapshotMovies, snapshotSeries, snapshotBooks, snapshotGames)
            .toDouble();

        switch (i) {
          case 0:
            return makeGroupData(
                0,
                _getScoresData(0.0, snapshotMovies, snapshotSeries,
                        snapshotBooks, snapshotGames)
                    .toDouble(),
                maxScore,
                isTouched: i == touchedIndexBar);
          case 1:
            return makeGroupData(
                1,
                _getScoresData(1.0, snapshotMovies, snapshotSeries,
                        snapshotBooks, snapshotGames)
                    .toDouble(),
                maxScore,
                isTouched: i == touchedIndexBar);
          case 2:
            return makeGroupData(
                2,
                _getScoresData(2.0, snapshotMovies, snapshotSeries,
                        snapshotBooks, snapshotGames)
                    .toDouble(),
                maxScore,
                isTouched: i == touchedIndexBar);
          case 3:
            return makeGroupData(
                3,
                _getScoresData(3.0, snapshotMovies, snapshotSeries,
                        snapshotBooks, snapshotGames)
                    .toDouble(),
                maxScore,
                isTouched: i == touchedIndexBar);
          case 4:
            return makeGroupData(
                4,
                _getScoresData(4.0, snapshotMovies, snapshotSeries,
                        snapshotBooks, snapshotGames)
                    .toDouble(),
                maxScore,
                isTouched: i == touchedIndexBar);
          case 5:
            return makeGroupData(
                5,
                _getScoresData(5.0, snapshotMovies, snapshotSeries,
                        snapshotBooks, snapshotGames)
                    .toDouble(),
                maxScore,
                isTouched: i == touchedIndexBar);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData(
      AsyncSnapshot<List<Movie>> snapshotMovies,
      AsyncSnapshot<List<Series>> snapshotSeries,
      AsyncSnapshot<List<Book>> snapshotBooks,
      AsyncSnapshot<List<Game>> snapshotGames) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                "scores count\n",
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toInt().toString(),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndexBar = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndexBar = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 1:
                return '1';
              case 2:
                return '2';
              case 3:
                return '3';
              case 4:
                return '4';
              case 5:
                return '5';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(
          snapshotMovies, snapshotSeries, snapshotBooks, snapshotGames),
    );
  }
}
