From: Luotao Fu <l.fu@pengutronix.de>
Subject: Patch serie for STMPE811 [V3]
Date: Tue, 15 Jun 2010 11:00:43 +0200
Message-ID: <1276592446-26909-1-git-send-email-l.fu@pengutronix.de>
References: <1276511558-27121-1-git-send-email-l.fu@pengutronix.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51948 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756825Ab0FOJBF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Jun 2010 05:01:05 -0400
In-Reply-To: <1276511558-27121-1-git-send-email-l.fu@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

in the following is the V3 patch serie for the stmpe811 chip. Main changes
are:
* reformat platform data comments to kernel-doc style
* add bus_lock/unlock callbacks to the core irq_chip.
* move declaration of gpio platform data into the gpio subdevice patch.
* new irq flags in the core platform data.
etc.

Please see the individual patch header for more details.

thanks

cheers
Luotao Fu

