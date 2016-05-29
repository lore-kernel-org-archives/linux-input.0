From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: [PATCH] hid-sony: Prevent crash when rumble effects are still loaded
 at USB disconnect
Date: Sun, 29 May 2016 14:11:24 +0200
Message-ID: <a9a2689b-5af7-9676-67fd-5d911fcc9501@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:49330 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932137AbcE2MLe (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 29 May 2016 08:11:34 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>
Cc: jikos@kernel.org

Hello,

I had a deeper look at the kernel panic, happening if there are rumble 
effects loaded and the USB plug is pulled.

The reason for this is similar to the one, I fixed in uinput some days ago.

In "sony_remove" the memory for "output_report_dmabuf" is freed.
Then, a few lines later, "hid_hw_stop" is called.
This now tries to cleanup and causes ff_memless to try to send out a new 
rumble event which should turn both motor speeds to zero.
To get this processed, "sc->send_output_report" is called, which, for 
example, ends up in "dualshock4_send_output_report".
This function will now use the, already freed, "output_report_dmabuf".

My patch zeroes out "output_report_dmabuf" after freeing and checks for 
this in the "send_output_report" functions. There may be other ways to 
fix this, so please tell me if you prefer some other way.

I've added a one-line comment above the memory pointer check, as, in my 
opinion, it is not obvious what is happening here.

Signed-off-by: Manuel Reimer <mail@m-reimer.de>

--- a/drivers/hid/hid-sony.c	2016-05-13 16:13:00.339346161 +0200
+++ b/drivers/hid/hid-sony.c	2016-05-29 13:54:25.452029787 +0200
@@ -1809,6 +1809,10 @@ static void sixaxis_send_output_report(s
  		(struct sixaxis_output_report *)sc->output_report_dmabuf;
  	int n;

+	/* If called via hid_hw_stop, then our memory is already gone! */
+	if (!report)
+		return;
+
  	/* Initialize the report with default values */
  	memcpy(report, &default_report, sizeof(struct sixaxis_output_report));

@@ -1853,6 +1857,10 @@ static void dualshock4_send_output_repor
  	__u8 *buf = sc->output_report_dmabuf;
  	int offset;

+	/* If called via hid_hw_stop, then our memory is already gone! */
+	if (!buf)
+		return;
+
  	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
  		memset(buf, 0, DS4_REPORT_0x05_SIZE);
  		buf[0] = 0x05;
@@ -1899,6 +1907,10 @@ static void motion_send_output_report(st
  	struct motion_output_report_02 *report =
  		(struct motion_output_report_02 *)sc->output_report_dmabuf;

+	/* If called via hid_hw_stop, then our memory is already gone! */
+	if (!report)
+		return;
+
  	memset(report, 0, MOTION_REPORT_0x02_SIZE);

  	report->type = 0x02; /* set leds */
@@ -2426,6 +2438,7 @@ static void sony_remove(struct hid_devic
  	sony_cancel_work_sync(sc);

  	kfree(sc->output_report_dmabuf);
+	sc->output_report_dmabuf = NULL;

  	sony_remove_dev_list(sc);

