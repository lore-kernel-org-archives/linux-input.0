From: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH] Fix device_match_pattern function
Date: Thu, 20 May 2010 11:55:03 +0200
Message-ID: <1274349303-19044-1-git-send-email-sancane@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:48387 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752865Ab0ETJzM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 May 2010 05:55:12 -0400
Received: by wwb34 with SMTP id 34so101711wwb.19
        for <linux-input@vger.kernel.org>; Thu, 20 May 2010 02:55:11 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>

This patch fixes a problem adding uuids to list provided when a
driver is probed. Without this patch the same uuids were added
more than once to list and if two or more uuids were in the
same class id list only the first one was included repeatedly
---
 src/device.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 6ba1612..d0768ce 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1053,7 +1053,7 @@ static GSList *device_match_pattern(struct btd_device *device,
 			continue;
 
 		if (record_has_uuid(rec, match_uuid))
-			uuids = g_slist_append(uuids, profile_uuid);
+			uuids = g_slist_append(uuids, match_uuid);
 	}
 
 	return uuids;
-- 
1.6.3.3

