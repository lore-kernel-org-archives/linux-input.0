From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: [PATCHES v2] Add support for more Huion tablets
Date: Wed, 23 Jul 2014 19:31:53 +0300
Message-ID: <1406133117-29243-1-git-send-email-spbnick@gmail.com>
References: <53CFC950.90703@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:60721 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758092AbaGWQcL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Jul 2014 12:32:11 -0400
Received: by mail-we0-f174.google.com with SMTP id x48so1472636wes.5
        for <linux-input@vger.kernel.org>; Wed, 23 Jul 2014 09:32:10 -0700 (PDT)
In-Reply-To: <53CFC950.90703@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, DIGImend-devel <DIGImend-devel@lists.sourceforge.net>

Hi everyone,

This is the second version of the patch set adding support for more Huion
tablets [1].

This version has the "hid: huion: Invert in-range on specific product" patch
removed as requested by Benjamin Tissoires.

Tested with Huion H610N.

Nick

[PATCH 1/4] hid: huion: Use "tablet" instead of specific model
[PATCH 2/4] hid: huion: Don't ignore other interfaces
[PATCH 3/4] hid: huion: Switch to generating report descriptor
[PATCH 4/4] hid: huion: Handle tablets with UC-Logic vendor ID

 drivers/hid/hid-core.c  |   2 +-
 drivers/hid/hid-huion.c | 265 ++++++++++++++++++++++++++++++++----------------
 drivers/hid/hid-ids.h   |   2 +-
 3 files changed, 177 insertions(+), 92 deletions(-)

[1] http://thread.gmane.org/gmane.linux.kernel.input/37187
