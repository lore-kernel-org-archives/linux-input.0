From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH 5/6] Input: synaptics - Add PnP id for X1 Carbon 1nd
Date: Thu, 22 Jan 2015 17:46:40 +0100
Message-ID: <1421945201-1528-6-git-send-email-daniel.martin@secunet.com>
References: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:59072 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752609AbbAVQlP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 22 Jan 2015 11:41:15 -0500
In-Reply-To: <1421945201-1528-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Daniel Martin <consume.noise@gmail.com>

From: Daniel Martin <consume.noise@gmail.com>

This adds the PnP id (LEN0030) for the X1 Carbon 1nd (2013/07) to the
list of known PnP ids.

The firmware exposes the correct dimensions:
    x [1264..5678], y [1124..4732].

Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7f6e004..70480c0 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -161,6 +161,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN002C",
 	"LEN002D",
 	"LEN002E",
+	"LEN0030", /* X1 Carbon 1nd */
 	"LEN0033", /* Helix */
 	"LEN0034", /* T431s, L440, L540, T540, W540, X1 Carbon 2nd */
 	"LEN0035", /* X240 */
-- 
2.2.2

