From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] devicetree: i2c-hid: Add Wacom digitizer +
 regulator support
Date: Mon, 5 Dec 2016 17:59:08 -0600
Message-ID: <20161205235908.rmiyd7io4kddple6@rob-hp-laptop>
References: <1480555288-142791-1-git-send-email-briannorris@chromium.org>
 <20161201143434.GD1280@mail.corp.redhat.com>
 <20161201172448.GA46688@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36769 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751497AbcLEX7K (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 5 Dec 2016 18:59:10 -0500
Content-Disposition: inline
In-Reply-To: <20161201172448.GA46688@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>

On Thu, Dec 01, 2016 at 09:24:50AM -0800, Brian Norris wrote:
> Hi Benjamin and Rob,
> 
> On Thu, Dec 01, 2016 at 03:34:34PM +0100, Benjamin Tissoires wrote:
> > On Nov 30 2016 or thereabouts, Brian Norris wrote:
> > > From: Caesar Wang <wxt@rock-chips.com>
> > > 
> > > Add a compatible string and regulator property for Wacom W9103
> > > digitizer. Its VDD supply may need to be enabled before using it.
> > > 
> > > Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Jiri Kosina <jikos@kernel.org>
> > > Cc: linux-input@vger.kernel.org
> > > Signed-off-by: Brian Norris <briannorris@chromium.org>
> > > ---
> > > v1 was a few months back. I finally got around to rewriting it based on
> > > DT binding feedback.
> > > 
> > > v2:
> > >  * add compatible property for wacom
> > >  * name the regulator property specifically (VDD)
> > > 
> > >  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > > index 488edcb264c4..eb98054e60c9 100644
> > > --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > > +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > > @@ -11,12 +11,16 @@ If this binding is used, the kernel module i2c-hid will handle the communication
> > >  with the device and the generic hid core layer will handle the protocol.
> > >  
> > >  Required properties:
> > > -- compatible: must be "hid-over-i2c"
> > > +- compatible: must be "hid-over-i2c", or a device-specific string like:
> > > +    * "wacom,w9013"
> > 
> > NACK on this one.
> > 
> > After re-reading the v1 submission I realized Rob asked for this change,
> > but I strongly disagree.
> > 
> > HID over I2C is a generic protocol, in the same way HID over USB is. We
> > can not start adding device specifics here, this is opening the can of
> > worms. If the device is a HID one, nothing else should matter. The rest
> > (description of the device, name, etc...) is all provided by the
> > protocol.
> 
> I should have spoken up when Rob made the suggestion, because I more or
> less agree with Benjamin here. I don't really see why this needs to have
> a specialized compatible string, as the property is still fairly
> generic, and the entire device handling is via a generic protocol. The
> fact that we manage its power via a regulator is not very
> device-specific.

It doesn't matter that the protocol is generic. The device attached and 
the implementation is not. Implementations have been known to have 
bugs/quirks (generally speaking, not HID over I2C in particular). There 
are also things outside the scope of what is 'hid-over-i2c' like what's 
needed to power-on the device which this patch clearly show.

This is no different than a panel attached via LVDS, eDP, etc., or 
USB/PCIe device hard-wired on a board. They all use standard protocols 
and all need additional data to describe them. Of course, adding a 
single property for a delay would not be a big deal, but it's never 
ending. Next you need multiple supplies, GPIO controls, mutiple 
delays... This has been discussed to death already. As Thierry Reding 
said, you're not special[1].

Now if you want to make 'hid-over-i2c' a fallback to 'wacom,w9013', I'm 
fine with that.

Rob

[1] https://sietch-tagr.blogspot.de/2016/04/display-panels-are-not-special.html
