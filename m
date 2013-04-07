From: Chen Gang <gang.chen@asianux.com>
Subject: [PATCH] Drivers: HID: fix warnings: from is u16 which never < 0
Date: Sun, 07 Apr 2013 12:55:44 +0800
Message-ID: <5160FC50.6080503@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from intranet.asianux.com ([58.214.24.6]:48683 "EHLO
	intranet.asianux.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752001Ab3DGE4O (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Apr 2013 00:56:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org


  from is u16 which never < 0.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/hid/hid-icade.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-icade.c b/drivers/hid/hid-icade.c
index 09dcc04..76b5a75 100644
--- a/drivers/hid/hid-icade.c
+++ b/drivers/hid/hid-icade.c
@@ -159,7 +159,7 @@ static const struct icade_key icade_usage_table[30] = {
 
 static const struct icade_key *icade_find_translation(u16 from)
 {
-	if (from < 0 || from > ICADE_MAX_USAGE)
+	if (from > ICADE_MAX_USAGE)
 		return NULL;
 	return &icade_usage_table[from];
 }
-- 
1.7.7.6
