From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 0/5] Add of_ functions for device_link_add()
Date: Thu, 25 Apr 2019 18:02:59 -0500
Message-ID: <CAL_JsqJAnaJo4uLgNaqfnNMGYO+qqLaqdEn159hMTYqYE-Afhg@mail.gmail.com>
References: <20190424101913.1534-1-benjamin.gaignard@st.com>
 <CAL_JsqJp9f3Sv08igSyR38Z5eXnAYWMNY29U5qEGLp=r2YReRw@mail.gmail.com> <CAKdAkRTUsJ4TU7BrSNXCKiQGZnArao9o_qk7i0xSzYJ1SGU14A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKdAkRTUsJ4TU7BrSNXCKiQGZnArao9o_qk7i0xSzYJ1SGU14A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Gaignard <benjamin.gaignard@st.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Mark Rutland <mark.rutland@arm.com>, Bastien Nocera <hadess@hadess.net>, Frank Rowand <frowand.list@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>, =?UTF-8?Q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, Yannick Fertre <yannick.fertre@st.com>, Arnd Bergmann <arnd@arndb.de>, Linux Input <linux-input@vger.kernel.org>, DTML <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-stm32@st-md-mailman.stormreply.com, Mark Brown <broonie@kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Apr 25, 2019 at 2:24 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Apr 25, 2019 at 11:08 AM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Wed, Apr 24, 2019 at 5:19 AM Benjamin Gaignard
> > <benjamin.gaignard@st.com> wrote:
> > >
> > > It could happen that we need to control suspend/resume ordering between
> > > devices without obvious consumer/supplier link. For example when touchscreens
> > > and DSI panels share the same reset line, in this case we need to be sure
> > > of pm_runtime operations ordering between those two devices to correctly
> > > perform reset.
> > > DSI panel and touchscreen aren't sharing any heriachical relationship (unlike
> > > I2C client and I2C bus or regulator client and regulator provider) so we need
> > > to describe this in device-tree.
> >
> > Needing to know which touchscreen is attached to a panel could be
> > important to describe if you have multiple displays.
> >
> > Doesn't the reset subsystem already have some support for shared
> > resets? Seems like it could provide clients with struct device or
> > device_node ptrs to other devices sharing a reset.
> >
> > >
> > > This series introduce of_device_links_{add,remove} and devm_of_device_links_add()
> > > helpers to find and parse 'links-add' property in a device-tree node.
> >
> > Going to document that property somewhere? :)
> >
> > I think this is too generic and coupled to Linux. It doesn't have any
> > information as to what is the dependency or connection nor what the
> > direction of the dependency is.
> >
> > I'm not convinced we need to solve this generically vs. defining
> > something for this specific example.
>
> I am pretty sure there will be more drivers needing complex
> dependencies. Doesn't ACPI allow defining relationship between devices
> that goes beyond the tree structure?

Can't speak to ACPI, but I assume you where implying ACPI supports
this so DT should too.

Almost every binding we have is defining relationships between
devices. Interrupts, clocks, gpio, pinctrl, etc. all do this. To use a
similar example to the one here, we already define the relationship
between a display and a backlight with a 'backlight' property in the
display node. Why should touchscreen be any different than backlight?

What really concerns me here is folks just add relationships to
'links-add' which are already captured in DT (such as backlight) just
because they'll get it for free and not have to go add support to
handle each specific binding.

Rob
