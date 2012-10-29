From: "Patil, Rachna" <rachna-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH RESEND 0/8] TI Touchscreen driver updates and Support
 for TSC/ADC MFD driver
Date: Mon, 29 Oct 2012 07:13:05 +0000
Message-ID: <4CE347531D4CA947960AF71FF095B9323E964CB5@DBDE01.ent.ti.com>
References: <1350372345-27108-1-git-send-email-rachna@ti.com>
 <20121016174207.GA1833@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20121016174207.GA1833-WlK9ik9hQGAhIp7JRqBPierSzoNAToWh@public.gmane.org>
Content-Language: en-US
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Samuel,

This is just a gentle reminder for the patch set I had submitted viz.
"[PATCH RESEND 0/8] TI Touchscreen driver updates and Support for TSC/ADC MFD driver"
I received an ACK from Jonathan and Dmitry on this patch set.
Can you please pull in if there are no further comments.
This patch set does not break anything existing, it just adds new driver.

Thanks & Regards,
Rachna.

On Tue, Oct 16, 2012 at 23:12:07, Dmitry Torokhov wrote:
> Hi Rachna,
> 
> On Tue, Oct 16, 2012 at 12:55:37PM +0530, Patil, Rachna wrote:
> > This patch set is a cumulative set of [1] and [2] sent earlier.
> > I have merged the patch set so that the MFD patches apply without any 
> > issues.
> > 
> > Also Note that there are no code changes in either of the patch set, 
> > only rebased on top of linux-next to make sure that all the patches 
> > apply without any conflicts.
> > 
> > This patch set has been tested on AM335x EVM.
> > 
> > [1] "[PATCH 0/4] input: TSC: ti_tscadc: TI Touchscreen driver updates"
> > (http://www.spinics.net/lists/linux-input/msg22107.html)
> > 
> > [2] "[PATCH v5 0/4] Support for TSC/ADC MFD driver"
> > (http://www.spinics.net/lists/linux-input/msg22832.html)
> > 
> > Patil, Rachna (8):
> >   input: TSC: ti_tscadc: Correct register usage
> >   input: TSC: ti_tscadc: Add Step configuration as platform data
> >   input: TSC: ti_tscadc: set FIFO0 threshold Interrupt
> >   input: TSC: ti_tscadc: Remove definition of End Of Interrupt register
> >   input: TSC: ti_tscadc: Rename the existing touchscreen driver
> >   MFD: ti_tscadc: Add support for TI's TSC/ADC MFDevice
> >   input: TSC: ti_tsc: Convert TSC into a MFDevice
> >   IIO : ADC: tiadc: Add support of TI's ADC driver
> 
> I am fine with input portion of the patch series, please merge through MFD tree.
> 
> Thanks.
> 
> --
> Dmitry
> 
