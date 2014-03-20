From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv5 3/5] Input: edt-ft5x06: Adjust delays to conform datasheet
Date: Thu, 20 Mar 2014 14:44:33 +0100
Message-ID: <1395323075-12146-4-git-send-email-LW@KARO-electronics.de>
References: <1395234563-11034-1-git-send-email-LW@KARO-electronics.de>
 <1395323075-12146-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:52102 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758307AbaCTNp1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Mar 2014 09:45:27 -0400
In-Reply-To: <1395323075-12146-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Fugang Duan <B38611@freescale.com>, Grant Likely <grant.likely@linaro.org>, Henrik Rydberg <rydberg@euromail.se>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jingoo Han <jg1.han@samsung.com>, Kumar Gala <galak@codeaurora.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Rob Landley <rob@landley.net>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Simon Budig <simon.budig@kernelconcepts.de>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>, Daniel Wagener <daniel.wagener@kernelconcepts.de>

The FT5x06 datasheet specifies a minimum reset width of 5ms and a
delay between deassertion of reset and start of reporting of 300ms.
Adjust the delays to conform to the datasheet.

With the original delays I sometimes experienced communication
timeouts when initializing the controller.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/input/touchscreen/edt-ft5x06.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
index 03dab2f..0298568 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -635,7 +635,7 @@ static int edt_ft5x06_ts_reset(struct i2c_client *c=
lient,
 			return error;
 		}
=20
-		mdelay(5);
+		msleep(5);
 		gpio_set_value(tsdata->wake_pin, 1);
 	}
 	if (gpio_is_valid(tsdata->reset_pin)) {
@@ -650,9 +650,9 @@ static int edt_ft5x06_ts_reset(struct i2c_client *c=
lient,
 			return error;
 		}
=20
-		mdelay(50);
+		msleep(5);
 		gpio_set_value(tsdata->reset_pin, 1);
-		mdelay(100);
+		msleep(300);
 	}
=20
 	return 0;
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
