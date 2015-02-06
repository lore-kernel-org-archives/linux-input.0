From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v4 4/6] Input: synaptics - Remove obsolete min/max quirk for X240
Date: Fri,  6 Feb 2015 10:44:57 -0500
Message-ID: <1423237499-2930-5-git-send-email-benjamin.tissoires@redhat.com>
References: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423237499-2930-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Martin <consume.noise@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

From: Daniel Martin <consume.noise@gmail.com>

The firmware of the X240 (LEN0035, 2013/12) exposes the same values
    x [1232..5710], y [1156..4696]
as the quirk applies.

Cc: stable@vger.kernel.org
Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 19dc87f..359e26d 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -134,7 +134,7 @@ static const struct min_max_quirk min_max_pnpid_table[] = {
 		1024, 5052, 2258, 4832
 	},
 	{
-		(const char * const []){"LEN0035", "LEN0042", NULL},
+		(const char * const []){"LEN0042", NULL},
 		1232, 5710, 1156, 4696
 	},
 	{
-- 
2.1.0
