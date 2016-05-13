From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v2 0/6] Input: soc_button_array fixes and support of the Surface 3
Date: Fri, 13 May 2016 18:05:48 +0200
Message-ID: <1463155554-11747-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44448 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751187AbcEMQF6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 May 2016 12:05:58 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Bastien Nocera <hadess@hadess.net>, Lejun Zhu <lejun.zhu@linux.intel.com>, Fabio Estevam <festevam@gmail.com>

Hi,

This is the v2 of the series with 3 extra patches to add support of the buttons
found on the Surface 3.

Cheers,
Benjamin


Benjamin Tissoires (6):
  Input - soc_button_array: use gpio_is_valid()
  Input - soc_button_array: bail out earlier if gpiod_count is null
  Input - soc_button_array: make sure one GPIO is not assigned twice
  Input - soc_button_array: allow to specify active_low
  Input - soc_button_array: export part of the internals
  Input - surface3_button_array: Introduce button support for the
    Surface 3

 drivers/input/misc/Kconfig                 |   9 ++
 drivers/input/misc/Makefile                |   1 +
 drivers/input/misc/soc_button_array.c      | 128 ++++++++++++++++++-----------
 drivers/input/misc/surface3_button_array.c | 115 ++++++++++++++++++++++++++
 include/linux/input/soc_button_array.h     |  37 +++++++++
 5 files changed, 240 insertions(+), 50 deletions(-)
 create mode 100644 drivers/input/misc/surface3_button_array.c
 create mode 100644 include/linux/input/soc_button_array.h

-- 
2.5.0

