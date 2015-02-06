From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 6/6] Input: synaptics - Skip quirks when post-2013 dimensions
Date: Fri,  6 Feb 2015 10:44:59 -0500
Message-ID: <1423237499-2930-7-git-send-email-benjamin.tissoires@redhat.com>
References: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Martin <consume.noise@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

post-2013 Lenovo laptops provide correct min/max dimensions, which
are different with the ones currently quirked.
According to https://bugzilla.kernel.org/show_bug.cgi?id=91541
The following board ids are assigned in the post-2013 touchpads:

t440p/t440s: LEN0036 -> 2964/2962
t540p:       LEN0034 -> 2964

Using 2961 as the common minimum makes these 3 laptops OK. We may need
to update those values later if other pnp_ids has a lower board_id.

Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index b02000f..d5c120b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -147,7 +147,7 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 		(const char * const []){"LEN0034", "LEN0036", "LEN0037",
 					"LEN0039", "LEN2002", "LEN2004",
 					NULL},
-		{ANY_BOARD_ID, ANY_BOARD_ID},
+		{ANY_BOARD_ID, 2961},
 		1024, 5112, 2024, 4832
 	},
 	{
-- 
2.1.0
