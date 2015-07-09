From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2] HID: Wacom: Delete unnecessary checks before the function
 call "input_free_device"
Date: Thu, 9 Jul 2015 08:08:15 +0200
Message-ID: <559E0FCF.8000908@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <5479D93E.3040407@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <5479D93E.3040407@users.sourceforge.net>
Sender: kernel-janitors-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 9 Jul 2015 08:00:10 +0200

The input_free_device() function tests whether its argument is NULL and
then returns immediately. Thus the test around the call is not needed.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/hid/wacom_sys.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4c0ffca..936ad77 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -1149,12 +1149,9 @@ static void wacom_free_inputs(struct wacom *wacom)
 {
 	struct wacom_wac *wacom_wac = &(wacom->wacom_wac);
 
-	if (wacom_wac->pen_input)
-		input_free_device(wacom_wac->pen_input);
-	if (wacom_wac->touch_input)
-		input_free_device(wacom_wac->touch_input);
-	if (wacom_wac->pad_input)
-		input_free_device(wacom_wac->pad_input);
+	input_free_device(wacom_wac->pen_input);
+	input_free_device(wacom_wac->touch_input);
+	input_free_device(wacom_wac->pad_input);
 	wacom_wac->pen_input = NULL;
 	wacom_wac->touch_input = NULL;
 	wacom_wac->pad_input = NULL;
-- 
2.4.5

