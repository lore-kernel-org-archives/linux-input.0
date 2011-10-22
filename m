From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/3] Input: Add new ABS_WHEEL2 axis
Date: Fri, 21 Oct 2011 18:35:50 -0700
Message-ID: <1319247352-2006-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f42.google.com ([209.85.210.42]:39632 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738Ab1JVBgJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Oct 2011 21:36:09 -0400
Received: by pzk36 with SMTP id 36so10922996pzk.1
        for <linux-input@vger.kernel.org>; Fri, 21 Oct 2011 18:36:08 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jason Gerecke <killertofu@gmail.com>

Provides a new ABS_WHEEL2 axis in input.h for use by drivers who
need to represent hardware with dual wheels.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 include/linux/input.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/input.h b/include/linux/input.h
index 6d5eddb..117c68d 100644
--- a/include/linux/input.h
+++ b/include/linux/input.h
@@ -768,6 +768,7 @@ struct input_keymap_entry {
 #define ABS_TILT_X		0x1a
 #define ABS_TILT_Y		0x1b
 #define ABS_TOOL_WIDTH		0x1c
+#define ABS_WHEEL2		0x1d
 
 #define ABS_VOLUME		0x20
 
-- 
1.7.6

