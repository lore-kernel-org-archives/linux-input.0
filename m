From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Thu, 1 Dec 2016 09:24:50 -0800
Message-ID: <20161201172448.GA46688@google.com>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <20161201143434.GD1280@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35123 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753431AbcLARYx (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Dec 2016 12:24:53 -0500
Received: by mail-pg0-f43.google.com with SMTP id p66so97109595pga.2
        for <linux-input@vger.kernel.org>; Thu, 01 Dec 2016 09:24:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20161201143434.GD1280@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>

Hi Benjamin and Rob,

On Thu, Dec 01, 2016 at 03:34:34PM +0100, Benjamin Tissoires wrote:
> On Nov 30 2016 or thereabouts, Brian Norris wrote:
> > From: Caesar Wang <wxt@rock-chips.com>
> > 
> > Add a compatible string and regulator property for Wacom W9103
> > digitizer. Its VDD supply may need to be enabled before using it.
> > 
> > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Jiri Kosina <jikos@kernel.org>
> > Cc: linux-input@vger.kernel.org
> > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > ---
> > v1 was a few months back. I finally got around to rewriting it based on
> > DT binding feedback.
> > 
> > v2:
> >  * add compatible property for wacom
> >  * name the regulator property specifically (VDD)
> > 
> >  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > index 488edcb264c4..eb98054e60c9 100644
> > --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > @@ -11,12 +11,16 @@ If this binding is used, the kernel module i2c-hid will handle the communication
> >  with the device and the generic hid core layer will handle the protocol.
> >  
> >  Required properties:
> > -- compatible: must be "hid-over-i2c"
> > +- compatible: must be "hid-over-i2c", or a device-specific string like:
> > +    * "wacom,w9013"
> 
> NACK on this one.
> 
> After re-reading the v1 submission I realized Rob asked for this change,
> but I strongly disagree.
> 
> HID over I2C is a generic protocol, in the same way HID over USB is. We
> can not start adding device specifics here, this is opening the can of
> worms. If the device is a HID one, nothing else should matter. The rest
> (description of the device, name, etc...) is all provided by the
> protocol.

I should have spoken up when Rob made the suggestion, because I more or
less agree with Benjamin here. I don't really see why this needs to have
a specialized compatible string, as the property is still fairly
generic, and the entire device handling is via a generic protocol. The
fact that we manage its power via a regulator is not very
device-specific.

> >  - reg: i2c slave address
> >  - hid-descr-addr: HID descriptor address
> >  - interrupt-parent: the phandle for the interrupt controller
> >  - interrupts: interrupt line
> >  
> > +Optional properties:
> > +- vdd-supply: phandle of the regulator that provides the supply voltage.
> 
> Agree on this one however.

Thanks.

As Benjamin noticed on patch 2, I added a delay property; I realized I
had been hacking that delay in to the regulator framework as a "ramp
delay" property, when in fact it was actually a property of *this*
device -- the 100 ms wait is a suggested wait for the HID firmware to
boot, not for the regulator to stabilize.

So, what do you two think about the following two properties?

 - vdd-supply, as in the quoted patch
 - init-delay-ms: time required by the device after power-on before it
   is ready for communication

And I'd drop the extra compatible property.

Brian
