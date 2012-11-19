From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 0/2] ARM: OMAP: ads7846: fix pendown debounce setting
Date: Mon, 19 Nov 2012 18:03:56 +0200
Message-ID: <1353341038-14381-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:35083 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753706Ab2KSQEJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Nov 2012 11:04:09 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Kevin Hilman <khilman@ti.com>, linux-input@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

Commit 97ee9f01 (ARM: OMAP: fix the ads7846 init code) have enabled the
pendown GPIO debounce time setting by the below sequence:

  gpio_request_one()
  gpio_set_debounce()
  gpio_free()

It also revealed a bug in the OMAP GPIO handling code which prevented
the GPIO debounce clock to be disabled and CORE transition to low power
states.

Commit c9c55d9 (gpio/omap: fix off-mode bug: clear debounce settings on
free/reset) fixes the OMAP GPIO handling code by making sure that the
GPIO debounce clock gets disabled if no GPIO is requested from current
bank.

While fixing the OMAP GPIO handling code (in the right way), the above
commit makes the gpio_request->set_debounce->free sequence invalid as
after freeing the GPIO, the debounce settings are lost.

This patch set:
1) Adds the pendown GPIO debounce time setting to the platform data
   structure of the ads7846 driver.
2) Fixes the OMAP platform code to pass the debounce time value
   to the driver instead of handling it by itself.

Igor Grinberg (2):
  ads7846: enable pendown GPIO debounce time setting
  ARM: OMAP: ads7846: fix pendown debounce setting

 arch/arm/mach-omap2/common-board-devices.c |   34 ++++++++++++++++-----------
 drivers/input/touchscreen/ads7846.c        |    6 ++++-
 include/linux/spi/ads7846.h                |    5 ++-
 3 files changed, 28 insertions(+), 17 deletions(-)

-- 
1.7.3.4

