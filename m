From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 6/7] HID: logitech-hidpp: support the G700 over wireless
Date: Tue, 18 Dec 2018 11:11:50 +0100
Message-ID: <CAO-hwJKpLVyGBkopZZdePEXEo51HHqEOfzvX3BtxEt1YPhF9xg@mail.gmail.com>
References: <20180907103450.13890-1-benjamin.tissoires@redhat.com>
 <20180907103450.13890-7-benjamin.tissoires@redhat.com> <CA+jURct6zJoxqqu7KeOW+MEuR-Voa79=ONQJDqypEx+_BrO47w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+jURct6zJoxqqu7KeOW+MEuR-Voa79=ONQJDqypEx+_BrO47w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: hcutts@chromium.org
Cc: Jiri Kosina <jikos@kernel.org>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Simon Wood <simon@mungewell.org>, Olivier Gay <ogay@logitech.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Harry,

[now that the series has been reverted and re-inserted, I am starting
to have a look at this again]

On Fri, Sep 7, 2018 at 7:33 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> Hi Benjamin,
>
> On Fri, 7 Sep 2018 at 03:35, Benjamin Tissoires
> <benjamin.tissoires@redhat.com> wrote:
> >
> > The G700 is using a non unifying receiver, so it's easy to add its support
> > in hid-logitech-hidpp now.
> > [snip]
> > @@ -3671,6 +3671,9 @@ static const struct hid_device_id hidpp_devices[] = {
> >         { /* Solar Keyboard Logitech K750 */
> >           LDJ_DEVICE(0x4002),
> >           .driver_data = HIDPP_QUIRK_CLASS_K750 },
> > +       { /* G700 over Wireless */
> > +         HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G700_RECEIVER),
> > +         .driver_data = HIDPP_QUIRK_RECEIVER | HIDPP_QUIRK_UNIFYING },
>
> As someone who's new to the codebase, it seems rather confusing to me
> that HIDPP_QUIRK_UNIFYING would be present here for a device that
> doesn't use a Unifying receiver. Am I misunderstanding, or should we
> consider renaming the quirk or adding some clarifying comment?
> (Similarly for the G900 in the next patch.)

The initial reason is that the gaming receivers are Unifying but that
are not normally allowed to connect to more that one device at a time.
The reason is that those receiver are using a higher frequency and
need all of the bandwidth to operate (so they can't multiplex the
devices).

But as I re-read the series, it is clear that HIDPP_QUIRK_RECEIVER and
HIDPP_QUIRK_UNIFYING are never used separately, so it doesn't make
sense to have 2 quirks. We should probably rename UNIFYING into
RECEIVER for consistency and we will be good.

Cheers,
Benjamin

>
> >
> >         { LDJ_DEVICE(HID_ANY_ID) },
> >
> > --
> > 2.14.3
> >
>
> Thanks,
>
> Harry Cutts
> Chrome OS Touch/Input team
