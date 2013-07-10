From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH] HID: fix data access in implement()
Date: Wed, 10 Jul 2013 16:12:08 +0200
Message-ID: <51DD6BB8.9050206@gmail.com>
References: <alpine.LNX.2.00.1307092042190.26857@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15241 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751434Ab3GJOMX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Jul 2013 10:12:23 -0400
In-Reply-To: <alpine.LNX.2.00.1307092042190.26857@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: =?ISO-8859-1?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>, Gustavo Padovan <gustavo@padovan.org>, Adam Kropelin <akropel1@rochester.rr.com>, Grant Grundler <grundler@parisc-linux.org>, linux-input@vger.kernel.org

Hi Jiri,

On 07/09/2013 08:44 PM, Jiri Kosina wrote:
> implement() is setting bytes in LE data stream. In case the data
> is not aligned to 64bits, it reads past the allocated buffer. It
> doesn't really change any value there (it's properly bitmasked), but
> in case that this read past the boundary hits a page boundary, pagefault
> happens when accessing 64bits of 'x' in implement(), and kernel oopses.
> 
> This happens much more often when numbered reports are in use, as the
> initial 8bit skip in the buffer makes the whole process work on values
> which are not aligned to 64bits.
> 
> This problem dates back to attempts in 2005 and 2006 to make implement()
> and extract() as generic as possible, and even back then the problem
> was realized by Adam Kroperlin, but falsely assumed to be impossible
> to cause any harm:
> 
>   http://www.mail-archive.com/linux-usb-devel@lists.sourceforge.net/msg47690.html
> 
> I have made several attempts at fixing it "on the spot" directly in
> implement(), but the results were horrible; the special casing for processing
> last 64bit chunk and switching to different math makes it unreadable mess.
> 
> I therefore took a path to allocate a few bytes more which will never make
> it into final report, but are there as a cushion for all the 64bit math
> operations happening in implement() and extract().
> 
> All callers of hid_output_report() are converted at the same time to allocate
> the buffer by newly introduced hid_alloc_report_buf() helper.
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---

Thanks for that. It should (I hope) fix the bugs we are seeing from time
to times under Fedora and that I was not able to answer:
https://bugzilla.redhat.com/show_bug.cgi?id=965280
https://bugzilla.redhat.com/show_bug.cgi?id=927488
https://bugzilla.redhat.com/show_bug.cgi?id=881504

I have a small remark for usbhid:

>  drivers/hid/hid-core.c            |   19 ++++++++++++++++++-
>  drivers/hid/hid-logitech-dj.c     |   12 ++++++++++--
>  drivers/hid/hid-picolcd_debugfs.c |   10 +++++++++-
>  drivers/hid/usbhid/hid-core.c     |    4 ++--
>  include/linux/hid.h               |    1 +
>  net/bluetooth/hidp/core.c         |   14 +++++++++-----
>  6 files changed, 49 insertions(+), 11 deletions(-)

[snipped]

> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index 9941828..2b0b96daf 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -546,7 +546,7 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
>  			return;
>  		}
>  
> -		usbhid->out[usbhid->outhead].raw_report = kmalloc(len, GFP_ATOMIC);
> +		usbhid->out[usbhid->outhead].raw_report = hid_alloc_report_buf(report, GFP_ATOMIC);
>  		if (!usbhid->out[usbhid->outhead].raw_report) {
>  			hid_warn(hid, "output queueing failed\n");
>  			return;
> @@ -595,7 +595,7 @@ static void __usbhid_submit_report(struct hid_device *hid, struct hid_report *re
>  	}
>  
>  	if (dir == USB_DIR_OUT) {
> -		usbhid->ctrl[usbhid->ctrlhead].raw_report = kmalloc(len, GFP_ATOMIC);
> +		usbhid->ctrl[usbhid->ctrlhead].raw_report = hid_alloc_report_buf(report, GFP_ATOMIC);

line 538: int len = ((report->size - 1) >> 3) + 1 + (report->id > 0);
is not used anywhere after applying the patch. It can be dropped.

Besides the picolcd problems spotted by Bruno:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

