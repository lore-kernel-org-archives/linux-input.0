From: Zubair Lutfullah <zubair.lutfullah@gmail.com>
Subject: [PATCH V10 0/2] iio: input: ti_am335x_adc: Add continuous sampling support
Date: Wed, 18 Sep 2013 16:23:01 +0500
Message-ID: <1379503383-17086-1-git-send-email-zubair.lutfullah@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:56413 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751881Ab3IRL22 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Sep 2013 07:28:28 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jic23@cam.ac.uk, dmitry.torokhov@gmail.com
Cc: linux-iio@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bigeasy@linutronix.de, gregkh@linuxfoundation.org, zubair.lutfullah@gmail.com

Hi,

These apply to togreg branch in iio.

Round 10 updates
- Removed devm_free as not needed

Round 9 updates

- Removed Trigger.
- Restructured everything for INDIO_BUFFERED_HARDWARE mode.
- Threaded IRQ with top/bottom halfs. Top half HW IRQ wakes
bottom half threaded worker that pushes samples to iio/userspace.
- Removed some of the patchwork to the driver that was irrelevant to the
continuous sampling patch.

Cleanup will be done separately once this goes through.
Hope these patches meet the mighty kernel standards :)

Zubair

Zubair Lutfullah (2):
  input: ti_am335x_tsc: Enable shared IRQ for TSC
  iio: ti_am335x_adc: Add continuous sampling support

 drivers/iio/adc/ti_am335x_adc.c           |  216 ++++++++++++++++++++++++++++-
 drivers/input/touchscreen/ti_am335x_tsc.c |   12 +-
 include/linux/mfd/ti_am335x_tscadc.h      |    9 ++
 3 files changed, 229 insertions(+), 8 deletions(-)

-- 
1.7.9.5

