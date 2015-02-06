From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH 4/5] Input: synaptics - Remove obsolete min/max quirk for X240
Date: Fri, 6 Feb 2015 14:25:07 +0100
Message-ID: <1423229108-29268-5-git-send-email-daniel.martin@secunet.com>
References: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:41594 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754383AbbBFNTe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 08:19:34 -0500
In-Reply-To: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Daniel Martin <consume.noise@gmail.com>

From: Daniel Martin <consume.noise@gmail.com>

The firmware of the X240 (LEN0035, 2013/12) exposes the same values
    x [1232..5710], y [1156..4696]
as the quirk applies.

Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 0b7805c..0ea36ae 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -131,7 +131,7 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 		1024, 5052, 2258, 4832
 	},
 	{
-		(const char * const []){"LEN0035", "LEN0042", NULL},
+		(const char * const []){"LEN0042", NULL},
 		1232, 5710, 1156, 4696
 	},
 	{
-- 
2.2.2

