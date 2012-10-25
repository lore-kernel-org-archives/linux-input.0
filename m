From: =?big5?B?vEK5xcJA?= <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
Subject: RE: [PATCH v2] Support Elan Touchscreen eKTF product.
Date: Thu, 25 Oct 2012 12:32:39 +0800
Message-ID: <EA73774BB37B4F518A6EA9926BB96304@elan.corp>
References: <20121024181323.GA18122@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121024181323.GA18122-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: 'Dmitry Torokhov' <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Benjamin Tissoires' <benjamin.tissoires-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, 'Jesse' <jesse-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, 'Vincent Wang' <vincent.wang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>, 'Paul' <paul.liang-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,
	Thanks for review.

> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org]
> Sent: Thursday, October 25, 2012 2:13 AM
> To: Scott Liu
> Cc: linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> Benjamin Tissoires; Jesse; Vincent Wang; Paul
> Subject: Re: [PATCH v2] Support Elan Touchscreen eKTF product.
> 
> Hi Scott,
> 
> On Wed, Oct 24, 2012 at 09:41:43AM +0800, Scott Liu wrote:
> > This patch is for Elan eKTF Touchscreen product, I2C adpater module.
> >
> > Signed-off-by: Scott Liu <scott.liu-9cfG7bMpBgR9nmWX13WWKA@public.gmane.org>
> > ---
> >
> > Hi,
> >         v2 revision I have fixed some bug as your advise.
> >         1. To target the mainline
> >         2. No Android dependency
> >         3. reuse those duplication code from Henrik's patchset.
> >                 (input_mt_sync_frame()  / input_mt_get_slot_by_key())
> 
> Just a quick run through the code, so:
> 
> - please remove polling support, it is not useful in production;

OK.

> - why do you need a separate probe work instead of doing what you
>   need in elants_probe()

will fix.

> - it is not a good idea to register input device first and then
>   allocating memory for MT handling.

Ooop...will fix.

> - I do not understand why kfifo is needed

The firmware and the host would conflict by read command and finger report
simultaneously. So I'm simply using kfifo in IRQ thread function.

* read command: writing 4 bytes commands and the device asserts GPIO
interrupt and then response 4 bytes data.

There was an error if we do not use kfifo:
	With heavy loading by finger report / read command, the driver may
get finger report as response data.

So, do you understand my meaning? 

> - please remove the rest of the custom threads
OK

> - you do not need to call input_mt_destroy_slots() explicitly
OK
> - use request_firmware() instead of special character device to upload
>   firmware.
OK, but I'll remove firmware update function at this patch first.

> - please use standard kernel-doc markup.
> - consider what attributes are there only for debugging and move them to
>   debugfs.
OK.

> - I find the use of enums in this driver quite unconventional, just
>   standard #defines would probably be more straightforward.
OK.

Thanks,
Scott

> 
> Thanks.
> 
> --
> Dmitry
