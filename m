From: Luis de Bethencourt <luis@debethencourt.com>
Subject: [PATCH 0/6] input: Fix module autoload for OF platform driver
Date: Thu, 27 Aug 2015 18:57:58 +0200
Message-ID: <20150827165758.GA4619@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35269 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbbH0Q6B (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 Aug 2015 12:58:01 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>, Wolfram Sang <wsa@the-dreams.de>

Hello,

This series add the missing MODULE_DEVICE_TABLE() for OF to eport
that information so modules have the correct aliases built-in
and autoloading works correctly.

A longer explanation by Javier Canillas can be found here:
https://lkml.org/lkml/2015/7/30/519

Thanks,
Luis

Luis de Bethencourt (6)
  input: mms114: Fix module autoload for OF platform driver
  input: egalax_ts: Fix module autoload for OF platform driver
  input: sparcspkr: Fix module autoload for OF platform drivers
  input: regulator-haptic: Fix module autoload for OF platform driver
  input: pwm-beeper: Fix module autoload for OF platform driver
  input: ab8500-ponkey: Fix module autoload for OF platform driver

 drivers/input/misc/ab8500-ponkey.c    | 2 ++
 drivers/input/misc/pwm-beeper.c       | 2 ++
 drivers/input/misc/regulator-haptic.c | 2 ++   
 drivers/input/misc/sparcspkr.c        | 4 ++++
 drivers/input/touchscreen/egalax_ts.c | 2 ++
 drivers/input/touchscreen/mms114.c    | 1 +
 6 files changed, 13 insertions(+)

--
2.4.6
