From: Matthew Garrett <mjg@redhat.com>
Subject: [PATCH 2/3] input: Add a PNP entry to the aux device list
Date: Fri, 14 May 2010 12:10:02 -0400
Message-ID: <1273853403-2870-2-git-send-email-mjg@redhat.com>
References: <1273853403-2870-1-git-send-email-mjg@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1273853403-2870-1-git-send-email-mjg@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-input@vger.kernel.org

Windows checks for an ALPS PS/2 device in PNP. Add it on the off-chance
that there's a machine that expresses this without also providing a
compatibility ID.

Signed-off-by: Matthew Garrett <mjg@redhat.com>
---
 drivers/input/serio/i8042-x86ia64io.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
index 871a74c..6168469 100644
--- a/drivers/input/serio/i8042-x86ia64io.h
+++ b/drivers/input/serio/i8042-x86ia64io.h
@@ -685,6 +685,7 @@ static struct pnp_driver i8042_pnp_kbd_driver = {
 };
 
 static struct pnp_device_id pnp_aux_devids[] = {
+	{ .id = "AUI0200", .driver_data = 0 },
 	{ .id = "FJC6000", .driver_data = 0 },
 	{ .id = "FJC6001", .driver_data = 0 },
 	{ .id = "PNP0f03", .driver_data = 0 },
-- 
1.7.0.1
