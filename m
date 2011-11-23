From: Benjamin Tissoires <benjamin.tissoires@enac.fr>
Subject: [PATCH 4/8] hid-multitouch: remove .maxcontacts field for eGalax
Date: Wed, 23 Nov 2011 10:54:30 +0100
Message-ID: <1322042074-3759-5-git-send-email-benjamin.tissoires@enac.fr>
References: <1322042074-3759-1-git-send-email-benjamin.tissoires@enac.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1322042074-3759-1-git-send-email-benjamin.tissoires@enac.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Benjamin Tissoires <benjamin.tissoires@enac.fr>, Jiri Kosina <jkosina@suse.cz>, Stephane Chatty <chatty@lii-enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Some eGalax devices are 4 or 5 fingers touches, wereas others are 2.
This patch removes the limit in which all eGalax presents 2 touches.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@enac.fr>
---
 drivers/hid/hid-multitouch.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 8250f3c..354a5cd 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -171,7 +171,6 @@ static struct mt_class mt_classes[] = {
 	{ .name = MT_CLS_EGALAX,
 		.quirks =  MT_QUIRK_SLOT_IS_CONTACTID |
 			MT_QUIRK_VALID_IS_INRANGE,
-		.maxcontacts = 2,
 		.sn_move = 4096,
 		.sn_pressure = 32,
 	},
-- 
1.7.4.4
