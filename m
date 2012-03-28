From: Przemo Firszt <przemo@firszt.eu>
Subject: [PATCH 0/2] HID: wacom: 2 trivial patches
Date: Wed, 28 Mar 2012 22:13:35 +0100
Message-ID: <1332969217-10727-1-git-send-email-przemo@firszt.eu>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from stats.peacock.arvixe.com ([174.122.104.67]:58124 "EHLO
	peacock.arvixe.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932851Ab2C1VON (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Mar 2012 17:14:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, pinglinux@gmail.com
Cc: linuxwacom-devel@lists.sourceforge.net, linux-input@vger.kernel.org, Przemo Firszt <przemo@firszt.eu>

2 trivial patches: 
	- module self-dependency fix,
	- add module description.

Przemo Firszt (2):
  HID: wacom: Fix HID_WACOM self-dependency
  HID: wacom: Add module description

 drivers/hid/Kconfig     |    1 -
 drivers/hid/hid-wacom.c |    2 +-
 2 files changed, 1 insertions(+), 2 deletions(-)

-- 
1.7.9.1

