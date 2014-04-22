From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] Input: ads7846: Correct log message for spi_sync() errors
Date: Tue, 22 Apr 2014 22:19:15 +0100
Message-ID: <1398201555-13539-1-git-send-email-broonie@kernel.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:41795 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757932AbaDVVTY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Apr 2014 17:19:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@mail.ru>
Cc: linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>

From: Mark Brown <broonie@linaro.org>

While searching for users of spi_async() I got a false positive in the
ads7846 driver, fix that.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/input/touchscreen/ads7846.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 7f8aa981500d..da201b8e37dc 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -706,7 +706,7 @@ static void ads7846_read_state(struct ads7846 *ts)
 		m = &ts->msg[msg_idx];
 		error = spi_sync(ts->spi, m);
 		if (error) {
-			dev_err(&ts->spi->dev, "spi_async --> %d\n", error);
+			dev_err(&ts->spi->dev, "spi_sync --> %d\n", error);
 			packet->tc.ignore = true;
 			return;
 		}
-- 
1.9.2

