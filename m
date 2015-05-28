From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH] Input: synaptics - add min/max quirk for Lenovo S540
Date: Thu, 28 May 2015 10:10:55 +1000
Message-ID: <20150528001055.GA15825@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:50742 "EHLO
	mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbbE1ALJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 May 2015 20:11:09 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, tommy.gagnes@gmail.com

https://bugzilla.redhat.com/show_bug.cgi?id=1223051#c2

Cc: stable@vger.kernel.org
Tested-by: tommy.gagnes@gmail.com
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
 drivers/input/mouse/synaptics.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 3b06c8a..907ac9b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -148,6 +148,11 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 		1024, 5112, 2024, 4832
 	},
 	{
+		(const char * const []){"LEN2000", NULL},
+		{ANY_BOARD_ID, ANY_BOARD_ID},
+		1024, 5113, 2021, 4832
+	},
+	{
 		(const char * const []){"LEN2001", NULL},
 		{ANY_BOARD_ID, ANY_BOARD_ID},
 		1024, 5022, 2508, 4832
@@ -188,7 +193,7 @@ static const char * const topbuttonpad_pnp_ids[] = {
 	"LEN0045",
 	"LEN0047",
 	"LEN0049",
-	"LEN2000",
+	"LEN2000", /* S540 */
 	"LEN2001", /* Edge E431 */
 	"LEN2002", /* Edge E531 */
 	"LEN2003",
-- 
2.4.1

