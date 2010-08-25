From: Mike Auty <ikelos@gentoo.org>
Subject: [PATCH 2.6.35.3] wacom: Fix mousewheel up/down regression for old
 wacom tablets
Date: Wed, 25 Aug 2010 19:10:00 +0100
Message-ID: <4C755C78.4000801@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:35544 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776Ab0HYSKJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Aug 2010 14:10:09 -0400
Received: from [192.168.188.1] (82-71-33-97.dsl.in-addr.zen.co.uk [82.71.33.97])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C2AFC1B4073
	for <linux-input@vger.kernel.org>; Wed, 25 Aug 2010 18:10:05 +0000 (UTC)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

This fixes a regression introduced in
3b57ca0f80c5c8994b5b1e3d3f904cfe727951f2.

The data[6] byte contains either 1 or -1 depending on the whether the
mouse wheel on older wacom tablets is moved down (1) or up (-1).  The
patch introduced in the above commit changed the cast from (signed char)
to (signed).  When cast as a signed integer and negated, the value of -1
(stored in the byte as 0xff) became -255 rather than 1.  This patch
reverts the cast to a (signed char) and also removes an unnecessary
(signed) cast, as all the values operated on are bitmasked.

Signed-off-by: Mike Auty <ikelos@gentoo.org>
Reviewed-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 415f630..d1a883d 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -210,10 +210,10 @@ static int wacom_graphire_irq(struct wacom_wac *wacom)
 			if (features->type == WACOM_G4 ||
 					features->type == WACOM_MO) {
 				input_report_abs(input, ABS_DISTANCE, data[6] & 0x3f);
-				rw = (signed)(data[7] & 0x04) - (data[7] & 0x03);
+				rw = (data[7] & 0x04) - (data[7] & 0x03);
 			} else {
 				input_report_abs(input, ABS_DISTANCE, data[7] & 0x3f);
-				rw = -(signed)data[6];
+				rw = -(signed char)data[6];
 			}
 			input_report_rel(input, REL_WHEEL, rw);
 		}
-- 
1.7.2.2
