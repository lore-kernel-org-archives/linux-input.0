From: Andrew de los Reyes <andrew-vger@gizmolabs.org>
Subject: [PATCH 0/3] logitech-dj: Successfully detect attached devices during probe()
Date: Mon, 18 Feb 2013 09:20:20 -0800
Message-ID: <1361208023-11500-1-git-send-email-andrew-vger@gizmolabs.org>
References: <alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f53.google.com ([209.85.210.53]:34552 "EHLO
	mail-da0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751937Ab3BRRUc (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Feb 2013 12:20:32 -0500
Received: by mail-da0-f53.google.com with SMTP id w3so2518921dad.26
        for <linux-input@vger.kernel.org>; Mon, 18 Feb 2013 09:20:32 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1302181405240.17024@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linux Input <linux-input@vger.kernel.org>
Cc: Andrew de los Reyes <adlr@chromium.org>

From: Andrew de los Reyes <adlr@chromium.org>

This patch series includes the latest version of the patch to separate
the HID driver lock into two. It also includes the first use of the
new API provided by that patch: a change to the Logitech Unifying
Receiver driver to detect attached peripherals during probe(). With
that in, we can also revert a previous workound, which was originally
introduced when probe() stopped being able to communicate with the
device.

Andrew de los Reyes (3):
  HID: Separate struct hid_device's driver_lock into two locks.
  HID: Fix logitech-dj: Allow incoming packets during probe().
  Revert "HID: Fix logitech-dj: missing Unifying device issue"

 drivers/hid/hid-core.c        | 24 +++++++++++++++++++---
 drivers/hid/hid-logitech-dj.c | 48 +++----------------------------------------
 drivers/hid/hid-logitech-dj.h |  1 -
 include/linux/hid.h           | 46 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 69 insertions(+), 50 deletions(-)

--
1.8.1.3

