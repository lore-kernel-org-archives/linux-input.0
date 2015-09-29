From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for
 DA9062 OnKey
Date: Tue, 29 Sep 2015 16:54:08 -0700
Message-ID: <20150929235408.GC29469@dtor-ws>
References: <cover.1437668261.git.stwiss.opensource@diasemi.com>
 <6bfae9b4f5475b59bddc4b71091121f1c0697a2d.1437668261.git.stwiss.opensource@diasemi.com>
 <20150727224300.GG3613@dtor-ws>
 <20150728054024.GA4558@dtor-ws>
 <6ED8E3B22081A4459DAC7699F3695FB70173D121FD@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34681 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbI2XyM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Sep 2015 19:54:12 -0400
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB70173D121FD@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Lee Jones <lee.jones@linaro.org>, DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>, LINUXKERNEL <linux-kernel@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>, David Dajun Chen <david.chen@diasemi.com>, Samuel Ortiz <sameo@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>

On Mon, Sep 28, 2015 at 08:19:27AM +0000, Opensource [Steve Twiss] wrote:
> 
> > Subject: Re: [PATCH V3 3/3] devicetree: da9062: Add device tree bindings for DA9062 OnKey
> > 
> > On Mon, Jul 27, 2015 at 03:43:00PM -0700, Dmitry Torokhov wrote:
> > > On Thu, Jul 23, 2015 at 05:17:41PM +0100, S Twiss wrote:
> > > > From: S Twiss <stwiss.opensource@diasemi.com>
> > > >
> > > > Add device tree bindings for the DA9062 OnKey driver component
> > > >
> > > > Signed-off-by: Steve Twiss <stwiss.opensource@diasemi.com>
> > > >
> > > > ---
> > > > Changes in V3:
> > > >  - Child driver specifics separated out into separate document
> > > >    in this case ../input/da9062-onkey.txt
> > > > Changes in V2:
> > > >  - No change
> > > >
> > > > This patch applies against linux-next and next-20150708
> > > >
> > > >
> > > >  .../devicetree/bindings/input/da9062-onkey.txt     | 36
> > ++++++++++++++++++++++
> > > >  Documentation/devicetree/bindings/mfd/da9062.txt   |  3 ++
> > >
> > > I dropped bits for mfd/da9062.txt, changed to mention both 9062 and
> > > 9063, folded into the onkey patch and applied.
> > 
> > Argh, da9062 core is not in mainline yet... OK, below is the patch I
> > had; if Lee does not pick it up I'll re-apply it when da9062 core hits
> > mainline.
> > 
> 
> Hi Lee and Dmitry,
> 
> This patch seems to have been missed. It is the main OnKey driver for DA9062 and this
> component was waiting for the DA9062 MFD core to make it into linux-mainline/v4.3-rc1.
> 
> Is there any reply on this yet please? There just seems to be a little patch administration
> problem holding things up.

I queued it for 4.4.

Thanks.

-- 
Dmitry
