From: Cameron Gutman <aicommander@gmail.com>
Subject: Re: [PATCH v3] hid-sony: Prevent crash when rumble effects are still
 loaded at USB disconnect
Date: Sat, 11 Jun 2016 12:37:08 -0500
Message-ID: <575C4C44.4070401@gmail.com>
References: <a9a2689b-5af7-9676-67fd-5d911fcc9501@m-reimer.de>
 <856C5FBA-EA87-4D24-BB29-433FF5437518@gmail.com>
 <d9be52d5-7aed-4852-a339-18eea3d346ed@m-reimer.de>
 <01146ebc-3710-e3cd-812a-ca4f0ef84372@m-reimer.de>
 <768f4bf0-4b8d-7036-7ddd-1dc9ff4a171b@m-reimer.de>
 <650C9404-0604-4783-B8AC-A7FEC9A73676@gmail.com>
 <29a17dba-d98d-65a1-5949-2b74e00ecdf5@m-reimer.de>
 <a5670e69-cd2b-36c1-a3b6-5a11afedc16d@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:36295 "EHLO
	mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751182AbcFKRhL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 11 Jun 2016 13:37:11 -0400
Received: by mail-oi0-f66.google.com with SMTP id d132so18464951oig.3
        for <linux-input@vger.kernel.org>; Sat, 11 Jun 2016 10:37:11 -0700 (PDT)
In-Reply-To: <a5670e69-cd2b-36c1-a3b6-5a11afedc16d@m-reimer.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <mail+linux-input@m-reimer.de>
Cc: linux-input <linux-input@vger.kernel.org>, jikos@kernel.org



On 06/11/2016 05:00 AM, Manuel Reimer wrote:
> Hello,
> 
> I did some more testing. Now I added printk messages to start and end of ml_effect_timer and to hl_ff_destroy. Result:
> 
> [  513.493511] ml_effect_timer start
> [  513.746964] ml_effect_timer end
> [  515.107003] hid-sony: Sending to uninitialized device failed!
> [  515.333520] hid-sony: Sending to uninitialized device failed!
> [  515.415381] hid-sony: Sending to uninitialized device failed!
> [  520.476860] ml_effect_timer start
> [  520.677003] BUG: unable to handle kernel NULL pointer dereference at 00000000000000d8
> 
> The hid-sony messages are created by my last patch to fix the hid-sony driver. They show that some sending attempts have been cancelled, as the device is about to be destroyed.
> 
> Quite some time after that there in fact is another attempt to call ml_effect_timer, so the timer still was active. Tomorrow I'll add additional printk lines to the hid-sony destroy function to see if this finished executing before this unwanted timer call arrives.
> 
> This also shows that ml_ff_destroy is not the right place to cancel the timer. ml_ff_destroy is called as soon as I exit fftest. It is not called at all on USB disconnect.
> 
> I now guess this can also be reproduced with the xpad driver, but it requires some fiddling with fftest. It took me ten minutes this time to get the bug triggered. I think the way to trigger the bug is to start effect 5 and shortly after that effect 4. With some luck the USB plug is pulled before event 4 is actually started.
> 

Can you try applying the following patch on a clean source tree and see if it resolves your issue?

diff --git a/drivers/input/ff-memless.c b/drivers/input/ff-memless.c
index fcc6c33..6366e9a 100644
--- a/drivers/input/ff-memless.c
+++ b/drivers/input/ff-memless.c
@@ -501,6 +501,7 @@ static void ml_ff_destroy(struct ff_device *ff)
 {
        struct ml_device *ml = ff->private;
 
+       del_timer_sync(&ml->timer);
        kfree(ml->private);
 }

