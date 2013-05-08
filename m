From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCHv2] hid: remove duplicate ID for D-WAV eGalax 0x7224
Date: Wed, 08 May 2013 10:23:12 +0300
Message-ID: <1367997792.29283.23.camel@smile>
References: =?ISO-8859-1?Q?=20<1367936944-1624?= =?ISO-8859-1?Q?9-2-git-send-ema?=
	=?ISO-8859-1?Q?il-andriy.shevch?= =?ISO-8859-1?Q?enko@linux.intel?=
	=?ISO-8859-1?Q?.com=1B[B=1B[B=1B[B>?=
	 <1367937493-16844-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <51891425.5070300@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56079 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602Ab3EHHXm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 May 2013 03:23:42 -0400
In-Reply-To: <51891425.5070300@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Tue, 2013-05-07 at 16:48 +0200, Benjamin Tissoires wrote: 
> On 05/07/2013 04:38 PM, Andy Shevchenko wrote:
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> 
> I bet it will be easier to track for Jiri if you resend the full series:
> - the egalax reordering
> - the remove of the duplicate ID
> 
> As mentioned previously, also remove the entry in hid-multitouch (the
> one containing MT_CLS_EGALAX, not the _SERIAL one).

Then it repeats v1, doesn't it?

The difference between MT_USB_DEVICE and HID_USB_DEVICE macros is
in .group member. Does it somehow affect device matching?

> 
> Cheers,
> Benjamin
> 
> >  drivers/hid/hid-ids.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> > index 2378a0b..a5520ba 100644
> > --- a/drivers/hid/hid-ids.h
> > +++ b/drivers/hid/hid-ids.h
> > @@ -268,7 +268,6 @@
> >  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7207	0x7207
> >  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_720C	0x720c
> >  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
> > -#define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7224	0x7224
> >  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_722A	0x722A
> >  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_725E	0x725e
> >  #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_7262	0x7262
> > 
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
