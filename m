From: KY Srinivasan <kys@microsoft.com>
Subject: RE: [PATCH] HID: hyperv: Cocci spatch "memdup.spatch"
Date: Mon, 3 Jun 2013 14:14:09 +0000
Message-ID: <e91f5ef1d111418e8383867c3d0c81eb@SN2PR03MB061.namprd03.prod.outlook.com>
References: <1370079631.29224.9.camel@localhost.localdomain>
 <alpine.LNX.2.00.1306031334040.6750@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devel-bounces@linuxdriverproject.org>
In-Reply-To: <alpine.LNX.2.00.1306031334040.6750@pobox.suse.cz>
Content-Language: en-US
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/devel/>
List-Post: <mailto:devel@linuxdriverproject.org>
List-Help: <mailto:devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/devel>,
 <mailto:devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: devel-bounces@linuxdriverproject.org
Sender: "devel" <devel-bounces@linuxdriverproject.org>
To: Jiri Kosina <jkosina@suse.cz>, Thomas Meyer <thomas@m3y3r.de>
Cc: "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Haiyang Zhang <haiyangz@microsoft.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org



> -----Original Message-----
> From: Jiri Kosina [mailto:jkosina@suse.cz]
> Sent: Monday, June 03, 2013 7:35 AM
> To: Thomas Meyer
> Cc: KY Srinivasan; Haiyang Zhang; devel@linuxdriverproject.org; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] HID: hyperv: Cocci spatch "memdup.spatch"
> 
> On Sat, 1 Jun 2013, Thomas Meyer wrote:
> 
> > Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
> > ---
> >
> > diff -u -p a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
> > --- a/drivers/hid/hid-hyperv.c
> > +++ b/drivers/hid/hid-hyperv.c
> > @@ -199,13 +199,11 @@ static void mousevsc_on_receive_device_i
> >  	if (desc->bLength == 0)
> >  		goto cleanup;
> >
> > -	input_device->hid_desc = kzalloc(desc->bLength, GFP_ATOMIC);
> > +	input_device->hid_desc = kmemdup(desc, desc->bLength,
> GFP_ATOMIC);
> >
> >  	if (!input_device->hid_desc)
> >  		goto cleanup;
> >
> > -	memcpy(input_device->hid_desc, desc, desc->bLength);
> > -
> >  	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
> >  	if (input_device->report_desc_size == 0) {
> >  		input_device->dev_info_status = -EINVAL;
> >
> 
> I guess you are going to get some pushback from some maintainers due to
> non-descriptive subject and missing changelog :)
> 
> I have fixed this for the hyperv patch and applied it, thanks.

Thanks Jiri!

K. Y
> 
> --
> Jiri Kosina
> SUSE Labs
> 
