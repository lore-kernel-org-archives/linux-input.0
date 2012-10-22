From: "Patil, Rachna" <rachna@ti.com>
Subject: [PATCH 0/3] input: ti_am335x_tsc: Remove hard coded values and add variance filter logic
Date: Mon, 22 Oct 2012 15:45:15 +0530
Message-ID: <1350900918-17130-1-git-send-email-rachna@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54232 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125Ab2JVKbZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Oct 2012 06:31:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>, "Patil, Rachna" <rachna@ti.com>

Step configuration enable and the order in which touchscreen
expects positive / negative terminals to be connected
to analog inputs lines was hard coded.
Now the user can provide platform data to represent the same.

Also only fine tuning variance in tslib utility to remove
ADC noise does not help. Hence adding logic to eliminate
ADC noise and unwanted random signals.

This patch set is dependent on [1] and has been tested on AM335x EVM.

[1] Subject: [PATCH RESEND 0/8] TI Touchscreen driver updates and Support for TSC/ADC MFD driver
(http://www.spinics.net/lists/linux-input/msg22976.html)

Patil, Rachna (3):
  input: ti_am335x_tsc: Make steps enable configurable
  input: ti_am335x_tsc: Order of TSC wires connect, made configurable
  input: ti_am335x_tsc: Add variance filters

 drivers/input/touchscreen/ti_am335x_tsc.c |  181 ++++++++++++++++++++++++++---
 include/linux/input/ti_am335x_tsc.h       |   12 ++
 include/linux/mfd/ti_am335x_tscadc.h      |   11 +-
 3 files changed, 181 insertions(+), 23 deletions(-)

