From: Luotao Fu <l.fu@pengutronix.de>
Subject: Patch serie for STMPE811
Date: Fri, 11 Jun 2010 12:13:12 +0200
Message-ID: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45056 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432Ab0FKKNp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Jun 2010 06:13:45 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, l.fu@pengutronix.de

Hi,
the following patch serie adds support to the STMPE811 device by ST Micro.
STMPE811 is a multifunction device, which contains a GPIO controller,
a Touchscreen controller, an ADC and a temperature sensor. The following
patch serie provides a core driver, a driver for the GPIO controller and a
driver for the touch screen controller.

The documentation for the chip is, well, let's say not quite accurate.
Especially the touch screen controller crashes under conditions, which are not
documented any where. (did not manage to find any erratum also) The reference
code by st is crappy and also leads to crashes. I made some workarounds for
these troubles and documented them in the comments in the driver. So pls check
the comment if you spot any strange stuff.

Tested on a board with a i.MX27 SOC.

cheers
Luotao Fu

