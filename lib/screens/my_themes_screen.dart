import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/theme_provider.dart';

class MyThemesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的主题'),
      ),
      body: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          if (themeProvider.themes.isEmpty) {
            return Center(child: Text('没有主题'));
          }

          return ListView.builder(
            itemCount: themeProvider.themes.length,
            itemBuilder: (context, index) {
              final theme = themeProvider.themes[index];
              return ListTile(
                title: Text(theme.name),
                subtitle: Text(theme.description),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        // 编辑主题
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        themeProvider.removeTheme(index);
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
