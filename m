From: Maxime =?iso-8859-1?Q?Roussin-B=E9langer?=
        <maxime.roussinbelanger@gmail.com>
Subject: [PATCH] input: touchscreen: atmel_mxt_ts: add T100 as a readable
 object
Date: Wed, 17 May 2017 09:39:55 -0400
Message-ID: <20170517133953.GA30691@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f194.google.com ([209.85.223.194]:34398 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753219AbdEQNj6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 May 2017 09:39:58 -0400
Received: by mail-io0-f194.google.com with SMTP id 12so1450092iol.1
        for <linux-input@vger.kernel.org>; Wed, 17 May 2017 06:39:58 -0700 (PDT)
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick@shmanahar.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, jeff.dagenais@gmail.com

When using the 'object' sysfs file T100 is not displayed in
the output.

Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
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

