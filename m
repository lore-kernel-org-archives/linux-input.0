From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH v2 5/5] Input: synaptics - Remove obsolete min/max quirk for X240
Date: Tue, 27 Jan 2015 09:34:05 +0100
Message-ID: <1422347645-5194-6-git-send-email-daniel.martin@secunet.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
 <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:52778 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbbA0I2j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2015 03:28:39 -0500
In-Reply-To: <1422347645-5194-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: hdegoede@redhat.com, Daniel Martin <consume.noise@gmail.com>

From: Daniel Martin <consume.noise@gmail.com>

The firmware of the X240 (LEN0035, 2013/12) exposes the same values
    x [1232..5710], y [1156..4696]
as the quirk applies.

Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f6c43ff..97b0e77 100644
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

