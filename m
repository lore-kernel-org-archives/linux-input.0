From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: input: support Microsoft wireless radio control hotkey
Date: Fri, 7 Dec 2018 14:02:54 +0100
Message-ID: <CAO-hwJKPQP1sFmN7bukXh0DR8WdM7=sDZnyC=7va+vizRdqAsg@mail.gmail.com>
References: <20181130064617.67920-1-chiu@endlessm.com> <CAO-hwJKAnHqPi7aOGqKET+_JKnXmvdwOyhtH4nLeqS+-K8597Q@mail.gmail.com>
 <CAB4CAwfOBuAutaQdObyfrOg5Yo2M9NJGww1Ffc7o2YrAYDObEA@mail.gmail.com> <CAB4CAwf34ZvF88rVCz2H6iDKoDHF09txp1oGqvUfCt18ZH-w6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAB4CAwf34ZvF88rVCz2H6iDKoDHF09txp1oGqvUfCt18ZH-w6w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: chiu@endlessm.com
Cc: Jiri Kosina <jikos@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>
List-Id: linux-input@vger.kernel.org

On Fri, Dec 7, 2018 at 5:07 AM Chris Chiu <chiu@endlessm.com> wrote:
>
> On Wed, Dec 5, 2018 at 8:56 AM Chris Chiu <chiu@endlessm.com> wrote:
> >
> > On Fri, Nov 30, 2018 at 7:18 PM Benjamin Tissoires
> > <benjamin.tissoires@redhat.com> wrote:
> > >
> > > On Fri, Nov 30, 2018 at 7:46 AM Chris Chiu <chiu@endlessm.com> wrote:
> > > >
> > > > The ASUS laptops start to support the airplane mode radio management
> > > > to replace the original machanism of airplane mode toggle hotkey.
> > > > On the ASUS P5440FF, it presents as a HID device connecting via
> > > > I2C, name i2c-AMPD0001. When pressing hotkey, the Embedded Controller
> > > > send hid report up via I2C and switch the airplane mode indicator
> > > > LED based on the status.
> > > >
> > > > However, it's not working because it fails to be identified as a
> > > > hidinput device. It fails in hidinput_connect() due to the macro
> > > > IS_INPUT_APPLICATION doesn't identify HID_GD_WIRELESS_RADIO_CTLS
> > > > as a legit application code.
> > > >
> > > > It's easy to add the HID I2C vendor and product id to the quirk
> > > > list and apply HID_QUIRK_HIDINPUT_FORCE to make it work. But it
> > > > can be more generic to support such kind of application on PC.
> > >
> > > Sounds good, but while you are at it, can you please:
> > > - fix the kbuild warning
> > > - rewrite the whole line to use macros,
> > > - make the macro prettier by inserting new lines were required
> > > - and define the missing macro:
> > >   0x000d0006 -> HID_DG_WHITEBOARD
> > >
> > > Maybe we should keep the ranges definitions with raw values and put a
> > > comment on the side with the names.
> > >
> > > Cheers,
> > > Benjamin
> > >
> >
> > Hi Bejamin,
> >     Thanks for your comment, I've submitted other patches which may
> > fulfill your suggestion.
> > https://lore.kernel.org/patchwork/patch/1020373/
> > https://lore.kernel.org/patchwork/patch/1020374/
> >
> >      Please help me review and correct me if there's any modification
> > required. Thanks & Regards.
> >
> > Chris
> >
>
> Gentle ping. Any comment for the new patch? Thanks and Regards.
>

Sorry for the delay. I broke my system and it took me a few days to
get it back on its feet.

The v2 is now scheduled for 4.21.

Cheers,
Benjamin
