From: Jason Wang <jason77.wang@gmail.com>
Subject: [PATCH 0/4] Switch ads7846 driver to use soft irq
Date: Thu, 16 Sep 2010 18:51:22 +0800
Message-ID: <1284634286-8871-1-git-send-email-jason77.wang@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:38236 "EHLO
	mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235Ab0IPKry (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Sep 2010 06:47:54 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, notasas@gmail.com, vapier@gentoo.org
Cc: linux-input@vger.kernel.org

Some explanations:

The first patch is from dmitry, he build a frame work for this driver
to use soft irq. The remaining 3 patches are from me to fix some issues
for the driver of soft irq verison.

We change this driver to use soft irq because under current version,
we must use spin lock to protect racing issues, the regulator
operations are also in the racing issue list but we can't put it
in the spin lock protected area because regulator operations always
implement via i2c/spi transfers, in those transfers often call sleep
funcitons. Now change to use soft irq, we can use mutex instread of
spin lock, so this issue is solved.

I have tested these patches on the ti_omap3530evm board:
 1)use ts_lib after normal boot
 2)use ts_lib after "#echo 1/0 > /sys/bus/spi/devices/spi0.1/disable"
 3)use ts_lib after "#echo mem > /sys/power/state" and "wake up"


