From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [RFC 0/3] Updates to the wm97xx-drivers
Date: Sun,  3 Jul 2011 19:09:27 +0200
Message-ID: <1309712970-5829-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58727 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1GCRI3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 3 Jul 2011 13:08:29 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dp@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, Wolfram Sang <w.sang@pengutronix.de>

I noticed a problem that reading battery status was dependent on the pen_down
status. While trying to solve the problem, I came up with the first two cleanup
patches. The third one then fixes the original itch. The series been tested
with Linux 3.0-rc5 on a Jaytech PID7901 having a WM9715. The code for WM9705
and WM9713 has only been compile tested. Testers are very welcome :)

Thanks,

   Wolfram

Wolfram Sang (3):
  input: touchscreen: wm97xx: remove redundant define
  input: touchscreen: wm97xx: refactor channel selection in poll_sample()
  input: touchscreen: wm97xx: mark channels which need pen_down

 drivers/input/touchscreen/atmel-wm97xx.c     |    2 +-
 drivers/input/touchscreen/mainstone-wm97xx.c |    6 ++--
 drivers/input/touchscreen/wm9705.c           |   25 +++++++++++------------
 drivers/input/touchscreen/wm9712.c           |   27 +++++++++++++------------
 drivers/input/touchscreen/wm9713.c           |   25 ++++++++++++-----------
 drivers/input/touchscreen/zylonite-wm97xx.c  |    6 ++--
 include/linux/wm97xx.h                       |   13 ++++-------
 7 files changed, 51 insertions(+), 53 deletions(-)

-- 
1.7.2.5

