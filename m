From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/6] hid-prodikeys: Delete an unnecessary return statement in
 pcmidi_send_note()
Date: Sat, 3 Feb 2018 18:40:50 +0100
Message-ID: <92011980-048c-f44b-a064-d2a917b2f51a@users.sourceforge.net>
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 17:33:40 +0100

The script "checkpatch.pl" pointed information out like the following.

WARNING: void function return statements are not generally useful

Thus remove such a statement in the affected function.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 7672f723b268..c9eae92ad429 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -235,8 +235,6 @@ static void pcmidi_send_note(struct pcmidi_snd *pm,
 
 drop_note:
 	spin_unlock_irqrestore(&pm->rawmidi_in_lock, flags);
-
-	return;
 }
 
 static void pcmidi_sustained_note_release(struct timer_list *t)
-- 
2.16.1

