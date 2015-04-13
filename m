From: Felipe <felipe.otamendi@gmail.com>
Subject: Re: [PATCH] Input: Fix multitouch support for Type Cover 3
Date: Mon, 13 Apr 2015 12:47:02 -0300
Message-ID: <CABRcTws6r+=jzwwh1JP64ynGmjrsDgtjizJ7zs2bz2V2ye6JhQ@mail.gmail.com>
References: <1428725871-4040-1-git-send-email-felipe.otamendi@gmail.com>
 <CAN+gG=E51Xy6gG93yh-sck7O6Uf7TQ2E_0+5RXujyJcWKbBFFw@mail.gmail.com>
 <CABRcTwvLXp9eAsZ3kVpiC2E+n+zYTxNHD5Z-kTWp=cJxnjNmrw@mail.gmail.com> <CAN+gG=F0_kfGmGkjxWMzHs6c8CnDYqeC=9nKSNZ7tw4fnDgF5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180]:34779 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932118AbbDMPrX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Apr 2015 11:47:23 -0400
In-Reply-To: <CAN+gG=F0_kfGmGkjxWMzHs6c8CnDYqeC=9nKSNZ7tw4fnDgF5A@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Apr 13, 2015 at 11:16 AM Benjamin Tissoires
<benjamin.tissoires@gmail.com> wrote:
>
> On Sun, Apr 12, 2015 at 6:04 PM, Felipe <felipe.otamendi@gmail.com> wrote:
> > Hi Benjamin,
> >
> > On Sat, Apr 11, 2015 at 11:08 AM, Benjamin Tissoires
> > <benjamin.tissoires@gmail.com> wrote:
> >> Hi Felipe,
> >>
> >> On Sat, Apr 11, 2015 at 12:17 AM, Felipe Otamendi
> >> <felipe.otamendi@gmail.com> wrote:
> >>> Make the Type Cover 3 use the hid multitouch driver, which is better suited for the touchpad. Also, since it has multiple reports under the same interface, allow the generic hid driver to handle non-multitouch inputs such as the keyboard's.
> >>
> >> IIRC, the point of having hid-microsoft was to have better support of
> >> the keyboard special functions and shortcuts. Can you please confirm
> >> that you do not lose any functionality?
> >>
> >
> > I've checked and all the keys work as they used to with the previous
> > patch. The only thing that doesn't work is the led on the Caps Lock
> > key. That's because the output from the keyboard report is being
> > mapped as a different input than the input from the same report
> > because of how inputs are mapped when HID_QUIRK_MULTI_INPUT is
> > enabled.
>
> That is worrisome. It means that there will be a regression with the patch.
> If I understand correctly, with hid-microsoft, the Caps Lock LED
> works, and not with hid-multitouch?
>

With hid-microsoft and hid-input the LED works, but not if you set the
HID_QUIRK_MULTI_INPUT. The hid-multitouch driver uses that quirk by
default but it is needed to get both the keyboard and touchpad as
different inputs so X11 drivers can pick them up independently. Also,
the hid-multitouch driver works well not only because it handles the
touchpad fields correctly but also because it initializes the device
in multitouch mode (Input mode feature report [1]) instead of mouse
mode.
The LED output report is mapped separately because of a combination of
how reports are traversed in hidinput_connect in hid-input.c and how
are mapped to new inputs with the HID_QUIRK_MULTI_INPUT. That part
seems dangerous to modify without breaking compatibility with other
devices. Maybe adding a different quirk? I don't know what the
protocol is in those cases.

[1] https://msdn.microsoft.com/en-us/library/windows/hardware/dn467314%28v=vs.85%29.aspx

> Can you share the report descriptors of the device? I might have had
> one, but I can not find it.
>

Yes, here's the report [2], it is in html.

[2] http://htmlpreview.github.io/?https://gist.githubusercontent.com/felipeota/2b7d9866ace154c38753/raw/d0d3e9b7a5876ba1f2cb93a80a3ba66e15d22294/TypeCover%203%20Descriptor



> >
> >>>
> >>> Signed-off-by: Felipe Otamendi <felipe.otamendi@gmail.com>
> >>> ---
> >>>  drivers/hid/hid-core.c       | 6 ++----
> >>>  drivers/hid/hid-microsoft.c  | 3 ---
> >>>  drivers/hid/hid-multitouch.c | 5 +++++
> >>>  3 files changed, 7 insertions(+), 7 deletions(-)
> >>>
> >>> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> >>> index 56ce8c2..5a80896 100644
> >>> --- a/drivers/hid/hid-core.c
> >>> +++ b/drivers/hid/hid-core.c
> >>> @@ -705,9 +705,8 @@ static void hid_scan_collection(struct hid_parser *parser, unsigned type)
> >>>                 hid->group = HID_GROUP_SENSOR_HUB;
> >>>
> >>>         if (hid->vendor == USB_VENDOR_ID_MICROSOFT &&
> >>> -           (hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3 ||
> >>> -            hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP) &&
> >>> -           hid->group == HID_GROUP_MULTITOUCH)
> >>> +               hid->product == USB_DEVICE_ID_MS_TYPE_COVER_3_JP &&
> >>> +               hid->group == HID_GROUP_MULTITOUCH)
> >>>                 hid->group = HID_GROUP_GENERIC;
> >>>
> >>>         if ((parser->global.usage_page << 16) == HID_UP_GENDESK)
> >>> @@ -1878,7 +1877,6 @@ static const struct hid_device_id hid_have_special_driver[] = {
> >>>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_DIGITAL_MEDIA_3K) },
> >>>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_WIRELESS_OPTICAL_DESKTOP_3_0) },
> >>>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_OFFICE_KB) },
> >>> -       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3) },
> >>>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP) },
> >>>         { HID_USB_DEVICE(USB_VENDOR_ID_MONTEREY, USB_DEVICE_ID_GENIUS_KB29E) },
> >>>         { HID_USB_DEVICE(USB_VENDOR_ID_MSI, USB_DEVICE_ID_MSI_GT683R_LED_PANEL) },
> >>> diff --git a/drivers/hid/hid-microsoft.c b/drivers/hid/hid-microsoft.c
> >>> index af935eb..7e84463 100644
> >>> --- a/drivers/hid/hid-microsoft.c
> >>> +++ b/drivers/hid/hid-microsoft.c
> >>> @@ -276,11 +276,8 @@ static const struct hid_device_id ms_devices[] = {
> >>>                 .driver_data = MS_NOGET },
> >>>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_COMFORT_MOUSE_4500),
> >>>                 .driver_data = MS_DUPLICATE_USAGES },
> >>> -       { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3),
> >>> -               .driver_data = MS_HIDINPUT },
> >>>         { HID_USB_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_TYPE_COVER_3_JP),
> >>>                 .driver_data = MS_HIDINPUT },
> >>> -
> >>
> >> Please keep this line, it adds extra to the commit and might have been
> >> put on purpose by the original author.
> >>
> >
> > Sorry about that. I'll correct the patch without this change.
> >
> >>>         { HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_MICROSOFT, USB_DEVICE_ID_MS_PRESENTER_8K_BT),
> >>>                 .driver_data = MS_PRESENTER },
> >>>         { }
> >>> diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
> >>> index f65e78b..d93c766 100644
> >>> --- a/drivers/hid/hid-multitouch.c
> >>> +++ b/drivers/hid/hid-multitouch.c
> >>> @@ -1235,6 +1235,11 @@ static const struct hid_device_id mt_devices[] = {
> >>>                 MT_USB_DEVICE(USB_VENDOR_ID_ILITEK,
> >>>                         USB_DEVICE_ID_ILITEK_MULTITOUCH) },
> >>>
> >>> +       /* Microsoft Type Cover 3 */
> >>> +       { .driver_data = MT_CLS_EXPORT_ALL_INPUTS,
> >>> +               MT_USB_DEVICE(USB_VENDOR_ID_MICROSOFT,
> >>> +                       USB_DEVICE_ID_MS_TYPE_COVER_3) },
> >>> +
> >>>         /* MosArt panels */
> >>>         { .driver_data = MT_CLS_CONFIDENCE_MINUS_ONE,
> >>>                 MT_USB_DEVICE(USB_VENDOR_ID_ASUS,
> >>> --
> >>> 2.1.0
> >>
> >> I had a similar patch in my tree at the time when we were deciding
> >> what to do for those devices.
> >> This patch had an extra hunk (sorry gmail will cut the lines and everything):
> >>
> >> --- a/drivers/hid/hid-multitouch.c
> >> +++ b/drivers/hid/hid-multitouch.c
> >> @@ -961,6 +961,9 @@ static void mt_input_configured(struct hid_device
> >> *hdev, struct hid_input *hi)
> >>                 case HID_DG_TOUCHSCREEN:
> >>                         /* we do not set suffix = "Touchscreen" */
> >>                         break;
> >> +               case HID_DG_TOUCHPAD:
> >> +                       suffix = "Touchpad";
> >> +                       break;
> >>                 case HID_GD_SYSTEM_CONTROL:
> >>                         suffix = "System Control";
> >>                         break;
> >>
> >> Can you please test/add this with your current patch. Your touchpad
> >> might appear as "UNKNOWN", which is not very appealing :)
> >>
> >
> > It works, now it appears with the Touchscreen suffix. I should send
> > the new patch as a response to this thread right?
>
> I guess you meant "Touchpad" here.

Yes, I meant "Touchpad".

>
> No need to send the v2 as a reply to this thread. Just use the subject
> prefix "PATCH v2" and that should be enough.
>
> Cheers,
> Benjamin
