From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: My logitech wireless keyboard and mouse stop working after 3.10
 kernel
Date: Tue, 09 Jul 2013 18:26:51 +0200
Message-ID: <51DC39CB.9070508@redhat.com>
References: <CAPf1XsNNqBajqi=SZ=_gcB9dQ1RSAvMnGn981gnN7JqqdThjhQ@mail.gmail.com> <alpine.LNX.2.00.1307071153210.26857@pobox.suse.cz> <CAPf1XsMECGhdXLLm8zw9s13pOKDrWQV2aMp-vWSVrrDNvTYv5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53001 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751761Ab3GIQ1H (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Jul 2013 12:27:07 -0400
In-Reply-To: <CAPf1XsMECGhdXLLm8zw9s13pOKDrWQV2aMp-vWSVrrDNvTYv5g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: wujun zhou <zwj.echo@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, Andrew de los Reyes <adlr@chromium.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Linus Torvalds <torvalds@linux-foundation.org>

On 07/09/2013 06:44 AM, wujun zhou wrote:
> Hello Jiri,
>     Thanks for the quick reply.
> 
>> Does the keyboard/mouse get properly discovered if you unplug and replug
>> the receiver?
> No. It is still not working after replug or reboot
> 
>> What if you revert back to the 59626408 workaround (i.e. revert
>> a9dd22b730 and 8af6c0883)?
> It works after revert 8af6c08830b1ae114d1a8b548b1f8b056e068887.
> 
>> so it's either rather timing sensitive, or device-specific.
> The problem is indeed timing sensitive. Yesterday, after I inserted
> some dbg_hid() for debuging, the problem just gone,  very strange.
> 
> 
> I think for my case, I find the reason of the problem. My device do
> not report the expected  REPORT_TYPE_NOTIF_DEVICE_PAIRED(0x41). (Not
> discarded by the hid-core as mentioned in 8af6c0883, the hardware
> itself has not sent the packet.)
> Instead, the device reports a
> REPORT_TYPE_NOTIF_CONNECTION_STATUS(0x42) event, with
> dj_report->report_params[CONNECTION_STATUS_PARAM_STATUS]=0, the first
> time I move the mouse.
> And then report the normal activities of the mouse. (details about the
> usb packets can be found in the attachment.)
> 

Thanks for the logs. Your analysis is nearly good :) the problem comes
from the frame 49 and not the 50 in your pcap logs. When calling the
command REPORT_TYPE_CMD_GET_PAIRED_DEVICES (20 ff 81), we get an error
-EPIPE. That means that the receiver never got the request for him to
send the REPORT_TYPE_NOTIF_DEVICE_PAIRED(0x41).

So this bug is definitively linked to the bugs closed by commit
dcd9006b1b053c7b1cebe81333261d4fd492ffeb. There is something different
with USB 3 hubs that triggers this -EPIPE. The urb is still not ready
while it should.

I am trying a long shot here, but could you please give a test to the
following patch?

Cheers,
Benjamin


>From d73c86cff1be22e264fd857ebdc1fd16d07edaad Mon Sep 17 00:00:00 2001
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Tue, 9 Jul 2013 18:22:29 +0200
Subject: [PATCH] HID: logitech-dj: wait for URB completion before asking
 paired devices

On some USB3 boards, once the receiver is switched to the DJ mode, if
we try to directly call another SET_REPORT request, we get an error
-EPIPE.

Waiting for the command to complete fixes this.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-dj.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 5207591a..9a6ccf8 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -766,6 +766,9 @@ static int logi_dj_probe(struct hid_device *hdev,
 	/* Allow incoming packets to arrive: */
 	hid_device_io_start(hdev);
 
+	/* wait for the receiver to accept other commands */
+	hid_hw_wait(hdev);
+
 	retval = logi_dj_recv_query_paired_devices(djrcv_dev);
 	if (retval < 0) {
 		dev_err(&hdev->dev, "%s:logi_dj_recv_query_paired_devices "
-- 
1.8.3.1


