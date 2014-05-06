From: Stephen Warren <swarren@wwwdotorg.org>
Subject: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Tue,  6 May 2014 16:13:08 -0600
Message-ID: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42985 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170AbaEFWNY (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 May 2014 18:13:24 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, linux-input@vger.kernel.org, Stephen Warren <swarren@nvidia.com>

From: Stephen Warren <swarren@nvidia.com>

This series contains the minimum number of patches required to make the
Atmel MXT touchpad work on NVIDIA Tegra, which requires the device to be
instantiated from device tree rather than from a C board file.

These patches are based on patches in the ChromeOS kernel. However, I took
a different approach to the devicetree-doesn't-provide-platform-data issue.
Rather than amending all users of platform data to work with or without it,
as the patches in the ChromeOS kernel do, I implemented a single function
mxt_parse_dt() to create a platform data structure from DT. This isolates
the changes required to a single function, rather than spreading them all
over the driver.

Benson Leung (1):
  Input: atmel_mxt_ts - Set pointer emulation if is_tp

Stephen Warren (2):
  Input: atmel_mxt_ts: define a device tree binding
  Input: atmel_mxt_ts: implement device tree parsing

Yufeng Shen (1):
  Input: atmel_mxt_ts - Read resolution from device memory

 .../devicetree/bindings/input/atmel,mxt-tp.txt     |  26 +++++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 121 +++++++++++++++++----
 include/linux/i2c/atmel_mxt_ts.h                   |   5 +-
 3 files changed, 128 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/atmel,mxt-tp.txt

-- 
1.8.1.5

