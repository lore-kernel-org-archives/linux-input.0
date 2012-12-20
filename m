From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/4] input adxl34x: give a little love to the driver
Date: Thu, 20 Dec 2012 14:51:07 +0100
Message-ID: <1356011471-18757-1-git-send-email-w.sang@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:50899 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716Ab2LTNv3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Dec 2012 08:51:29 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, device-drivers-devel@blackfin.uclinux.org, Wolfram Sang <w.sang@pengutronix.de>

Hi,

I needed this driver in a project and there were some minor hurdles in getting
it to run smoothly. These four patches are fixing them.

Kind regards,

   Wolfram


Wolfram Sang (4):
  input: adxl34x: consistently use read/write encapsulation
  input: adxl34x: don't set THRESH_TAP twice
  input: adxl34x: make platform_data include self contained
  input: adxl34x: default platform_data should not use defines from
    driver

 drivers/input/misc/adxl34x.c  |    7 +++----
 include/linux/input/adxl34x.h |    2 ++
 2 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.10.4

