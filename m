From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 06/17] Input: tsc2005 - clear driver data after unbinding
Date: Wed, 16 Mar 2011 00:18:30 -0700
Message-ID: <20110316071830.25664.74587.stgit@hammer.corenet.prv>
References: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34918 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752037Ab1CPHSf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:18:35 -0400
Received: by mail-gy0-f174.google.com with SMTP id 1so540250gyf.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:18:34 -0700 (PDT)
In-Reply-To: <20110316071503.25664.55116.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

We should not leave garbage pointers in driver structure after we unbind
it from the device or if bind fails.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/tsc2005.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/tsc2005.c b/drivers/input/touchscreen/tsc2005.c
index 596fd1f..732c81e 100644
--- a/drivers/input/touchscreen/tsc2005.c
+++ b/drivers/input/touchscreen/tsc2005.c
@@ -634,8 +634,10 @@ static int __devinit tsc2005_probe(struct spi_device *spi)
 	spi_setup(spi);
 
 	r = tsc2005_setup(ts, pdata);
-	if (r)
+	if (r) {
 		kfree(ts);
+		spi_set_drvdata(spi, NULL);
+	}
 	return r;
 }
 
@@ -659,6 +661,7 @@ static int __devexit tsc2005_remove(struct spi_device *spi)
 	input_unregister_device(ts->idev);
 	kfree(ts);
 
+	spi_set_drvdata(spi, NULL);
 	return 0;
 }
 

