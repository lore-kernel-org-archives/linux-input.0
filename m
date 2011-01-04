From: Alan Ott <alan@signal11.us>
Subject: [PATCH 0/1] hidraw: compat_ioctl for hidraw
Date: Tue,  4 Jan 2011 00:37:21 -0500
Message-ID: <1294119442-6827-1-git-send-email-alan__31405.8746597313$1294120855$gmane$org@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:58054 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702Ab1ADGAA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 4 Jan 2011 01:00:00 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id CBCD21CCAB6A
	for <linux-input@vger.kernel.org>; Tue,  4 Jan 2011 00:37:26 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Stefan Achatz <erazor_de@users.sourceforge.net>, Antonio Ospite <ospite@studenti.unina.it>, Tejun Heo <tj@kernel.org>, Marcel Holtmann <marcel@holtmann>
Cc: Alan Ott <alan@signal11.us>

hidraw did not have a compat_ioctl set, causing ioctls to fail from 32-bit apps on 64-bit systems. This patch seems to make ioctls work from 32-bit apps.

I made this look like the one in drivers/input/joydev.c. I'm not 100% sure that this is all that needs to be done, so it'd be nice if someone could review it.

Alan Ott (1):
  hidraw: Added Compatibility ioctl() for 32-bit applications.

 drivers/hid/hidraw.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


