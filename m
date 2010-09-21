From: Kenneth Waters <kwwaters@gmail.com>
Subject: [PATCH] input: joydev: Fix JSIOCSAXMAP ioctl.
Date: Mon, 20 Sep 2010 23:51:25 -0700
Message-ID: <1285051885-20417-1-git-send-email-kwwaters@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: steve@sk2.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kenneth Waters <kwwaters@gmail.com>
List-Id: linux-input@vger.kernel.org

Fixed JSIOCSAXMAP ioctl to update absmap, the map from hardware axis to
event axis in addition to abspam.  This fixes a regression introduced
by 999b874f.

Signed-off-by: Kenneth Waters <kwwaters@gmail.com>
---
 drivers/input/joydev.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
index d85bd8a..22239e9 100644
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -483,6 +483,9 @@ static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
 
 	memcpy(joydev->abspam, abspam, len);
 
+	for (i = 0; i < joydev->nabs; i++)
+		joydev->absmap[joydev->abspam[i]] = i;
+
  out:
 	kfree(abspam);
 	return retval;
-- 
1.7.2.2
