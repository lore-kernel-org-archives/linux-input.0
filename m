From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCHv3 4/4] Input: edt-ft5x06 adjust reset delays according to datasheet
Date: Fri, 17 Jan 2014 13:28:38 +0100
Message-ID: <1389961718-8130-5-git-send-email-LW@KARO-electronics.de>
References: <1389961718-8130-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1389961718-8130-1-git-send-email-LW@KARO-electronics.de>
Sender: linux-doc-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Rob Landley <rob@landley.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Grant Likely <grant.likely@linaro.org>, Jonathan Cameron <jic23@kernel.org>, Shawn Guo <shawn.guo@linaro.org>, Silvio F <silvio.fricke@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jingoo Han <jg1.han@samsung.com>, Fugang Duan <B38611@freescale.com>, Sachin Kamat <sachin.kamat@linaro.org>, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: linux-input@vger.kernel.org

The FT5x06 datasheet specifies a minimum reset width of 5ms and a
delay between deassertion of reset and start of reporting of 300ms.
Adjust the delays to conform to the datasheet.

With the original delays I sometimes experienced communication
timeouts when initializing the controller.

Signed-off-by: Lothar Wa=C3=9Fmann <LW@KARO-electronics.de>
---
 drivers/input/touchscreen/edt-ft5x06.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/tou=
chscreen/edt-ft5x06.c
index ec6b3e5..bd42845 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -653,9 +653,9 @@ static int edt_ft5x06_ts_reset(struct i2c_client *c=
lient,
 			return error;
 		}
=20
-		mdelay(50);
+		mdelay(5);
 		gpio_set_value(tsdata->reset_pin, 1);
-		mdelay(100);
+		msleep(300);
 	}
=20
 	return 0;
--=20
1.7.2.5

