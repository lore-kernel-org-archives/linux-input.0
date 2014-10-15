From: Matt Ranostay <mranostay@gmail.com>
Subject: [PATCH v7 0/3] cap1106: add support for cap11xx variants
Date: Tue, 14 Oct 2014 22:38:24 -0700
Message-ID: <1413351507-6611-1-git-send-email-mranostay@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:46809 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751041AbaJOFhf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 15 Oct 2014 01:37:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com, galak@codeaurora.org, zonque@gmail.com
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, Matt Ranostay <mranostay@gmail.com>

Changes from v6:

* Minor devicetree binding documentation changes

Matt Ranostay (3):
  cap11xx: make driver generic for variant support
  cap11xx: Add support for various cap11xx devices
  cap11xx: support for irq-active-high option

 .../bindings/input/{cap1106.txt => cap11xx.txt}    |  26 +-
 drivers/input/keyboard/Kconfig                     |   8 +-
 drivers/input/keyboard/Makefile                    |   2 +-
 drivers/input/keyboard/cap1106.c                   | 341 -------------------
 drivers/input/keyboard/cap11xx.c                   | 366 +++++++++++++++++++++
 5 files changed, 387 insertions(+), 356 deletions(-)
 rename Documentation/devicetree/bindings/input/{cap1106.txt => cap11xx.txt} (64%)
 delete mode 100644 drivers/input/keyboard/cap1106.c
 create mode 100644 drivers/input/keyboard/cap11xx.c

-- 
1.9.1

