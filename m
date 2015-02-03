From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] i8042: intel-8042 DT documentation
Date: Tue, 3 Feb 2015 11:32:02 -0800
Message-ID: <20150203193202.GB20256@dtor-ws>
References: <1422913730-12663-1-git-send-email-v1ron@v1ros.org>
 <20150203113816.GA30866@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:47389 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966273AbbBCTcH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 14:32:07 -0500
Content-Disposition: inline
In-Reply-To: <20150203113816.GA30866@leverpostej>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Roman Volkov <v1ron@v1ros.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <Pawel.Moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Hans de Goede <hdegoede@redhat.com>, Jiri Kosina <jkosina@suse.cz>, Wolfram Sang <wsa@the-dreams.de>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Roman Volkov <v1ron@mail.ru>, Tony Prisk <linux@prisktech.co.nz>

On Tue, Feb 03, 2015 at 11:38:16AM +0000, Mark Rutland wrote:
> On Mon, Feb 02, 2015 at 09:48:46PM +0000, Roman Volkov wrote:
> > Documentation for 'intel,8042' DT compatible node.
> > 
> > Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> > Signed-off-by: Roman Volkov <v1ron@v1ros.org>
> > ---
> >  .../devicetree/bindings/input/intel-8042.txt       | 29 ++++++++++++++++++++++
> >  1 file changed, 29 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/intel-8042.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/input/intel-8042.txt b/Documentation/devicetree/bindings/input/intel-8042.txt
> > new file mode 100644
> > index 0000000..2aea7ec
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/intel-8042.txt
> > @@ -0,0 +1,29 @@
> > +* Intel 8042 Keyboard Controller
> > +
> > +Required properties:
> > +- compatible: should be "intel,8042"
> > +- regs: memory for keyboard controller
> > +- interrupts: two interrupts should be specified (keyboard and aux)
> 
> Is it possible only one of these is wired up?

Yes, and we should support this case. The core of i8042 does.


> 
> It might be worth using interrupt-names.
> 
> > +- command-reg: offset in memory for command register
> > +- status-reg: offset in memory for status register
> > +- data-reg: offset in memory for data register
> > +
> > +Optional properties:
> > +- init-reset: Controller should be reset on init and cleanup
> 
> Why is this necessary? Can't we just always reset it?

We do not reset by default on x86 because BIOS takes care of this for us
and quite often firmware that emulates i8042 gets confused if we try to
reset it too. Non non-x86 we reset by default. I think we should do the
same for OF case  (reset) and not use this property.

> 
> > +
> > +Optional Linux-specific properties:
> > +- linux,kbd_phys_desc: defaults to i8042/serio0
> > +- linux,aux_phys_desc: defaults to i8042/serio1
> > +- linux,mux_phys_desc: defaults to i8042/serio%d
> 
> As a general note, s/_/-/ in property names please.
> 
> That said, I don't follow why we should have these at all. I don't
> understand what the description is intended to mean.
> 
> In general we want to avoid Linux-specific properties. If a DTB needs to
> know about the inernals of an OS it's likely to be fragile and broken
> over time.

Right, the desc were carried over from older days to keep dmesg
familiar. With OF it is new platforms so just settle on a generic
description and use it instead of allowing to specify through DT.

> 
> > +
> > +
> > +Example:
> > +	keyboard@d8008800 {
> > +		compatible = "intel,8042";
> > +		reg = <0xd8008800 0x100>;
> > +		interrupts = <23 4>;
> 
> If this is intended to be two interrupts, please bracket them
> individually, e.g.
> 
> 	interrupts = <23>, <4>;
> 
> > +		command-reg = <0x04>;
> > +		status-reg = <0x04>;
> 
> Same address?
> 
> > +		data-reg = <0x00>;
> > +		mux-ports = <2>;
> 
> This wasn't documented above.

I think active MUX is purely x86 concept, I have never heard of it being
used anywhere else.

Thanks.

-- 
Dmitry
