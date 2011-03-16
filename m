From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 07/17] Input: tsc2005 - set up parent device
Date: Wed, 16 Mar 2011 00:18:35 -0700
Message-ID: <20110316071835.25664.95183.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34918 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHSk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:18:40 -0400
Received: by mail-gy0-f174.google.com with SMTP id 1so540250gyf.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:18:40 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

Set up SPI device as parent of the input device so it gets placed into
proper place in sysfs tree.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 732c81e..e294648 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -555,6 +555,7 @@ static int __devinit tsc2005_setup(struct tsc2005 *ts,
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input-ts",
 		 dev_name(&ts->spi->dev));
 	ts->idev->phys = ts->phys;
+	ts->idev->dev.parent = &ts->spi->dev;
 	ts->idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
 	ts->idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);
 	ts->idev->keybit[BIT_WORD(BTN_TOUCH)] = BIT_MASK(BTN_TOUCH);

