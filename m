From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [RFC] mfd/ucb1400: don't depend on gpiolib
Date: Thu, 8 Jan 2009 12:06:12 +0100
Message-ID: <20090108110612.GA24243@www.tglx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.tglx.de ([62.245.132.106]:60082 "EHLO www.tglx.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbZAHLGR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Jan 2009 06:06:17 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: linux-input@vger.kernel.org

it didn't in the past and I can't see how it does.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
I use ucb1400 with its ts capabilities without *gpiolib* on a ppc system.

 drivers/mfd/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 2572773..8bcd600 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -53,7 +53,6 @@ config HTC_PASIC3
 config UCB1400_CORE
 	tristate "Philips UCB1400 Core driver"
 	depends on AC97_BUS
-	depends on GPIOLIB
 	help
 	  This enables support for the Philips UCB1400 core functions.
 	  The UCB1400 is an AC97 audio codec.
-- 
1.5.6.5

