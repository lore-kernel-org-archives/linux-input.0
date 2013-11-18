From: Sven Eckelmann <sven@narfation.org>
Subject: [PATCHv3 0/5] HID: sony: Dualshock3 USB FF deadlock fix and LED support
Date: Mon, 18 Nov 2013 21:42:31 +0100
Message-ID: <1384807356-15561-1-git-send-email-sven@narfation.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from narfation.org ([79.140.41.39]:42165 "EHLO v3-1039.vlinux.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751064Ab3KRUnM (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Nov 2013 15:43:12 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>

Hi,

this replaces the previously sent patches:

 * [PATCH] Revert "HID: sony: Add force feedback support for Dualshock3 USB"
 * [PATCHv2] HID: sony: Send FF commands in non-atomic context

I've resent the first patch again as v3 because some function/variable names
were changed to better integrate in the LED support patches. It is sent as part
of this patchset because these changes require the sony_state_worker to change
the state of the LEDs.

Kind regards,
	Sven

