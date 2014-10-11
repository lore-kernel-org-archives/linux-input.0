From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v6 0/3] cap1106: add support for cap11xx variants
Date: Fri, 10 Oct 2014 22:06:51 -0700
Message-ID: <1413004014-23807-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f179.google.com ([209.85.192.179]:49018 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbaJKFGF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Oct 2014 01:06:05 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, galak@codeaurora.org, zonque@gmail.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Changes from v5:

 * Removed redundant num_channel from the private structure 

Matt Ranostay (3):
  cap11xx: make driver generic for variant support
  cap11xx: Add support for various cap11xx devices
  cap11xx: support for irq-active-high option

 .../devicetree/bindings/input/cap1106.txt          |  53 ---
 .../devicetree/bindings/input/cap11xx.txt          |  59 ++++
 drivers/input/keyboard/Kconfig                     |   8 +-
 drivers/input/keyboard/Makefile                    |   2 +-
 drivers/input/keyboard/cap1106.c                   | 341 -------------------
 drivers/input/keyboard/cap11xx.c                   | 366 +++++++++++++++++++++
 6 files changed, 430 insertions(+), 399 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/cap1106.txt
 create mode 100644 Documentation/devicetree/bindings/input/cap11xx.txt
 delete mode 100644 drivers/input/keyboard/cap1106.c
 create mode 100644 drivers/input/keyboard/cap11xx.c

-- 
1.9.1

