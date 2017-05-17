From: =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?=
        <maxime.roussinbelanger@gmail.com>
Subject: [PATCH v2] input: touchscreen: atmel_mxt_ts: add T100 as a readable object
Date: Wed, 17 May 2017 11:29:33 -0400
Message-ID: <1495034973-30806-1-git-send-email-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36762 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753944AbdEQPb2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 May 2017 11:31:28 -0400
Received: by mail-it0-f67.google.com with SMTP id z15so1881288ite.3
        for <linux-input@vger.kernel.org>; Wed, 17 May 2017 08:31:28 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com, =?UTF-8?q?Maxime=20Roussin-B=C3=A9langer?= <maxime.roussinbelanger@gmail.com>

When using the 'object' sysfs attribute, T100 is not displayed in
the output.

Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
--
Changes in v2:
  - Fix commit description 'sysfs file' to 'sysfs attribute'.-

 drivers/input/touchscreen/atmel_mxt_ts.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
index e5d185f..090725e 100644
--- a/drivers/input/touchscreen/atmel_mxt_ts.c
+++ b/drivers/input/touchscreen/atmel_mxt_ts.c
@@ -350,6 +350,7 @@ static bool mxt_object_readable(unsigned int type)
 	case MXT_TOUCH_KEYARRAY_T15:
 	case MXT_TOUCH_PROXIMITY_T23:
 	case MXT_TOUCH_PROXKEY_T52:
+	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
 	case MXT_PROCI_GRIPFACE_T20:
 	case MXT_PROCG_NOISE_T22:
 	case MXT_PROCI_ONETOUCH_T24:
-- 
2.1.4

