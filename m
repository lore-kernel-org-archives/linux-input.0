From: Corentin Chary <corentin.chary@gmail.com>
Subject: Handling special keys in platform drivers
Date: Mon, 9 Jan 2012 07:24:14 +0100
Message-ID: <CAHR064jAJkQCd_Tsrx7NHe_RbaBbNcX4sMwy=zkZCZNUNo=fAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:52141 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752951Ab2AIGYQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jan 2012 01:24:16 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>, linux-input@vger.kernel.org

Hi,

Some of the platform drivers in platform/x86/ (and probably other) are
relaying keys to userspace and are also controlling the device
associated to these key. A simple example is screen brightness,
keyboard backlight or rfkill.

In this case the driver send a key to userspace, userspace has to
handle this key and control the right device.

Most of the time, this job is done by:
- ACPI scripts (legacy)
- DE (gnome-power-manager, kde's solid)

The real problem is that for keyboard backlight to work, it needs DE
cooperation, and only gnome as implemented that right now, and other
(except KDE) will probably neither have the resources to handle all
the possible keys correctly. And of course, who should handle the keys
when there is no DE running at all ?

So I was wondering if we could introduce an "auto" mode for this
drivers. For example, with this mode enabled, asus-wmi would filter
the keys and control keyboard backlight directly (and rfkill/screen
brightness ?).

What do you think about it ?

Thanks,

-- 
Corentin Chary
http://xf.iksaif.net
