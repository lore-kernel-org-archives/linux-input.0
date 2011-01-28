From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH v3] Input: add support for DragonRise PID 0011 gamepad
Date: Fri, 28 Jan 2011 14:50:50 +0300
Message-ID: <1296215454-2586-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f46.google.com ([209.85.215.46]:33977 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754594Ab1A1LvO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Jan 2011 06:51:14 -0500
Received: by ewy5 with SMTP id 5so1444229ewy.19
        for <linux-input@vger.kernel.org>; Fri, 28 Jan 2011 03:51:13 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>, Nikolai Kondrashov <spbnick@gmail.com>

These three patches add support for DragonRise Inc. USB PID 0x0011 gamepad.
This version is based on recent Linus' master (namely bffb276) and is using
single file for both generic and force feedback support.

[PATCH 1/3] Input: rename hid-drff.c to hid-dr.c
[PATCH 2/3] Input: add support for DragonRise PID 0011 gamepad
[PATCH 3/3] Input: update dragonrise Kconfig description

 drivers/hid/Kconfig    |    7 +-
 drivers/hid/Makefile   |    2 +-
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-dr.c   |  312 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-drff.c |  197 ------------------------------
 5 files changed, 320 insertions(+), 199 deletions(-)
