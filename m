From: Luis Henriques <luis.henriques@canonical.com>
Subject: [ 3.5.y.z extended stable ] Patch "HID: clean up quirk for Sony RF
 receivers" has been added to staging queue
Date: Thu, 21 Mar 2013 13:47:46 +0000
Message-ID: <1363873666-21289-1-git-send-email-luis.henriques@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kernel-team-bounces@lists.ubuntu.com>
List-Unsubscribe: <https://lists.ubuntu.com/mailman/options/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=unsubscribe>
List-Archive: <https://lists.ubuntu.com/archives/kernel-team>
List-Post: <mailto:kernel-team@lists.ubuntu.com>
List-Help: <mailto:kernel-team-request@lists.ubuntu.com?subject=help>
List-Subscribe: <https://lists.ubuntu.com/mailman/listinfo/kernel-team>,
 <mailto:kernel-team-request@lists.ubuntu.com?subject=subscribe>
Errors-To: kernel-team-bounces@lists.ubuntu.com
Sender: kernel-team-bounces@lists.ubuntu.com
To: Fernando Luis Vazquez Cao <fernando_b1@lab.ntt.co.jp>
Cc: Jiri Kosina <jkosina@suse.cz>, Fernando Luis Vazquez Cao <fernando@oss.ntt.co.jp>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@lists.ubuntu.com, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This is a note to let you know that I have just added a patch titled

    HID: clean up quirk for Sony RF receivers

to the linux-3.5.y-queue branch of the 3.5.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.5.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.5.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

>From 1d7c6a65f33945a0354a4ffb93ff341b74719496 Mon Sep 17 00:00:00 2001
From: Fernando Luis Vazquez Cao <fernando_b1@lab.ntt.co.jp>
Date: Tue, 22 Jan 2013 15:20:38 +0900
Subject: [PATCH] HID: clean up quirk for Sony RF receivers

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
