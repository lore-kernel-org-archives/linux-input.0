From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 1/2] dt: add cap11xx LED documentation
Date: Tue, 23 Jun 2015 11:07:06 -0700
Message-ID: <20150623180706.GA40168@dtor-ws>
References: <1434599897-22505-1-git-send-email-mranostay@gmail.com>
 <1434599897-22505-2-git-send-email-mranostay@gmail.com>
 <20150622175914.GA15851@dtor-ws>
 <55891A84.1070509@samsung.com>
 <CAKzfze8jC1Nq9+AWFZbbC4=jzLwUZumbXYmg9O=0190Ne+f7fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKzfze8jC1Nq9+AWFZbbC4=jzLwUZumbXYmg9O=0190Ne+f7fg@mail.gmail.com>
Sender: linux-leds-owner@vger.kernel.org
To: Matt Ranostay <mranostay@gmail.com>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>, Daniel Mack <zonque@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-leds@vger.kernel.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 23, 2015 at 10:23:57AM -0700, Matt Ranostay wrote:
> On Tue, Jun 23, 2015 at 1:36 AM, Jacek Anaszewski
> <j.anaszewski@samsung.com> wrote:
> > On 06/22/2015 07:59 PM, Dmitry Torokhov wrote:
> >>
> >> On Wed, Jun 17, 2015 at 08:58:16PM -0700, Matt Ranostay wrote:
> >>>
> >>> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
> >>> ---
> >>>   .../devicetree/bindings/input/cap11xx.txt          | 25
> >>> ++++++++++++++++++++++
> >>>   1 file changed, 25 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/input/cap11xx.txt
> >>> b/Documentation/devicetree/bindings/input/cap11xx.txt
> >>> index 7d0a300..09cdc43 100644
> >>> --- a/Documentation/devicetree/bindings/input/cap11xx.txt
> >>> +++ b/Documentation/devicetree/bindings/input/cap11xx.txt
> >>> @@ -38,6 +38,11 @@ Optional properties:
> >>>                                 defaults. The array must have exactly six
> >>>                                 entries.
> >>>
> >>> +       linux,led-brightness:   Defines the ON brightness when the
> >>> optional LED
> >>> +                               functionality is used. Valid values are
> >>> 1-15.
> >>> +                               By default a value of 15 is set.
> >>
> >>
> >> Please mention the device does not allow controlling brightness of leds
> >> individually and that is why this property is at device level, not
> >> individual led level.
> >
> >
> > I've just noticed that we have drivers/leds/leds-netxbig.c driver, which
> > also doesn't allow controlling the LEDs on extension board individually,
> > but it still does allow changing their brightness. I am leaning towards
> > allowing this also for this driver and adding similar comment in the
> > source code like at the line 218 of the aforementioned driver.
> > As a result this property wouldn't be required.
> >
> 
> Ok that should be pretty simple to do. But seems kind weird to have
> each led channel to be changing the brightness of all.  Wouldn't the
> brightness sysfs entries of the other led channels be showing
> incorrect values?

I agree, this is kind of weird. Maybe we should have a device-specific
attribute (on the platform device level) that allows controlling overall
brightness, but I think LEDs should be just on/off with max brightness
of 1. Userspace should not have to be aware about the fact that on that
particular device LEDs are not completely independent as far as their
brightness goes.

Thanks.

-- 
Dmitry
