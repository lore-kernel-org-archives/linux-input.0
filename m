From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCH v2] Input: add support for DragonRise PID 0011 gamepad
Date: Fri, 21 Jan 2011 12:30:12 +0300
Message-ID: <1295602215-6056-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:47849 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750815Ab1AUJae (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Jan 2011 04:30:34 -0500
Received: by eye27 with SMTP id 27so771346eye.19
        for <linux-input@vger.kernel.org>; Fri, 21 Jan 2011 01:30:32 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Vladislav Naumov <vnaum@vnaum.com>, Nikolai Kondrashov <spbnick@gmail.com>

These three patches add support for DragonRise Inc. USB PID 0x0011 gamepad.
This version is rebased onto recent state of Linus' master (namely 12fcdba).


 drivers/hid/Kconfig    |    7 ++-
 drivers/hid/Makefile   |    7 ++-
 drivers/hid/hid-core.c |    1 +
 drivers/hid/hid-dr.c   |  186 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-dr.h   |   13 ++++
 drivers/hid/hid-drff.c |   63 +----------------
 6 files changed, 214 insertions(+), 63 deletions(-)

Sincerely,
Nick
