From: Mischa Jonker <mischa.jonker@synopsys.com>
Subject: [PATCH v3 0/1] Input: serio - Add ARC PS/2 driver
Date: Thu, 18 Oct 2012 10:36:06 +0200
Message-ID: <1350549367-11098-1-git-send-email-mischa.jonker@synopsys.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from us01smtp3.synopsys.com ([198.182.44.81]:42419 "EHLO
	hermes.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752140Ab2JRIoJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Oct 2012 04:44:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, m.d.s.x.jonker@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, arc-linux-dev@synopsys.com
Cc: Mischa Jonker <mischa.jonker@synopsys.com>

main changes for v3:
* proper __iomem annotation
* correct return values in case of error

main changes for v2:
* dev_* instead of pr_*
* ioread32/iowrite32 instead of inl/outl
* use module_platform_driver macro
* disabling interrupt twice was unnecessary

New patch has been tested on our own architecture (ARC) and
builds cleanly on x86-64.

Mischa Jonker (1):
  Input: serio - Add ARC PS/2 driver

 drivers/input/serio/Kconfig   |    9 ++
 drivers/input/serio/Makefile  |    1 +
 drivers/input/serio/arc_ps2.c |  275 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 285 insertions(+), 0 deletions(-)
 create mode 100644 drivers/input/serio/arc_ps2.c

