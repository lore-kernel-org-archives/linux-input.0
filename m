From: Paul Sbarra <sbarra.paul@gmail.com>
Subject: [PATCH 2/3] hid: Split accel, brake for Logitech Driving Force wheel
Date: Sat,  2 Feb 2013 14:45:24 -0600
Message-ID: <1359837925-6383-2-git-send-email-sbarra.paul@gmail.com>
References: <1359837925-6383-1-git-send-email-sbarra.paul@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359837925-6383-1-git-send-email-sbarra.paul@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Sbarra <sbarra.paul@gmail.com>
List-Id: linux-input@vger.kernel.org

Conflicts:
	drivers/hid/hid-lg.c

Signed-off-by: Paul Sbarra <sbarra.paul@gmail.com>
---
 drivers/hid/hid-lg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
index 9312a62..4bc0e1b 100644
--- a/drivers/hid/hid-lg.c
+++ b/drivers/hid/hid-lg.c
@@ -79,7 +79,6 @@ static __u8 df_rdesc_fixed[] = {
 0x09, 0x01,         /*          Usage (?: 1),                   */
 0x81, 0x02,         /*          Input (Variable),               */
 0x05, 0x01,         /*          Usage Page (Desktop),           */
-0x09, 0x31,         /*          Usage (Y),                      */
 0x26, 0xFF, 0x00,   /*          Logical Maximum (255),          */
 0x46, 0xFF, 0x00,   /*          Physical Maximum (255),         */
 0x95, 0x01,         /*          Report Count (1),               */
@@ -99,11 +98,14 @@ static __u8 df_rdesc_fixed[] = {
 0x25, 0x01,         /*          Logical Maximum (1),            */
 0x45, 0x01,         /*          Physical Maximum (1),           */
 0x81, 0x02,         /*          Input (Variable),               */
-0x95, 0x02,         /*          Report Count (2),               */
+0x05, 0x01,         /*          Usage Page (Desktop),           */
+0x95, 0x01,         /*          Report Count (1),               */
 0x75, 0x08,         /*          Report Size (8),                */
 0x26, 0xFF, 0x00,   /*          Logical Maximum (255),          */
 0x46, 0xFF, 0x00,   /*          Physical Maximum (255),         */
-0x09, 0x02,         /*          Usage (?: 2),                   */
+0x09, 0x31,         /*          Usage (Y),                      */
+0x81, 0x02,         /*          Input (Variable),               */
+0x09, 0x35,         /*          Usage (Rz),                     */
 0x81, 0x02,         /*          Input (Variable),               */
 0xC0,               /*      End Collection,                     */
 0xA1, 0x02,         /*      Collection (Logical),               */
-- 
1.8.1.1
