From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] HID: prodikeys, remove unused variable
Date: Tue,  5 May 2015 10:09:53 +0200
Message-ID: <1430813393-28661-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:54080 "EHLO
	ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752822AbbEEIJ4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 5 May 2015 04:09:56 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

'key' is set but never used in the first loop. So remove the set.

And indent the re-set of pm->last_key properly.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/hid/hid-prodikeys.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 91fab975063c..e3e98ccf137b 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -395,11 +395,10 @@ static int pcmidi_handle_report4(struct pcmidi_snd *pm, u8 *data)
 
 	/* break keys */
 	for (bit_index = 0; bit_index < 24; bit_index++) {
-		key = pm->last_key[bit_index];
 		if (!((0x01 << bit_index) & bit_mask)) {
 			input_event(pm->input_ep82, EV_KEY,
 				pm->last_key[bit_index], 0);
-				pm->last_key[bit_index] = 0;
+			pm->last_key[bit_index] = 0;
 		}
 	}
 
-- 
2.3.5

