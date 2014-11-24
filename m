From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 0/3] HID: wacom: Fix generic multitouch device handling
Date: Mon, 24 Nov 2014 15:32:11 -0800
Message-ID: <1416871934-14133-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:33328 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139AbaKXXcY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Nov 2014 18:32:24 -0500
Received: by mail-pd0-f177.google.com with SMTP id ft15so10677280pdb.36
        for <linux-input@vger.kernel.org>; Mon, 24 Nov 2014 15:32:24 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, pinglinux@gmail.com

This set of patches addresses the problems that I had getting Benjamin's
"HID generic handling" patches. Each of the patches addresses a seprate
issue I encountered:

 * Patch 1/3: The devices that I'm using have some usages outside of
   a logical or physical collection container which prevents the
   reports from being sent. I'm not sure if keying on the application
   collection is ideal, but it does do the job.

 * Patch 2/3: The devices that I'm using put their X and Y usages after
   the finger count, which prevents the (compatibility) ABS_X and
   ABS_Y axes from being initialized. This patch just guarantees that
   they'll be initialized.

 * Patch 3/3: Benjamin's original code seemed to only report data about
   the last finger in a multitouch report since information about "earlier"
   fingers would be overwritten. This patch changes the logic so that
   we immediately report field values whenever we can (there are some
   cases that we can't -- the tip/range bits appear before the contact
   identifier, so we have to store their state for a short time).

