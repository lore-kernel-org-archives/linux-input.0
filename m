From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: input: add Elan 400 combo
 keyboard/touchpad over i2c
Date: Fri, 26 Apr 2019 17:49:08 -0500
Message-ID: <20190426224908.GA30389@bogus>
References: <20190415160915.16324-1-jeffrey.l.hugo@gmail.com>
 <20190415161055.16372-1-jeffrey.l.hugo@gmail.com>
 <CAO-hwJJ_BRRHL44yaZ=d_K-9iq1cyONn0rR+VW3ukW1M2Ma0ug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAO-hwJJ_BRRHL44yaZ=d_K-9iq1cyONn0rR+VW3ukW1M2Ma0ug@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>, mark.rutland@arm.com, Lee Jones <lee.jones@linaro.org>, bjorn.andersson@linaro.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, agross@kernel.org, David Brown <david.brown@linaro.org>, Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 18, 2019 at 11:35:42AM +0200, Benjamin Tissoires wrote:
> On Mon, Apr 15, 2019 at 6:11 PM Jeffrey Hugo <jeffrey.l.hugo@gmail.com> wrote:
> >
> > The Elan 400 combo keyboard/touchpad over i2c device is a distinct device
> > from the Elan 400 standalone touchpad device.  The combo device has been
> > found in the Lenovo Miix 630 and HP Envy x2 laptops.
> >
> > Signed-off-by: Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
> > ---
> 
> With my comments in 2/3, I wonder if you need this patch at all then.

I don't really follow the discussion in 2/3, but you should still have 
specific compatibles even if right now you don't need them.

> 
> Cheers,
> Benjamin
> 
> >  .../devicetree/bindings/input/elan,combo400-i2c.txt   | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
> >
> > diff --git a/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt b/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
> > new file mode 100644
> > index 000000000000..fb700a29148d
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/input/elan,combo400-i2c.txt
> > @@ -0,0 +1,11 @@
> > +Elantech 0400 I2C combination Keyboard/Touchpad
> > +
> > +This binding describes an Elan device with pid 0x0400, that is a combination
> > +keyboard + touchpad device.  This binding does not cover an Elan device with
> > +pid 0x0400 that is solely a standalone touchpad device.
> > +
> > +Required properties:
> > +- compatible: should be "elan,combo400-i2c"
> > +
> > +This binding is compatible with the HID over I2C binding, which is specified
> > +in hid-over-i2c.txt in this directory.

Separate is fine, but we've been adding compatibles to hid-over-i2c.txt.

Rob
