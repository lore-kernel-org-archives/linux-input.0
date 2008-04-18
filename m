From: Peter Zijlstra <dmitry.torokhov@gmail.com>
Subject: [PATCH 37/37] Input: mac_hid - add lockdep annotation to emumousebtn
Date: Fri, 18 Apr 2008 00:25:38 -0400
Message-ID: <9e7ddf905834f7b2969464a49e95eb59f4b7b03c.1208783694.git.dmitry.torokhov@gmail.com>
References: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.176]:8449 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757821AbYDUNTQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Apr 2008 09:19:16 -0400
Received: by wa-out-1112.google.com with SMTP id m16so3106305waf.23
        for <linux-input@vger.kernel.org>; Mon, 21 Apr 2008 06:19:16 -0700 (PDT)
In-Reply-To: <cover.1208783694.git.dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, jkosina@suse.cz, akpm@linux-foundation.org

The mouse button emulation calls input device methods from an input
device. This causes funny lock nesting which is harmless as each
device has its own locks.

Give the nesting device its own lock classes so that lockdep will not
consider them the same.

Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---
 drivers/macintosh/mac_hid.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/macintosh/mac_hid.c b/drivers/macintosh/mac_hid.c
index 8930230..f972ff3 100644
--- a/drivers/macintosh/mac_hid.c
+++ b/drivers/macintosh/mac_hid.c
@@ -103,6 +103,9 @@ int mac_hid_mouse_emulate_buttons(int caller, unsigned int keycode, int down)
 	return 0;
 }
 
+static struct lock_class_key emumousebtn_event_class;
+static struct lock_class_key emumousebtn_mutex_class;
+
 static int emumousebtn_input_register(void)
 {
 	int ret;
@@ -111,6 +114,9 @@ static int emumousebtn_input_register(void)
 	if (!emumousebtn)
 		return -ENOMEM;
 
+	lockdep_set_class(emumousebtn->event_lock, &emumousebtn_event_class);
+	lockdep_set_class(emumousebtn->mutex, &emumousebtn_mutex_class);
+
 	emumousebtn->name = "Macintosh mouse button emulation";
 	emumousebtn->id.bustype = BUS_ADB;
 	emumousebtn->id.vendor = 0x0001;
-- 
1.5.5.rc2.6.gf58d

