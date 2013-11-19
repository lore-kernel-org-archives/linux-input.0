From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv4 0/5] HID: sony: Dualshock3 USB and LED support
Date: Tue, 19 Nov 2013 20:26:27 +0100
Message-ID: <1384889192-18488-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42233 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751650Ab3KST0h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 14:26:37 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Hi,

this is a resent of the patchset "[PATCHv3 0/5] HID: sony: Dualshock3 USB FF
deadlock fix and LED support". It is necessary because the patches 2-5 of that
patchset cannot be applied anymore. This happened because the v2 of the patch
"HID: sony: Send FF commands in non-atomic context" instead of the v3 was
applied in the repository jikos/hid.git. The differences between these two
patch versions can now be found in the new patch "[PATCHv4 1/5] HID: sony:
Rename rumble_* functions/variables to state_*"

Kind regards,
	Sven

