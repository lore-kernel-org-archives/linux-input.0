From: "Patil, Rachna" <rachna@ti.com>
Subject: [PATCH 0/4] input: TSC: ti_tscadc: TI Touchscreen driver updates
Date: Wed, 22 Aug 2012 16:47:45 +0530
Message-ID: <1345634265-29646-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35379 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753611Ab2HVLeU (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Aug 2012 07:34:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, "Patil, Rachna" <rachna@ti.com>

This patch set is a cumulative work for
1. Correcting resister usage
2. Adding more platform data
3. Making way for converting touchscreen into Multifunctional device
4. Remove usage of End Of Interrupt(EOI) register

These patches are tested on AM335x EVM.

Patil, Rachna (4):
  input: TSC: ti_tscadc: Correct register usage
  input: TSC: ti_tscadc: Add Step configuration as platform data
  input: TSC: ti_tscadc: set FIFO0 threshold Interrupt
  input: TSC: ti_tscadc: Remove definition of End Of Interrupt register

 drivers/input/touchscreen/ti_tscadc.c |  164 ++++++++++++++++++++-------------
 include/linux/input/ti_tscadc.h       |    6 +
 2 files changed, 106 insertions(+), 64 deletions(-)

