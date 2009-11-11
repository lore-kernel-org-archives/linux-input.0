From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Subject: [RFC PATCH 0/2] Input: adding new ioctl()s for enabling/disabling events
Date: Wed, 11 Nov 2009 12:36:06 +0200
Message-ID: <cover.1257931659.git.ext-mika.1.westerberg@nokia.com>
References: <1257929573.21596.960.camel@localhost>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:22933 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754923AbZKKKkW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 11 Nov 2009 05:40:22 -0500
In-Reply-To: <1257929573.21596.960.camel@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org

Hi Dmitry,

This patchset is second proposal to get selected gpio lines
enabled/disabled with gpio-keys. Basically we provide 2 new ioctl()s
that can be used by userland.  Lower-level input drivers (e.g gpio-keys)
can choose to implement these when needed.

Thanks,
MW

Mika Westerberg (2):
  Input: added 2 new ioctl()s for setting/getting event state
  Input: gpio-keys: implemented support for enabling/disabling gpios

 drivers/input/evdev.c              |   19 ++++++
 drivers/input/input.c              |  115 ++++++++++++++++++++++++++++++++++++
 drivers/input/keyboard/gpio_keys.c |   75 +++++++++++++++++++++++
 include/linux/input.h              |   44 ++++++++++++++
 4 files changed, 253 insertions(+), 0 deletions(-)

