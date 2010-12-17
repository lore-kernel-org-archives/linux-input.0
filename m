From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 0/3] input - wacom_w8001: support one finger touch etc.
Date: Fri, 17 Dec 2010 09:36:09 -0800
Message-ID: <1292607369-22534-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:42601 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753465Ab0LQRfe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Dec 2010 12:35:34 -0500
Received: by ywl5 with SMTP id 5so433388ywl.19
        for <linux-input@vger.kernel.org>; Fri, 17 Dec 2010 09:35:33 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>

This is the v2 of adding one finger touch support for Wacom serial touchscreen.
It converts input_dev->keybit to __set_bit, supports pen or touch only devices,
and adds one finger touch support to the driver.

The patchset is based on git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git next

Ping Cheng (3):
      input - wacom_w8001: use __set_bit to set keybits
      input - wacom_w8001: Support pen or touch only devices
      input - wacom_w8001: Add one finger touch support

