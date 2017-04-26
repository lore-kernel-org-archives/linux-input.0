From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 2/2] input: touchscreen: mxs-lradc: || vs && typos
Date: Thu, 27 Apr 2017 00:04:31 +0300
Message-ID: <20170426210431.mqze5ehrijm7l2ey@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:44178 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967633AbdDZVEt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Apr 2017 17:04:49 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, Marek Vasut <marex@denx.de>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-iio@vger.kernel.org

These tests are meaningless as is because "adapt" can't possibly be both
less than 1 and greater than 32.

Fixes: d81ca730e3e4 ("input: touchscreen: mxs-lradc: Add support for touchscreen")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/input/touchscreen/mxs-lradc-ts.c b/drivers/input/touchscreen/mxs-lradc-ts.c
index ff9cda29d9a0..369ef83234ef 100644
--- a/drivers/input/touchscreen/mxs-lradc-ts.c
+++ b/drivers/input/touchscreen/mxs-lradc-ts.c
@@ -642,7 +642,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 	if (of_property_read_u32(node, "fsl,ave-ctrl", &adapt)) {
 		ts->over_sample_cnt = 4;
 	} else {
-		if (adapt >= 1 || adapt <= 32) {
+		if (adapt >= 1 && adapt <= 32) {
 			ts->over_sample_cnt = adapt;
 		} else {
 			dev_err(ts->dev, "Invalid sample count (%u)\n",
@@ -654,7 +654,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 	if (of_property_read_u32(node, "fsl,ave-delay", &adapt)) {
 		ts->over_sample_delay = 2;
 	} else {
-		if (adapt >= 2 || adapt <= LRADC_DELAY_DELAY_MASK + 1) {
+		if (adapt >= 2 && adapt <= LRADC_DELAY_DELAY_MASK + 1) {
 			ts->over_sample_delay = adapt;
 		} else {
 			dev_err(ts->dev, "Invalid sample delay (%u)\n",
@@ -666,7 +666,7 @@ static int mxs_lradc_ts_probe(struct platform_device *pdev)
 	if (of_property_read_u32(node, "fsl,settling", &adapt)) {
 		ts->settling_delay = 10;
 	} else {
-		if (adapt >= 1 || adapt <= LRADC_DELAY_DELAY_MASK) {
+		if (adapt >= 1 && adapt <= LRADC_DELAY_DELAY_MASK) {
 			ts->settling_delay = adapt;
 		} else {
 			dev_err(ts->dev, "Invalid settling delay (%u)\n",
