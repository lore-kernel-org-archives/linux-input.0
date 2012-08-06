From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC ebeam PATCH v3 1/2] hid: Blacklist new eBeam classic device
Date: Mon, 06 Aug 2012 15:07:46 -0700
Message-ID: <1975621.3ErbANJ9at@dtor-d630.eng.vmware.com>
References: <1344288104-20731-1-git-send-email-yann.cantin@laposte.net> <1344288104-20731-2-git-send-email-yann.cantin@laposte.net> <20120806214340.GA30355@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:38264 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755808Ab2HFWIB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 Aug 2012 18:08:01 -0400
In-Reply-To: <20120806214340.GA30355@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Yann Cantin <yann.cantin@laposte.net>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, August 06, 2012 02:43:40 PM Greg KH wrote:
> On Mon, Aug 06, 2012 at 11:21:43PM +0200, Yann Cantin wrote:
> > Signed-off-by: Yann Cantin <yann.cantin@laposte.net>
> > ---
> > 
> >  drivers/hid/hid-core.c |    3 +++
> >  drivers/hid/hid-ids.h  |    3 +++
> >  2 files changed, 6 insertions(+)
> > 
> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> > index 60ea284..b1ed8ee 100644
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -1908,6 +1908,9 @@ static const struct hid_device_id hid_ignore_list[]
> > = {> 
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20)
> >  	},
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
> >  	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
> > 
> > +#if defined(CONFIG_INPUT_EBEAM_USB)
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_EFI, USB_DEVICE_ID_EFI_CLASSIC) },
> > +#endif
> 
> Why is this #if in here?  Just always do it, how could it not be
> defined?

User might disable the driver and CONFIG_INPUT_EBEAM_USB will not be
set. But I agree, since the device is unusable with generic HID driver
there is no point in doing this conditionally.

-- 
Dmitry
