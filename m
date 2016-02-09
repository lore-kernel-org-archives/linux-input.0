From: Antonio Ospite <ao2@ao2.it>
Subject: [RESEND PATCH 2/6] HID: lg: fix a typo in descriptors comments s/Joystik/Joystick/
Date: Tue,  9 Feb 2016 13:55:04 +0100
Message-ID: <1455022508-20041-3-git-send-email-ao2@ao2.it>
References: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:3838 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754726AbcBIMzd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Feb 2016 07:55:33 -0500
In-Reply-To: <1455022508-20041-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jikos@kernel.org>, Antonio Ospite <ao2@ao2.it>

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-lg.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index c690fae..feb2be7 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -61,7 +61,7 @@
  */
 static __u8 df_rdesc_fixed[] = {
 0x05, 0x01,         /*  Usage Page (Desktop),                   */
-0x09, 0x04,         /*  Usage (Joystik),                        */
+0x09, 0x04,         /*  Usage (Joystick),                       */
 0xA1, 0x01,         /*  Collection (Application),               */
 0xA1, 0x02,         /*      Collection (Logical),               */
 0x95, 0x01,         /*          Report Count (1),               */
@@ -127,7 +127,7 @@ static __u8 df_rdesc_fixed[] = {
 
 static __u8 dfp_rdesc_fixed[] = {
 0x05, 0x01,         /*  Usage Page (Desktop),                   */
-0x09, 0x04,         /*  Usage (Joystik),                        */
+0x09, 0x04,         /*  Usage (Joystick),                       */
 0xA1, 0x01,         /*  Collection (Application),               */
 0xA1, 0x02,         /*      Collection (Logical),               */
 0x95, 0x01,         /*          Report Count (1),               */
@@ -175,7 +175,7 @@ static __u8 dfp_rdesc_fixed[] = {
 
 static __u8 fv_rdesc_fixed[] = {
 0x05, 0x01,         /*  Usage Page (Desktop),                   */
-0x09, 0x04,         /*  Usage (Joystik),                        */
+0x09, 0x04,         /*  Usage (Joystick),                       */
 0xA1, 0x01,         /*  Collection (Application),               */
 0xA1, 0x02,         /*      Collection (Logical),               */
 0x95, 0x01,         /*          Report Count (1),               */
@@ -242,7 +242,7 @@ static __u8 fv_rdesc_fixed[] = {
 
 static __u8 momo_rdesc_fixed[] = {
 0x05, 0x01,         /*  Usage Page (Desktop),               */
-0x09, 0x04,         /*  Usage (Joystik),                    */
+0x09, 0x04,         /*  Usage (Joystick),                   */
 0xA1, 0x01,         /*  Collection (Application),           */
 0xA1, 0x02,         /*      Collection (Logical),           */
 0x95, 0x01,         /*          Report Count (1),           */
@@ -288,7 +288,7 @@ static __u8 momo_rdesc_fixed[] = {
 
 static __u8 momo2_rdesc_fixed[] = {
 0x05, 0x01,         /*  Usage Page (Desktop),               */
-0x09, 0x04,         /*  Usage (Joystik),                    */
+0x09, 0x04,         /*  Usage (Joystick),                   */
 0xA1, 0x01,         /*  Collection (Application),           */
 0xA1, 0x02,         /*      Collection (Logical),           */
 0x95, 0x01,         /*          Report Count (1),           */
-- 
2.7.0

