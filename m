From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 08/17] Input: tsc2005 - set up bus type in input device
Date: Wed, 16 Mar 2011 00:18:41 -0700
Message-ID: <20110316071840.25664.3843.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:36065 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHSq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:18:46 -0400
Received: by ywj3 with SMTP id 3so546490ywj.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:18:45 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

We know what bus we are residing on (SPI) so let's make this data
available to the users.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index e294648..09cbcb0 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -555,6 +555,7 @@ static int __devinit tsc2005_setup(struct tsc2005 *ts,
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input-ts",
 		 dev_name(&ts->spi->dev));
 	ts->idev->phys = ts->phys;
+	ts->idev->id.bustype = BUS_SPI;
 	ts->idev->dev.parent = &ts->spi->dev;
 	ts->idev->evbit[0] = BIT(EV_ABS) | BIT(EV_KEY);
 	ts->idev->absbit[0] = BIT(ABS_X) | BIT(ABS_Y) | BIT(ABS_PRESSURE);

