From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: WM97xx touchscreen drivers
Date: Thu, 20 Mar 2008 09:39:58 +0000
Message-ID: <20080320093958.GA8101@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:37913 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752620AbYCTJkA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Mar 2008 05:40:00 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dtor@mail.ru>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Hans-Christian Egtvedt <hcegtvedt@atmel.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Graeme Gregory <gg@opensource.wolfsonmicro.com>, Dmitry Baryshkov <dbaryshkov@gmail.com>, Rodolfo Giometti <giometti@enneenne.com>, Russell King <rmk@arm.linux.org.uk>, Marc Kleine-Budde <mkl@pengutronix.de>, Pete MacKay <linux01@architechnical.net>, Ian Molton <spyro@f2s.com>, Vince Sanders <vince@kyllikki.org>, Andrew Zabolotny <zap@homelink.ru>

This patch series adds support for the touchscreen controllers found in
WM97xx devices.  This revision of the patch series fixes a race when a
pen up interrupt occurs while the touchscreen is being polled for input
and adds support for use of pen down interrupts with non-accelerated
reads.

These changes are also available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-touch upstream

Mark Brown (6):
      Core driver for WM97xx touchscreens
      Add chip driver for WM9705 touchscreen
      Add chip driver for WM9712 touchscreen
      Add chip driver for WM9713 touchscreen
      Driver for WM97xx touchscreens in streaming mode on Mainstone
      Build system and MAINTAINERS entry for WM97xx touchscreen drivers

 MAINTAINERS                                  |   10 +
 drivers/input/touchscreen/Kconfig            |   52 ++
 drivers/input/touchscreen/Makefile           |    7 +
 drivers/input/touchscreen/mainstone-wm97xx.c |  300 ++++++++++
 drivers/input/touchscreen/wm9705.c           |  352 ++++++++++++
 drivers/input/touchscreen/wm9712.c           |  461 +++++++++++++++
 drivers/input/touchscreen/wm9713.c           |  459 +++++++++++++++
 drivers/input/touchscreen/wm97xx-core.c      |  772 ++++++++++++++++++++++++++
 include/linux/wm97xx.h                       |  311 +++++++++++
 9 files changed, 2724 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/touchscreen/mainstone-wm97xx.c
 create mode 100644 drivers/input/touchscreen/wm9705.c
 create mode 100644 drivers/input/touchscreen/wm9712.c
 create mode 100644 drivers/input/touchscreen/wm9713.c
 create mode 100644 drivers/input/touchscreen/wm97xx-core.c
 create mode 100644 include/linux/wm97xx.h
