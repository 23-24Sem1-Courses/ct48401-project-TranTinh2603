import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/order_item.dart';

class OrderItemCard extends StatefulWidget {
  final OrderItem order;

  const OrderItemCard(this.order, {super.key});

  @override
  State<OrderItemCard> createState() => _OrderItemCardState();
}

class _OrderItemCardState extends State<OrderItemCard> {
  var _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          buildOrderSummary(),
          if (_expanded) buildOrderDetails(),
        ],
      ),
    );
  }

  Widget buildOrderDetails() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: min(widget.order.productCount * 80.0 + 10, 150),
      child: ListView(
        children: widget.order.products
            .map(
              (prod) => Row(
                children: <Widget>[
                  Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Image.network(
                              prod.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          const SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                child: Text(
                                  prod.name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  // textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                child: Text(
                                  '${prod.quantity}x ${prod.price}đ',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 10)

                      // Row(
                      //   children: [
                      //     SizedBox(
                      //       child: Text(
                      //         '${prod.quantity}x ${prod.price}đ',
                      //         style: const TextStyle(
                      //           fontSize: 18,
                      //           color: Colors.grey,
                      //         ),
                      //         textAlign: TextAlign.left,
                      //       ),
                      //     ),
                      //   ],
                      // )
                    ],
                  ),
                  // const Column(
                  //   children: [SizedBox(width: 90)],
                  // ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget buildOrderSummary() {
    return ListTile(
      title: Text('${widget.order.amount}'),
      subtitle: Text(
        DateFormat('dd/MM/yyyy hh:mm').format(widget.order.dateTime),
      ),
      trailing: IconButton(
        icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
        onPressed: () {
          setState(() {
            _expanded = !_expanded;
          });
        },
      ),
    );
  }
}
