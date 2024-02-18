import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';

Widget buildArticleItem(article) {
  return Container(
    margin: const EdgeInsets.all(8.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image:  DecorationImage(
              image: NetworkImage('${article['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
         Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${article['title']}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '${article['publishedAt']}',
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

Widget articlesBuilder(list){
  return ConditionalBuilder(
    condition: list.isNotEmpty,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(list[index]),
        separatorBuilder: (context, index) => const Divider(
          thickness: 0.5,
        ),
        itemCount: 10,
      ),
    ),
    fallback: (context) =>
    const Center(child: CircularProgressIndicator()),
  );
}