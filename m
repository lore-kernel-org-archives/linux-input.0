From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [PATCH 0/2] Input: gpio-keys: support for disabling GPIOs
Date: Thu, 19 Nov 2009 09:23:44 +0200
Message-ID: <cover.1258614931.git.ext-mika.1.westerberg@nokia.com>
References: <1257935192.21596.1004.camel@localhost>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:53388 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbZKSH2n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 19 Nov 2009 02:28:43 -0500
In-Reply-To: <1257935192.21596.1004.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hi Dmitry,

This is a third proposal for disabling individual GPIO keys. Now I
implemented this as you suggested. There are now 4 new attributes
under sys/devices/platform/gpio-keys/:
	keys - keys that can be disabled (by keycode)
	switches - switches that can be disabled (by switch code)
	disabled_keys - keys that are currently disabled
	disabled_switches - switches that are currently disabled

I added those 2 attributes (keys and switches) so that userland
can find out what keys/switches are available. Hope this is OK
for you.

These are exported as bitmaps as you suggested (using
bitmap_scnlistprintf() and bitmap_parselist()).

Patches were made against branch 'next'. If these patches get accepted
I'll prepare patch for RX-51 (probably send it to linux-omap ml) where
GPIO buttons don't allow sharing the IRQ.

I tested this with RX-51.

Thanks,
MW

Mika Westerberg (2):
  Input: gpio-keys: allow drivers to specify whether IRQ can be shared
  Input: gpio-keys: added support for disabling gpios through sysfs

 drivers/input/keyboard/gpio_keys.c |  372 +++++++++++++++++++++++++++++++++++-
 include/linux/gpio_keys.h          |    1 +
 2 files changed, 367 insertions(+), 6 deletions(-)

