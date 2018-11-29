From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/8] HID: MS and Logitech high-resolution scroll wheel support
Date: Thu, 29 Nov 2018 11:25:12 +0100
Message-ID: <CAO-hwJ+eFJduSuORm8GavKjtsfV4tqkEGC5-cao0_yhkVbKfwg@mail.gmail.com>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
 <CA+jURcuGGRtyeRXfLK0Or=hDG6KJ1z9eAS8DAuH12-QTNpgs0w@mail.gmail.com> <20181129042722.GA5872@jelly>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181129042722.GA5872@jelly>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: hcutts@chromium.org, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Nov 29, 2018 at 5:27 AM Peter Hutterer <peter.hutterer@who-t.net> wrote:
>
> On Wed, Nov 28, 2018 at 03:22:14PM -0800, Harry Cutts wrote:
> > On Wed, 21 Nov 2018 at 22:34, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> > > [snip]
> > > Devices tested:
> > > - Microsoft Comfort Optical Mouse 3000
> > > - Microsoft Sculpt Ergonomic Mouse
> > > - Microsoft Surface mouse
> > > - Logitech MX Anywhere 2S
> > >
> > > The following devices were tested for the HID feature and didn't have it:
> > > - Logitech G500s, G303
> > > - Roccat Kone XTD
> > > - all the cheap Lenovo, HP, Dell, Logitech USB mice that come with a
> > >   workstation that I could find in the local office
> > > - Etekcity something something
> > > - Razer Imperator
> > > - Microsoft Classic IntelliMouse
> > > - Microsoft Surface Mobile Mouse
> >
> > I just tested the patches with the Microsoft Comfort Optical Mouse
> > 3000. I also tested with the Microsoft Surface Precision mouse [0],
> > and like the Surface Mobile mouse it didn't seem to report the HID
> > feature (at least, it was only reporting REL_WHEEL_HI_RES changes of
> > 120 in evtest).
>
> IIRC that's the same mouse benjamin has and it does have the HID feature, it
> just ends up reporting the same number of clicks anyway so there's no
> visible effect. Which in itself is a good sign for the patch series, I
> guess ;)
>
> > For the series:
> > Acked-by: Harry Cutts <hcutts@chromium.org>
> > Verified-by: Harry Cutts <hcutts@chromium.org>
>
> thanks, much appreciated.

Thanks everyone.

Just a small note that there is a mess up in Peter's series that he is
already aware of: patch 6/8 depends on 8/8 so there is either a small
refactoring to do or change the order of the patches.

I also have asked Peter to look for regression tests in hid-tools[0]
before I can merge this. FWIW, I am putting together a CI system that
will run this test suite for every submitted patch (plus a few other
tests). But the test suite simply lacks basic wheel testing, so it's
hard to see regressions :)

I should be able to apply the series in the next following days or
next week I think.

Cheers,
Benjamin

[0] https://gitlab.freedesktop.org/libevdev/hid-tools/
