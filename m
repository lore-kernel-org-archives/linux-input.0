From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v2 0/7] HID: validate report details
Date: Wed,  4 Sep 2013 09:37:18 -0700
Message-ID: <1378312645-27736-1-git-send-email-keescook@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.outflux.net ([198.145.64.163]:44029 "EHLO smtp.outflux.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964890Ab3IDQhn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Sep 2013 12:37:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Henrik Rydberg <rydberg@euromail.se>

These patches introduce a validation function for HID devices that do
direct report value accesses, solving a number of heap smashing flaws.

This version changes to using an field-index-based checker for the new
"hid_validate_values()" which requires callers to loop across fields if
they use more than one field.

-Kees

