From: Luotao Fu <l.fu@pengutronix.de>
Subject: Patch serie for STMPE811 [V2]
Date: Mon, 14 Jun 2010 12:32:35 +0200
Message-ID: <1276511558-27121-1-git-send-email-l.fu@pengutronix.de>
References: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:53052 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756003Ab0FNKcx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Jun 2010 06:32:53 -0400
In-Reply-To: <1276251195-22981-1-git-send-email-l.fu@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

in the following is the V2 patch serie for the stmpe811 chip. Changes are made
all over the place:
* irq management of the core
* configuration parameter passing in the touch screen driver.
* Some additional locking stuff
* i2c client stuff
* formating fix
etc.
See the individual patch header for more details.

thanks

cheers
Luotao Fu

