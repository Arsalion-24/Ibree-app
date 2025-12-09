import 'dart:async';
import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ebeere/commons/commons.dart';
import 'package:ebeere/core/core.dart';
import 'package:ebeere/features/ads/blocs/interstitial_ad_cubit.dart';
import 'package:ebeere/features/profile_management/cubits/user_details_cubit.dart';
import 'package:ebeere/features/system_config/cubits/system_config_cubit.dart';
import 'package:ebeere/features/wallet/blocs/payment_request_cubit.dart';
import 'package:ebeere/features/wallet/blocs/transactions_cubit.dart';
import 'package:ebeere/features/wallet/models/payment_request.dart';
import 'package:ebeere/features/wallet/repos/wallet_repository.dart';
import 'package:ebeere/features/wallet/widgets/animated_coin_display.dart';
import 'package:ebeere/features/wallet/widgets/cancel_redeem_request_dialog.dart';
import 'package:ebeere/features/wallet/widgets/redeem_amount_request_bottom_sheet_container.dart';
import 'package:ebeere/ui/widgets/all.dart';
import 'package:ebeere/utils/extensions.dart';
import 'package:ebeere/utils/ui_utils.dart';
import 'package:intl/intl.dart';
      body: DecoratedBackground(
        shapesCount: 18,
        shapesSeed: 321,
        child: TabBarView(
          controller: tabController,
          children: [
            _buildRequestContainer(),
            _buildTransactionListContainer(),
          ],
        ),
      ),
    );
  }
}
