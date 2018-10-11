From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: usbhid: Add quirk for Redragon/Dragonrise Seymur 2
Date: Thu, 11 Oct 2018 17:02:51 +0200
Message-ID: <CAO-hwJKMkZx5mcXrYrbjYBeQdOqK0fThUc_amP0ofA6YtvWAEQ@mail.gmail.com>
References: <20181011075633.18868-1-kai.heng.feng@canonical.com>
 <CAO-hwJJkB=u44_kJNjOSL=8pgnXDkvda12_g8p39DeZ0JybqWQ@mail.gmail.com> <3941E373-A385-4080-ADCC-BAEBC862809A@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3941E373-A385-4080-ADCC-BAEBC862809A@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai Heng Feng <kai.heng.feng@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, Oct 11, 2018 at 11:16 AM Kai Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Benjamin,
>
> > On Oct 11, 2018, at 16:34, Benjamin Tissoires <benjamin.tissoires@redhat.com> wrote:
> >
> > Hi Kai-Heng,
> >
> > On Thu, Oct 11, 2018 at 9:56 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:
> >>
> >> Redragon Seymur 2 stops working since commit 190d7f02ce8e ("HID: input:
> >> do not increment usages when a duplicate is found").
> >>
> >> Use quirk HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE suggested by the commit
> >> can solve the issue.
> >
> > Before we take the hammer, could you share the report descriptors (or
> > I'll request those in the kernel BZ)?
>
> Feel free to do so!
>
> I send the patch because seems like the user doesn’t know how to upstream patches.

Heh, no worries :)

So, after a review of the report descriptors:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

(In this case, adding the quirk is the easiest solution and it has no
side effects)

Cheers,
Benjamin

>
> Kai-Heng
>
> > In the kernel BZ, it's clear that the report descriptor is wrong at
> > assigning axes, but I'd like to double check if applying the quirk
> > will be OK and will not pollute other axes.
> >
> > Cheers,
> > Benjamin
> >
> >>
> >> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200995
> >> BugLink: https://bugs.launchpad.net/bugs/1793846
> >> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> >> ---
> >> drivers/hid/hid-ids.h    | 1 +
> >> drivers/hid/hid-quirks.c | 1 +
> >> 2 files changed, 2 insertions(+)
> >>
> >> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> >> index bc49909aba8e..0e0aa7f0e6fc 100644
> >> --- a/drivers/hid/hid-ids.h
> >> +++ b/drivers/hid/hid-ids.h
> >> @@ -342,6 +342,7 @@
> >> #define USB_DEVICE_ID_DMI_ENC          0x5fab
> >>
> >> #define USB_VENDOR_ID_DRAGONRISE               0x0079
> >> +#define USB_DEVICE_ID_REDRAGON_SEYMUR2         0x0006
> >> #define USB_DEVICE_ID_DRAGONRISE_WIIU          0x1800
> >> #define USB_DEVICE_ID_DRAGONRISE_PS3           0x1801
> >> #define USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR    0x1803
> >> diff --git a/drivers/hid/hid-quirks.c b/drivers/hid/hid-quirks.c
> >> index 249d49b6b16c..52c3b01917e7 100644
> >> --- a/drivers/hid/hid-quirks.c
> >> +++ b/drivers/hid/hid-quirks.c
> >> @@ -70,6 +70,7 @@ static const struct hid_device_id hid_quirks[] = {
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DMI, USB_DEVICE_ID_DMI_ENC), HID_QUIRK_NOGET },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_2NES2SNES), HID_QUIRK_MULTI_INPUT },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRACAL_RAPHNET, USB_DEVICE_ID_RAPHNET_4NES4SNES), HID_QUIRK_MULTI_INPUT },
> >> +       { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_REDRAGON_SEYMUR2), HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_DOLPHINBAR), HID_QUIRK_MULTI_INPUT },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_GAMECUBE1), HID_QUIRK_MULTI_INPUT },
> >>        { HID_USB_DEVICE(USB_VENDOR_ID_DRAGONRISE, USB_DEVICE_ID_DRAGONRISE_PS3), HID_QUIRK_MULTI_INPUT },
> >> --
> >> 2.17.1
> >>
>
