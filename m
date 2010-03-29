From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: [RFC][PATCH v2 5/5] omap1: Amstrad Delta: modify defconfig for external keyboard support
Date: Mon, 29 Mar 2010 16:32:31 +0200
Message-ID: <201003291632.33077.jkrzyszt@tis.icnet.pl>
References: <201003291619.25878.jkrzyszt@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:45564 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925Ab0C2Ocw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Mar 2010 10:32:52 -0400
In-Reply-To: <201003291619.25878.jkrzyszt@tis.icnet.pl>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, e3-hacking@earth.li

The patch adds a CONFIG directive required for supporting the Amstrad Delta
connected external keyboard by default.

Works on top of patch 4/5:
	input: serio: add support for Amstrad Delta serial keyboard port

Created and tested against linux-2.6.34-rc2.

Signed-off-by: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
---
v2 changes:
- no functional changes,
- refreshed against linux-2.6.34-rc2.

 arch/arm/configs/ams_delta_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff -uprN git.orig/arch/arm/configs/ams_delta_defconfig git/arch/arm/configs/ams_delta_defconfig
--- git.orig/arch/arm/configs/ams_delta_defconfig	2010-03-28 23:43:07.000000000 +0200
+++ git/arch/arm/configs/ams_delta_defconfig	2010-03-28 23:46:29.000000000 +0200
@@ -700,6 +700,7 @@ CONFIG_SERIO=y
 CONFIG_SERIO_SERPORT=y
 CONFIG_SERIO_LIBPS2=y
 # CONFIG_SERIO_RAW is not set
+CONFIG_SERIO_AMS_DELTA=y
 # CONFIG_GAMEPORT is not set
 
 #
