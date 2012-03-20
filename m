From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: HID: Add support for Waltop Sirius Battery Free Tablet
Date: Tue, 20 Mar 2012 16:01:31 +0200
Message-ID: <1332252093-13394-1-git-send-email-spbnick@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33228 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758036Ab2CTOBs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Mar 2012 10:01:48 -0400
Received: by lbbgm6 with SMTP id gm6so56197lbb.19
        for <linux-input@vger.kernel.org>; Tue, 20 Mar 2012 07:01:47 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input <linux-input@vger.kernel.org>

These two patches add support for Waltop Sirius Battery Free Tablet.

 drivers/hid/hid-core.c          |    1 +
 drivers/hid/hid-ids.h           |    1 +
 drivers/hid/hid-input.c         |   25 +++++-
 drivers/hid/hid-waltop.c        |  189 +++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-quirks.c |    1 +
 5 files changed, 214 insertions(+), 3 deletions(-)

