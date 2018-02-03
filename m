From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 5/6] hid-prodikeys: Combine two condition checks into one
 statement in pcmidi_send_note()
Date: Sat, 3 Feb 2018 18:41:49 +0100
Message-ID: <9a241420-d47e-97ae-3d95-4fd59eda92ad@users.sourceforge.net>
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
Date: Sat, 3 Feb 2018 18:00:06 +0100

The same label was used by goto statements after two condition checks.
Thus use a single statement instead.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index c9eae92ad429..1c62dddedd40 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -226,9 +226,8 @@ static void pcmidi_send_note(struct pcmidi_snd *pm,
 
 	spin_lock_irqsave(&pm->rawmidi_in_lock, flags);
 
-	if (!pm->in_substream)
-		goto drop_note;
-	if (!test_bit(pm->in_substream->number, &pm->in_triggered))
+	if (!pm->in_substream ||
+	    !test_bit(pm->in_substream->number, &pm->in_triggered))
 		goto drop_note;
 
 	snd_rawmidi_receive(pm->in_substream, buffer, 3);
-- 
2.16.1

