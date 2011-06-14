From: David Jander <david@protonic.nl>
Subject: [PATCH v4 0/3] Input: gpio_keys.c: Add support for OF and I2C GPIO chips
Date: Tue, 14 Jun 2011 11:08:08 +0200
Message-ID: <1308042491-20203-1-git-send-email-david@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:13754 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257Ab1FNJH7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Jun 2011 05:07:59 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

This patch series adds support for OF device-tree platform data and non-local
GPIO chips, such as I2C I/O expanders.
This is version 4 of the patches.

Changed in this version:
 - Corrected naming of DT properties.
 - Fixed a few errors in the way dynamic pdata is handled.
 - Added support for device-tree gpios specifier.

David Jander (3):
  Input: gpio_keys.c: Simplify platform_device -> device casting
  Input: gpio_keys.c: Added support for device-tree platform data
  Input: gpio_keys.c: Enable use with non-local GPIO chips.

 .../devicetree/bindings/gpio/gpio_keys.txt         |   49 +++++
 drivers/input/keyboard/gpio_keys.c                 |  193 ++++++++++++++++----
 2 files changed, 207 insertions(+), 35 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_keys.txt

-- 
1.7.4.1

