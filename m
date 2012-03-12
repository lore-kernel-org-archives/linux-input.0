From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v3 0/2] input: add MAX8997-haptic driver
Date: Mon, 12 Mar 2012 17:31:17 +0900
Message-ID: <4F5DB455.1080907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:36943 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752626Ab2CLIbU (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Mar 2012 04:31:20 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: sameo@linux.intel.com, broonie@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, kyungmin.park@samsung.com, myungjoo.ham@samsung.com

MAX8997 has several features in a single chip,
This patchset supports unimplemented haptic driver of MAX8997.

This patchset tested on TRATS board based on EXYNOS4210.

v2
- code clean and remove unnecessary code according to comment of Dmitry
Torokhov

v3
- use work_struct to enable/disable max8997-haptic instead of using mutex
  in irq handler statck of forced feedbacky

Donggeun Kim (2):
  mfd: add platform data for MAX8997 haptic driver
  input: add driver support for MAX8997-haptic

 drivers/input/misc/Kconfig          |   12 +
 drivers/input/misc/Makefile         |    1 +
 drivers/input/misc/max8997_haptic.c |  377
+++++++++++++++++++++++++++++++++++
 include/linux/mfd/max8997.h         |   53 +++++-
 4 files changed, 442 insertions(+), 1 deletions(-)
 create mode 100644 drivers/input/misc/max8997_haptic.c
