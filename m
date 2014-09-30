From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v4 0/3] cap1106: add support for cap11xx variants
Date: Mon, 29 Sep 2014 21:26:26 -0700
Message-ID: <1412051189-22643-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:37634 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883AbaI3EZq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Sep 2014 00:25:46 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: galak@codeaurora.org, dmitry.torokhov@gmail.com, zonque@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Changes from v3:

 * Resubmit with "git format-patch -M" to make file rename clear in
   cover letter

Matt Ranostay (3):
  cap11xx: make driver generic for variant support
  cap11xx: Add support for various cap11xx devices
  cap11xx: support for irq-active-high option

 .../bindings/input/{cap1106.txt => cap11xx.txt}    |  12 +-
 drivers/input/keyboard/Kconfig                     |   8 +-
 drivers/input/keyboard/Makefile                    |   2 +-
 drivers/input/keyboard/cap1106.c                   | 341 -------------------
 drivers/input/keyboard/cap11xx.c                   | 371 +++++++++++++++++++++
 5 files changed, 385 insertions(+), 349 deletions(-)
 rename Documentation/devicetree/bindings/input/{cap1106.txt => cap11xx.txt} (78%)
 delete mode 100644 drivers/input/keyboard/cap1106.c
 create mode 100644 drivers/input/keyboard/cap11xx.c

-- 
1.9.1

