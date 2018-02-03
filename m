From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 6/6] hid-prodikeys: Rename a jump label in pcmidi_send_note()
Date: Sat, 3 Feb 2018 18:42:51 +0100
Message-ID: <5f63f181-2b5a-911e-996c-6918e277a484@users.sourceforge.net>
References: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:60849 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752235AbeBCRm7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 3 Feb 2018 12:42:59 -0500
In-Reply-To: <c388b4d8-fa43-1bf2-e27d-1a3a8d636118@users.sourceforge.net>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 3 Feb 2018 18:10:00 +0100

An other label fits better to the jump target. Thus rename it.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/hid-prodikeys.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-prodikeys.c b/drivers/hid/hid-prodikeys.c
index 1c62dddedd40..4596d97b61eb 100644
--- a/drivers/hid/hid-prodikeys.c
+++ b/drivers/hid/hid-prodikeys.c
@@ -228,11 +228,11 @@ static void pcmidi_send_note(struct pcmidi_snd *pm,
 
 	if (!pm->in_substream ||
 	    !test_bit(pm->in_substream->number, &pm->in_triggered))
-		goto drop_note;
+		goto unlock;
 
 	snd_rawmidi_receive(pm->in_substream, buffer, 3);
 
-drop_note:
+unlock:
 	spin_unlock_irqrestore(&pm->rawmidi_in_lock, flags);
 }
 
-- 
2.16.1

