From: Luis Henriques <luis.henriques@canonical.com>
Subject: [PATCH 054/150] HID: clean up quirk for Sony RF receivers
Date: Tue, 26 Mar 2013 15:19:13 +0000
Message-ID: <1364311249-14454-55-git-send-email-luis.henriques@canonical.com>
References: <1364311249-14454-1-git-send-email-luis.henriques@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1364311249-14454-1-git-send-email-luis.henriques@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>, Jiri Kosina <jkosina@suse.cz>, Luis Henriques <luis.henriques@canonical.com>
List-Id: linux-input@vger.kernel.org

3.5.7.9 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: =?UTF-8?q?Fernando=20Luis=20V=C3=A1zquez=20Cao?=

commit 99d249021abd4341771523ed8dd7946276103432 upstream.

Document what the fix-up is does and make it more robust by ensuring
that it is only applied to the USB interface that corresponds to the
mouse (sony_report_fixup() is called once per interface during probing).

Cc: linux-input@vger.kernel.org
Cc: linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 drivers/hid/hid-sony.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 963bda1..4142c21 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -44,9 +44,19 @@ static __u8 *sony_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 {
 	struct sony_sc *sc = hid_get_drvdata(hdev);
 
-	if ((sc->quirks & VAIO_RDESC_CONSTANT) &&
-			*rsize >= 56 && rdesc[54] == 0x81 && rdesc[55] == 0x07) {
+	/*
+	 * Some Sony RF receivers wrongly declare the mouse pointer as a
+	 * a constant non-data variable.
+	 */
+	if ((sc->quirks & VAIO_RDESC_CONSTANT) && *rsize >= 56 &&
+	    /* usage page: generic desktop controls */
+	    /* rdesc[0] == 0x05 && rdesc[1] == 0x01 && */
+	    /* usage: mouse */
+	    rdesc[2] == 0x09 && rdesc[3] == 0x02 &&
+	    /* input (usage page for x,y axes): constant, variable, relative */
+	    rdesc[54] == 0x81 && rdesc[55] == 0x07) {
 		hid_info(hdev, "Fixing up Sony RF Receiver report descriptor\n");
+		/* input: data, variable, relative */
 		rdesc[55] = 0x06;
 	}
 
-- 
1.8.1.2
