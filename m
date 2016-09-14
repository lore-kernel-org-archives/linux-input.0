From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] HID: wacom: do not detect Pad devices as joysticks
Date: Wed, 14 Sep 2016 17:58:56 +0200
Message-ID: <20160914155856.GN25951@mail.corp.redhat.com>
References: <1473760358-31999-1-git-send-email-benjamin.tissoires@redhat.com>
 <1473760358-31999-3-git-send-email-benjamin.tissoires@redhat.com>
 <CAF8JNh+QHJNz_bNk930YZpV9UKbhSc7T13X--hAzVC7fQr-VWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAF8JNh+QHJNz_bNk930YZpV9UKbhSc7T13X--hAzVC7fQr-VWg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Jason Gerecke <killertofu@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Sep 13 2016 or thereabouts, Ping Cheng wrote:
> Hi Benjamin,
> 
> On Tuesday, September 13, 2016, Benjamin Tissoires <
> benjamin.tissoires@redhat.com> wrote:
> 
> > Well, joydev consider our Pad devices as joysticks and associate a
> > /dev/input/jsX node for them.
> 
> 
> Indeed, this issue has annoyed me for many years. I'm happy to see someone
> is putting effort on it. Thank you so much!

I thought this would be not so much effort, but I see you are willing to
make me do some more effort :)

> 
> The problem is that it consider the ABS_X value as 0, and sends some
> > spurious joystick events saying the X axis is full left (Y too, but full
> > up). Given that we are basically screwed, add one more BTN which tells
> > joydev to ignore the Pad device and doesn't interfere with the rest of
> > the udev rules and the processing.
> >
> > Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com
> > <javascript:;>>
> > ---
> >  drivers/hid/wacom_wac.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
> > index 8fd115f..498f4a8 100644
> > --- a/drivers/hid/wacom_wac.c
> > +++ b/drivers/hid/wacom_wac.c
> > @@ -2920,6 +2920,9 @@ int wacom_setup_pad_input_capabilities(struct
> > input_dev *input_dev,
> >         /* kept for making udev and libwacom accepting the pad */
> >         __set_bit(BTN_STYLUS, input_dev->keybit);
> >
> > +       /* added to be ignored by joydev */
> > +       __set_bit(BTN_TOOL_PEN, input_dev->keybit);
> > +
> 
> 
> I am thinking this could be confusing to those 3rd party developers who
> extract tool/device types directly from the kernel. Since we are on this
> page, can we add some types to distinguish a PAD from a JOYSTICK, such as
> BTN_TOOL_JOYSTICK and BTN_TOOL_PAD. A clear upstream definition goes a long
> way to userland.

It's going to be difficult to convince Dmitry on this. Joysticks and
Pads are usually static configuration per device node, so it would make
more sense to have this set as an INPUT_PROP instead.

And given we already have INPUT_PROP_POINTER and INPUT_PROP_DIRECT, it
looks like we can infer the Pad/Joysitck easily from userspace without
adding more API.

Anyway, I think I'll turn the patch into one against joydev that will
add an exception for BTN_STYLUS, like we have for BTN_DIGI (a.k.a.
BTN_TOOL_PEN). However, I foresee a more difficult inclusion because the
heuristic in joydev is quite interesting to the least.

Cheers,
Benjamin

> 
> Cheers,
> 
> Ping
> 
>         wacom_setup_numbered_buttons(input_dev, features->numbered_buttons);
> >
> >         switch (features->type) {
> > --
> > 2.7.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-input" in
> > the body of a message to majordomo@vger.kernel.org <javascript:;>
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
