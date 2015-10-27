From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 2/3] input: misc: keychord: log when keychord triggered
Date: Tue, 27 Oct 2015 09:47:56 +0100
Message-ID: <1445935676-5830-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:34930 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbbJ0IsQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Oct 2015 04:48:16 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, JP Abgrall <jpa@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: JP Abgrall <jpa@google.com>

log keychord id at info level just before waking up processes.

Signed-off-by: JP Abgrall <jpa@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/input/misc/keychord.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/input/misc/keychord.c b/drivers/input/misc/keychor=
d.c
index 3ffab6d..a5ea27a 100644
--- a/drivers/input/misc/keychord.c
+++ b/drivers/input/misc/keychord.c
@@ -126,8 +126,12 @@ static void keychord_event(struct input_handle *ha=
ndle, unsigned int type,
 done:
 	spin_unlock_irqrestore(&kdev->lock, flags);
=20
-	if (got_chord)
+	if (got_chord) {
+		pr_info("keychord: got keychord id %d. Any tasks: %d\n",
+			keychord->id,
+			!list_empty_careful(&kdev->waitq.task_list));
 		wake_up_interruptible(&kdev->waitq);
+	}
 }
=20
 static int keychord_connect(struct input_handler *handler,
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
