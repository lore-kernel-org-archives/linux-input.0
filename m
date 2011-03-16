From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 00/17] Series short description
Date: Wed, 16 Mar 2011 00:12:49 -0700
Message-ID: <20110316071246.25081.27438.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45354 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933Ab1CPHM5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Mar 2011 03:12:57 -0400
Received: by iwn34 with SMTP id 34so1376381iwn.19
        for <linux-input@vger.kernel.org>; Wed, 16 Mar 2011 00:12:56 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Phil Carmody <ext-phil.2.carmody@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: linux-input@vger.kernel.org, lauri.leukkunen@nokia.com, David Brownell <dbrownell@users.sourceforge.net>, Imre Deak <imre.deak@nokia.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Ari Kauppi <Ext-Ari.Kauppi@nokia.com>, Tony Lindgren <tony@atomide.com>, Jarkko Nikula <jhnikula@gmail.com>, Eero Nurkkala <ext-eero.nurkkala@nokia.com>, Roman Tereshonkov <roman.tereshonkov@nokia.com>

The following series implements...

---

Dmitry Torokhov (17):
      Input: tsc2005 - remove 'disable' sysfs attribute
      Input: tsc2005 - add open/close
      Input: tsc2005 - handle read errors from SPI layer
      Input: tsc2005 - do not rearm timer in hardirq handler
      Input: tsc2005 - don't use work for 'pen up' handling
      Input: tsc2005 - do not use 0 in place of NULL
      Input: tsc2005 - use true/false for boolean variables
      Input: tsc2005 - hide selftest attribute if we can't reset
      Input: tsc2005 - rework driver initialization code
      Input: tsc2005 - set up bus type in input device
      Input: tsc2005 - set up parent device
      Input: tsc2005 - clear driver data after unbinding
      Input: tsc2005 - add module description
      Input: tsc2005 - remove driver banner message
      Input: tsc2005 - remove incorrect module alias
      Input: tsc2005 - convert to using dev_pm_ops
      Input: tsc2005 - use spi_get/set_drvdata()


 drivers/input/touchscreen/tsc2005.c |  659 +++++++++++++++++++----------------
 1 files changed, 349 insertions(+), 310 deletions(-)

-- 
Signature
