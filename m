From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v2 2/2] devicetree: i2c-hid: Add reset property
Date: Mon, 6 Nov 2017 10:06:30 +0100
Message-ID: <20171106090630.GF9728@mail.corp.redhat.com>
References: <1509418996-25348-1-git-send-email-hl@rock-chips.com>
 <1509418996-25348-2-git-send-email-hl@rock-chips.com>
 <20171101220208.gixv6anohp5q4kh2@rob-hp-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171101220208.gixv6anohp5q4kh2@rob-hp-laptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Lin Huang <hl@rock-chips.com>, dmitry.torokhov@gmail.com, jikos@kernel.org, jani.nikula@intel.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, briannorris@chromium.org, devicetree@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Rob,

On Nov 01 2017 or thereabouts, Rob Herring wrote:
> On Tue, Oct 31, 2017 at 11:03:16AM +0800, Lin Huang wrote:
> > Document a "reset" and "assert-reset-us", it can be used for
> > driver control reset property. And reuse post-power-on-delay-ms
> > for deassert reset delay.
> 
> "dt-bindings: input: " for the subject please.
> 
> > 
> > Signed-off-by: Lin Huang <hl@rock-chips.com>
> > ---
> >  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/input/hid-over-i2c.txt b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > index 28e8bd8..6ab0eed 100644
> > --- a/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > +++ b/Documentation/devicetree/bindings/input/hid-over-i2c.txt
> > @@ -31,7 +31,9 @@ device-specific compatible properties, which should be used in addition to the
> >  
> >  - vdd-supply: phandle of the regulator that provides the supply voltage.
> >  - post-power-on-delay-ms: time required by the device after enabling its regulators
> > -  before it is ready for communication. Must be used with 'vdd-supply'.
> > +  or deassert reset pin before it is ready for communication.
> > +- reset: phandle of the gpio that provides for hid reset pin.
> 
> The kernel api takes "reset", but the property is "reset-gpios".

In the same way the generic regulator interface handles vdd-supply, is
there any generic OF handling of reset lines? As far as I can tell,
there are 97 references of reset-gpios in my tree, and I wonder if all
the matching drivers need to rewrite the same code to set the reset line
on power on/off.

I am worried because here, 1/2 writes "arbitrary" 0 and 1 to the gpios,
and nothing prevent a manufacturer to invert the required voltages on
the reset lines, meaning there will be a need for a new OF property.

Cheers,
Benjamin

> 
> And it's not just a phandle typically.
> 
> > +- assert-reset-us: the device require reset assert time.
> >  
> >  Example:
> >  
> > -- 
> > 2.7.4
> > 
