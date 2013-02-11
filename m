From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: hid-logitech-dj: 046d:c52b Problems using Logitech Unifying Receiver
Date: Mon, 11 Feb 2013 19:35:58 +0100
Message-ID: <51193A0E.80306@gmail.com>
References: <51180E99.10208@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:58367 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758785Ab3BKSge (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 13:36:34 -0500
Received: by mail-we0-f174.google.com with SMTP id r6so5074225wey.33
        for <linux-input@vger.kernel.org>; Mon, 11 Feb 2013 10:36:32 -0800 (PST)
In-Reply-To: <51180E99.10208@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bob Bowles <bobjohnbowles@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Nestor Lopez Casado <nestor_lopez@logitech.com>

Hi Bob,

adding in CC Jiri, the HID maintainer and Nestor, the author of hid-logitech-dj.

First, thanks for putting this upstream. After ~130 comments on the two bugs, you are the first to report it on the proper mailing list.

On Sun, Feb 10, 2013 at 10:18 PM, Bob Bowles <bobjohnbowles@gmail.com> wrote:
> bob@bobDell:/$ # Launchpad Short Description:
> 046d:c52b Problems using Logitech Unifying Receiver
>
>
> bob@bobDell:/$ # Launchpad Long Description:
>
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1072082
>
> Commit that caused the regression 534a7b8e10ec55d9f521e68c20dbb3634c25b98a.
>
> I recently purchased a new Logitech K350 keyboard (UK layout) and M505
> mouse, both of which use the Logitech Unifying Receiver. I 'paired' the
> keyboard and mouse to the receiver by using the proprietary Logitech
> 'Setpoint' software on a friend's computer running Windows XP. On their
> computer, the receiver, keyboard and mouse worked perfectly.
>
> I then moved the receiver to my own computer, a new Dell Inspiron 7520 SE
> running under Ubuntu 12.04.1. I tried with no success to get the keyboard
> and mouse to work by repeatedly unplugging and re-plugging the receiver, and
> by re-booting the machine.

According to Nestor, there are some known problems with 2.4GHz receivers and USB3.
Intel even posted a document explaining those problems:

http://www.intel.com/content/www/us/en/io/universal-serial-bus/usb3-frequency-interference-paper.html

So the problem either comes from a bad firmware (which I doubt) or from those interferences, leading to a hardware failure.

>
> I experimented with solutions posted on the web, in particular in this
> thread on Ask Ubuntu
> (http://askubuntu.com/questions/128345/logitech-m515-does-not-work-after-upgrade-to-12-04/202627#202627).
> The accepted answer did not solve my problem.
>
> WORKAROUND:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1072082/+attachment/3415472/+files/mousefix
> running this workaround script on the command line enabled the receiver. I
> added the script to crontab as suggested. The script does not cause the
> receiver to work after a reboot, but I found that a single unplug/replug
> cycle was now sufficient to restore operation of the keyboard and mouse.

If your workaround "works", then we can maybe try something on the hid-logitech-dj module to force re-probing devices in case of a USB3 failure.
Could you please test the patch at the end of this file?


>
> Potential duplicate of
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1039143 .

This bugs was filled last August, and no one reported it upstream... I was starting getting angry, but I had a quick look at the kernel's bugzilla, and I noticed that the same kind of bug was filled last October:
https://bugzilla.kernel.org/show_bug.cgi?id=49781

Anyway, here is the patch:


From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Date: Mon, 11 Feb 2013 19:26:24 +0100
Subject: [PATCH] HID: logitech-dj: do not leave in case of -EPIPE during probe()

USB3 introduced a lot of interferences with 2.4GHz receivers [1].
This fix aims at considering error -EPIPE as non fatal, so that
if further notifications comes if the interferences are less problematic,
the receiver will still query the associated devices.

[1] http://www.intel.com/content/www/us/en/io/universal-serial-bus/usb3-frequency-interference-paper.html

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/hid-logitech-dj.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 3cf62be..174fcf8 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -804,9 +804,16 @@ static int logi_dj_probe(struct hid_device *hdev,
 
 	retval = logi_dj_recv_query_paired_devices(djrcv_dev);
 	if (retval < 0) {
-		dev_err(&hdev->dev, "%s:logi_dj_recv_query_paired_devices "
-			"error:%d\n", __func__, retval);
-		goto logi_dj_recv_query_paired_devices_failed;
+		if (retval != -EPIPE) {
+			dev_err(&hdev->dev, "%s:"
+				"logi_dj_recv_query_paired_devices "
+				"error:%d\n", __func__, retval);
+			goto logi_dj_recv_query_paired_devices_failed;
+		}
+		dev_err(&hdev->dev, "%s: pipe stalled when probing for "
+			"associated devices, registering them later\n",
+			__func__);
+		retval = 0;
 	}
 
 	return retval;
-- 
1.8.1.2

Cheers,
Benjamin
