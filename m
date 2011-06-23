From: David Jander <david@protonic.nl>
Subject: [PATCH v5 0/2]  Input: gpio_keys.c: Add support for OF and I2C GPIO chips
Date: Thu, 23 Jun 2011 12:04:13 +0200
Message-ID: <1308823455-14446-1-git-send-email-david@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:8404 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758992Ab1FWKEK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 06:04:10 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org, David Jander <david@protonic.nl>

This patch series adds support for OF device-tree platform data and non-local
GPIO chips, such as I2C I/O expanders.
This is version 5 of the patches. Feedback from Grant Likely and Dmitry
Torokhov has been processed.

Changed in this version:
 - Removed first patch: Simplify platform_device -> device casting.
   It is not necessary anymore since of_platform bus has been merged into
   platform_bus.
 - Fixed copyright message.
 - Removed support for numeric GPIO specifiers in "reg" property.
 - Renamed "wakeup" property.
 - Improved error handling of gpio_keys_get_devtree_pdata().
 - Misc cleanups.

David Jander (2):
  Input: gpio_keys.c: Added support for device-tree platform data
  Input: gpio_keys.c: Enable use with non-local GPIO chips.

 .../devicetree/bindings/gpio/gpio_keys.txt         |   37 +++++
 drivers/input/keyboard/gpio_keys.c                 |  152 +++++++++++++++++---
 2 files changed, 171 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio_keys.txt

-- 
1.7.4.1

