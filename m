From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Subject: [PATCH] Input: tsc2007: Remove a useless code and check a necessary
	function is provided or not
Date: Fri, 15 May 2009 14:47:12 +0900
Message-ID: <483a38b80905142247l31dc77f6sd3deb511fc171f5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f123.google.com ([209.85.216.123]:36397 "EHLO
	mail-px0-f123.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757223AbZEOFrL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 01:47:11 -0400
Received: by pxi29 with SMTP id 29so882030pxi.33
        for <linux-input@vger.kernel.org>; Thu, 14 May 2009 22:47:13 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thierry Reding <thierry.reding@avionic-design.de>, Manuel Lauss <mano@roarinelk.homelinux.net>, Trilok Soni <soni.trilok@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Dmitry,

This patch contains a trivial removal and check the existence of a
platform specific function.

Regards,
Kwangwoo Lee

>From bc18ba8c71027ca58d1242149eee9919bdaa069b Mon Sep 17 00:00:00 2001
From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Date: Fri, 15 May 2009 13:43:55 +0900
Subject: [PATCH] Input: tsc2007: remove useless code and check a
necessary function is provided or not.

Remove a useless code and check a necessary function is implemented or not.
The platform codes must provide get_pendown_state() to work properly.

Signed-off-by: Kwangwoo Lee <kwangwoo.lee@gmail.com>
---
 drivers/input/touchscreen/tsc2007.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2007.c
b/drivers/input/touchscreen/tsc2007.c
index 948e167..da35adb 100644
--- a/drivers/input/touchscreen/tsc2007.c
+++ b/drivers/input/touchscreen/tsc2007.c
@@ -253,11 +253,11 @@ static int tsc2007_probe(struct i2c_client *client,
 			const struct i2c_device_id *id)
 {
 	struct tsc2007 *ts;
-	struct tsc2007_platform_data *pdata = pdata = client->dev.platform_data;
+	struct tsc2007_platform_data *pdata = client->dev.platform_data;
 	struct input_dev *input_dev;
 	int err;

-	if (!pdata) {
+	if (!pdata || !pdata->get_pendown_state) {
 		dev_err(&client->dev, "platform data is required!\n");
 		return -EINVAL;
 	}
-- 
1.5.6.5
