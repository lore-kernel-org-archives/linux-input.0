From: Lauri Kasanen <cand@gmx.com>
Subject: Re: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers
Date: Sat, 7 Feb 2015 23:48:01 +0200
Message-ID: <20150207234801.262dbe4f.cand@gmx.com>
References: <20150207154859.89a7e4e3.cand@gmx.com>
	<CAN+gG=EOf4di64EpXADRsQJ7_PTeH+9G=2TFN5-5mgMmcrk4qw@mail.gmail.com>
	<20150207173133.0eda1917cbb26834f1885aa9@ao2.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:58426 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756016AbbBGVpr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Feb 2015 16:45:47 -0500
In-Reply-To: <20150207173133.0eda1917cbb26834f1885aa9@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ao2@ao2.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, AndrewD207@aol.com, benjamin.tissoires@gmail.com

Hi,

On Sat, 7 Feb 2015 17:31:33 +0100
Antonio Ospite <ao2@ao2.it> wrote:
> > > +#include <linux/usb/input.h>
> > 
> > Please don't.
> > HID should be transport agnostic, so please refrain from directly call usb.
> >
> 
> I agree with Benjamin here.
> 
> > > +
> > > +       ret = usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
> > > +                               buf2, sizeof(buf2),
> > > +                               &transfered, USB_CTRL_SET_TIMEOUT);
> > 
> > Can't you simply use a hid_hw_output_report request instead of hard
> > coding the device specific endpoint?
> > And I'd also prefer it to be guarded against your specific controller.
> > 
> 
> usb_interrupt_msg() is called in usbhid_output_report() indeed, so it
> should be possible to use the generic HID interface.

Regarding the USB. This is a comment from Andrew's patch:

// doesn't work. gets sent as a SET_REPORT Request intstead of a
// URB_INTERRUPT out. I guess usbhid->urbout is null
//if ( hdev->hid_output_raw_report(hdev, buf2, sizeof(buf2),

I took his word for it, and did not attempt it. Do you think it would
work with the current kernel? If so, I can test later. Had quite an
enjoyable evening playing some FF7 once I had the controller working ;)

Antonio, others, can you test with official Sony controllers that the
current patch did not break them? I only have the Gasia.

> > > +       if (ret < 0)
> > > +               hid_err(hdev, "can't set operational mode on the interrupt EP\n");
> 
> And adjust this message accordingly. Call it "step 3" perhaps?

Sure, will edit the error messages.

- Lauri
