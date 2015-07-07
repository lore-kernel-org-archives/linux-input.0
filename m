From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] Input: drv260x/drv2665/drv2667 - Constify reg_default tables
Date: Tue, 07 Jul 2015 09:01:39 +0800
Message-ID: <1436230899.10336.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36827 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbbGGBBo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Jul 2015 21:01:44 -0400
Received: by pacgz10 with SMTP id gz10so29823798pac.3
        for <linux-input@vger.kernel.org>; Mon, 06 Jul 2015 18:01:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Dan Murphy <dmurphy@ti.com>, linux-input@vger.kernel.org

These reg_default tables are not modified after initialized, so make them
const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/input/misc/drv260x.c | 2 +-
 drivers/input/misc/drv2665.c | 2 +-
 drivers/input/misc/drv2667.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
index e5d60ec..0e3af55 100644
--- a/drivers/input/misc/drv260x.c
+++ b/drivers/input/misc/drv260x.c
@@ -204,7 +204,7 @@ struct drv260x_data {
 	int overdrive_voltage;
 };
 
-static struct reg_default drv260x_reg_defs[] = {
+static const struct reg_default drv260x_reg_defs[] = {
 	{ DRV260X_STATUS, 0xe0 },
 	{ DRV260X_MODE, 0x40 },
 	{ DRV260X_RT_PB_IN, 0x00 },
diff --git a/drivers/input/misc/drv2665.c b/drivers/input/misc/drv2665.c
index 0afaa33..e9501fd 100644
--- a/drivers/input/misc/drv2665.c
+++ b/drivers/input/misc/drv2665.c
@@ -74,7 +74,7 @@ static const u8 drv2665_sine_wave_form[] = {
 	0x9b, 0x9f, 0xa5, 0xad, 0xb8, 0xc4, 0xd2, 0xe0, 0xf0, 0x00,
 };
 
-static struct reg_default drv2665_reg_defs[] = {
+static const struct reg_default drv2665_reg_defs[] = {
 	{ DRV2665_STATUS, 0x02 },
 	{ DRV2665_CTRL_1, 0x28 },
 	{ DRV2665_CTRL_2, 0x40 },
diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
index fc0fddf..a231342 100644
--- a/drivers/input/misc/drv2667.c
+++ b/drivers/input/misc/drv2667.c
@@ -116,7 +116,7 @@ struct drv2667_data {
 	u32 frequency;
 };
 
-static struct reg_default drv2667_reg_defs[] = {
+static const struct reg_default drv2667_reg_defs[] = {
 	{ DRV2667_STATUS, 0x02 },
 	{ DRV2667_CTRL_1, 0x28 },
 	{ DRV2667_CTRL_2, 0x40 },
-- 
2.1.0



