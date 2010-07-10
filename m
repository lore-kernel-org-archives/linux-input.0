From: Alan Ott <alan@signal11.us>
Subject: [PATCH v3 0/1] HID: Add Support for Setting and Getting Feature Reports from hidraw
Date: Sat, 10 Jul 2010 14:33:10 -0400
Message-ID: <1278786791-4025-1-git-send-email-alan@signal11.us>
References: <1275969108-14948-1-git-send-email-alan@signal11.us>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:46865 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752016Ab0GJSdh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Jul 2010 14:33:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 258271CCA9EE
	for <linux-input@vger.kernel.org>; Sat, 10 Jul 2010 14:33:37 -0400 (EDT)
In-Reply-To: <1275969108-14948-1-git-send-email-alan@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Antonio Ospite <ospite@studenti.unina.it>, Alexey Dobriyan <adobriyan@gmail.com>, Tejun Heo <tj@kernel.org>, Marcel Holtmann <marcel@holtmann.org>
Cc: Alan Ott <alan@signal11.us>

Version 3 of the patch. Fixing the problem reported by Amit Nagal where
Report IDs were not getting sent to the device when using Set_Report control
tranfers.

Alan Ott (1):
  HID: Add Support for Setting and Getting Feature Reports from hidraw

 drivers/hid/hidraw.c          |  105 +++++++++++++++++++++++++++++++++++++++--
 drivers/hid/usbhid/hid-core.c |   31 ++++++++++--
 include/linux/hid.h           |    3 +
 include/linux/hidraw.h        |    3 +
 4 files changed, 132 insertions(+), 10 deletions(-)


