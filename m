From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/2] HID: hid-logitech: Add support for G29
Date: Mon, 30 Nov 2015 21:54:41 +0100
Message-ID: <CAN+gG=Gm=6-1o+cgh0-M0KKS-XOZVoEnAFpYNfU+ZsTLGvHiiA@mail.gmail.com>
References: <1446476212-2289-1-git-send-email-simon@mungewell.org>
	<1446476212-2289-2-git-send-email-simon@mungewell.org>
	<1587298.yn0CI2NQhN@diplodocus>
	<c02pwt.nymsyf.2yb072-qmf@smtp.devoid-pointer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:33562 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbbK3Uym (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Nov 2015 15:54:42 -0500
In-Reply-To: <c02pwt.nymsyf.2yb072-qmf@smtp.devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?TWljaGFsIE1hbMO9?= <madcatxster@devoid-pointer.net>
Cc: stillcompiling@gmail.com, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Edwin <Edwin@velds.nl>, Elias Vanderstuyft <elias.vds@gmail.com>, Simon Wood <simon@mungewell.org>

On Mon, Nov 30, 2015 at 3:15 PM,  <madcatxster@devoid-pointer.net> wrote:
> Hi all,
>
> my completely off-the-bat guess would be that the combo uses multiple interfaces as well, the patch seems to ignore everything but iface 0. Can you comment out the 'if' that does this and give it a go?

Just a FYI: https://bugzilla.kernel.org/show_bug.cgi?id=108121

I just been reported that the patch I attached here fixed the issue.
I'll send it to the list tomorrow unless Jiri beats me at picking it
up before :)

Cheers,
Benjamin

>
> Michal
>
> On Mon Nov 30 14:03:51 2015 GMT+0100, Joshua Clayton wrote:
>> Simon et al,
>> My logitech cordless mouse is not detected in linux-next
>> I have bisected the breakage to this patch,
>>  commit 29fae1c85166ef525b8b6518e749295e0c9d1e20 in linux-next.
>>
>> On Monday, November 02, 2015 07:56:52 AM Simon Wood wrote:
>> > At present the G29 is mis-identified as a DFGT, this patch ensures
>> > that the wheel is correctly detected and allows setting the LEDs and
>> > turning range via the '/sys' interface.
>> >
>> > This wheel can also emulate other types of Logitech wheels.
>> >
>> > Signed-off-by: Simon Wood <simon@mungewell.org>
>> > ---
>> >  drivers/hid/hid-core.c  |  1 +
>> >  drivers/hid/hid-lg.c    |  9 ++++++++
>> >  drivers/hid/hid-lg4ff.c | 57 +++++++++++++++++++++++++++++++++++++++++++++----
>> >  3 files changed, 63 insertions(+), 4 deletions(-)
>> >
>> > diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
>> > index 70a11ac..949d804 100644
>> > --- a/drivers/hid/hid-core.c
>> > +++ b/drivers/hid/hid-core.c
>> > @@ -1896,6 +1896,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
>> >     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD_CORD) },
>> >     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD) },
>> >     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_RUMBLEPAD2_2) },
>> > +   { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G29_WHEEL) },
>> >     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_F3D) },
>> >     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_WINGMAN_FFG ) },
>> >     { HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_FORCE3D_PRO) },
>> > diff --git a/drivers/hid/hid-lg.c b/drivers/hid/hid-lg.c
>> > index 5332fb7..c20ac76 100644
>> > --- a/drivers/hid/hid-lg.c
>> > +++ b/drivers/hid/hid-lg.c
>> > @@ -620,6 +620,7 @@ static int lg_input_mapped(struct hid_device *hdev, struct hid_input *hi,
>> >                     usage->code == ABS_Y || usage->code == ABS_Z ||
>> >                     usage->code == ABS_RZ)) {
>> >             switch (hdev->product) {
>> > +           case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
>> >             case USB_DEVICE_ID_LOGITECH_WHEEL:
>> >             case USB_DEVICE_ID_LOGITECH_MOMO_WHEEL:
>> >             case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
>> > @@ -658,10 +659,18 @@ static int lg_event(struct hid_device *hdev, struct hid_field *field,
>> >
>> >  static int lg_probe(struct hid_device *hdev, const struct hid_device_id *id)
>> >  {
>> > +   struct usb_interface *iface = to_usb_interface(hdev->dev.parent);
>> > +   __u8 iface_num = iface->cur_altsetting->desc.bInterfaceNumber;
>> >     unsigned int connect_mask = HID_CONNECT_DEFAULT;
>> >     struct lg_drv_data *drv_data;
>> >     int ret;
>> >
>> > +   /* Only work with the 1st interface (G29 presents multiple) */
>> > +   if (iface_num != 0) {
>> > +           dbg_hid("%s: ignoring ifnum %d\n", __func__, iface_num);
>> > +           return -ENODEV;
>> > +   }
>> > +
>> >     drv_data = kzalloc(sizeof(struct lg_drv_data), GFP_KERNEL);
>> >     if (!drv_data) {
>> >             hid_err(hdev, "Insufficient memory, cannot allocate driver data\n");
>> > diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
>> > index b363d88..fbddcb3 100644
>> > --- a/drivers/hid/hid-lg4ff.c
>> > +++ b/drivers/hid/hid-lg4ff.c
>> > @@ -45,7 +45,8 @@
>> >  #define LG4FF_MODE_G25_IDX 3
>> >  #define LG4FF_MODE_DFGT_IDX 4
>> >  #define LG4FF_MODE_G27_IDX 5
>> > -#define LG4FF_MODE_MAX_IDX 6
>> > +#define LG4FF_MODE_G29_IDX 6
>> > +#define LG4FF_MODE_MAX_IDX 7
>> >
>> >  #define LG4FF_MODE_NATIVE BIT(LG4FF_MODE_NATIVE_IDX)
>> >  #define LG4FF_MODE_DFEX BIT(LG4FF_MODE_DFEX_IDX)
>> > @@ -53,6 +54,7 @@
>> >  #define LG4FF_MODE_G25 BIT(LG4FF_MODE_G25_IDX)
>> >  #define LG4FF_MODE_DFGT BIT(LG4FF_MODE_DFGT_IDX)
>> >  #define LG4FF_MODE_G27 BIT(LG4FF_MODE_G27_IDX)
>> > +#define LG4FF_MODE_G29 BIT(LG4FF_MODE_G29_IDX)
>> >
>> >  #define LG4FF_DFEX_TAG "DF-EX"
>> >  #define LG4FF_DFEX_NAME "Driving Force / Formula EX"
>> > @@ -62,6 +64,8 @@
>> >  #define LG4FF_G25_NAME "G25 Racing Wheel"
>> >  #define LG4FF_G27_TAG "G27"
>> >  #define LG4FF_G27_NAME "G27 Racing Wheel"
>> > +#define LG4FF_G29_TAG "G29"
>> > +#define LG4FF_G29_NAME "G29 Racing Wheel"
>> >  #define LG4FF_DFGT_TAG "DFGT"
>> >  #define LG4FF_DFGT_NAME "Driving Force GT"
>> >
>> > @@ -140,6 +144,7 @@ static const struct lg4ff_wheel lg4ff_devices[] = {
>> >     {USB_DEVICE_ID_LOGITECH_G25_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
>> >     {USB_DEVICE_ID_LOGITECH_DFGT_WHEEL,  lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
>> >     {USB_DEVICE_ID_LOGITECH_G27_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
>> > +   {USB_DEVICE_ID_LOGITECH_G29_WHEEL,   lg4ff_wheel_effects, 40, 900, lg4ff_set_range_g25},
>> >     {USB_DEVICE_ID_LOGITECH_MOMO_WHEEL2, lg4ff_wheel_effects, 40, 270, NULL},
>> >     {USB_DEVICE_ID_LOGITECH_WII_WHEEL,   lg4ff_wheel_effects, 40, 270, NULL}
>> >  };
>> > @@ -157,6 +162,9 @@ static const struct lg4ff_multimode_wheel lg4ff_multimode_wheels[] = {
>> >     {USB_DEVICE_ID_LOGITECH_G27_WHEEL,
>> >      LG4FF_MODE_NATIVE | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
>> >      LG4FF_G27_TAG, LG4FF_G27_NAME},
>> > +   {USB_DEVICE_ID_LOGITECH_G29_WHEEL,
>> > +    LG4FF_MODE_NATIVE | LG4FF_MODE_G29 | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFGT | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
>> > +    LG4FF_G29_TAG, LG4FF_G29_NAME},
>> >  };
>> >
>> >  static const struct lg4ff_alternate_mode lg4ff_alternate_modes[] = {
>> > @@ -165,7 +173,8 @@ static const struct lg4ff_alternate_mode lg4ff_alternate_modes[] = {
>> >     [LG4FF_MODE_DFP_IDX] = {USB_DEVICE_ID_LOGITECH_DFP_WHEEL, LG4FF_DFP_TAG, LG4FF_DFP_NAME},
>> >     [LG4FF_MODE_G25_IDX] = {USB_DEVICE_ID_LOGITECH_G25_WHEEL, LG4FF_G25_TAG, LG4FF_G25_NAME},
>> >     [LG4FF_MODE_DFGT_IDX] = {USB_DEVICE_ID_LOGITECH_DFGT_WHEEL, LG4FF_DFGT_TAG, LG4FF_DFGT_NAME},
>> > -   [LG4FF_MODE_G27_IDX] = {USB_DEVICE_ID_LOGITECH_G27_WHEEL, LG4FF_G27_TAG, LG4FF_G27_NAME}
>> > +   [LG4FF_MODE_G27_IDX] = {USB_DEVICE_ID_LOGITECH_G27_WHEEL, LG4FF_G27_TAG, LG4FF_G27_NAME},
>> > +   [LG4FF_MODE_G29_IDX] = {USB_DEVICE_ID_LOGITECH_G29_WHEEL, LG4FF_G29_TAG, LG4FF_G29_NAME},
>> >  };
>> >
>> >  /* Multimode wheel identificators */
>> > @@ -197,8 +206,24 @@ static const struct lg4ff_wheel_ident_info lg4ff_dfgt_ident_info = {
>> >     USB_DEVICE_ID_LOGITECH_DFGT_WHEEL
>> >  };
>> >
>> > +static const struct lg4ff_wheel_ident_info lg4ff_g29_ident_info = {
>> > +   LG4FF_MODE_G29 | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFGT | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
>> > +   0xfff8,
>> > +   0x1350,
>> > +   USB_DEVICE_ID_LOGITECH_G29_WHEEL
>> > +};
>> > +
>> > +static const struct lg4ff_wheel_ident_info lg4ff_g29_ident_info2 = {
>> > +   LG4FF_MODE_G29 | LG4FF_MODE_G27 | LG4FF_MODE_G25 | LG4FF_MODE_DFGT | LG4FF_MODE_DFP | LG4FF_MODE_DFEX,
>> > +   0xff00,
>> > +   0x8900,
>> > +   USB_DEVICE_ID_LOGITECH_G29_WHEEL
>> > +};
>> > +
>> >  /* Multimode wheel identification checklists */
>> >  static const struct lg4ff_wheel_ident_info *lg4ff_main_checklist[] = {
>> > +   &lg4ff_g29_ident_info,
>> > +   &lg4ff_g29_ident_info2,
>> >     &lg4ff_dfgt_ident_info,
>> >     &lg4ff_g27_ident_info,
>> >     &lg4ff_g25_ident_info,
>> > @@ -237,6 +262,12 @@ static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_g27 = {
>> >      0xf8, 0x09, 0x04, 0x01, 0x00, 0x00, 0x00}      /* Switch mode to G27 with detach */
>> >  };
>> >
>> > +static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext09_g29 = {
>> > +   2,
>> > +   {0xf8, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,      /* Revert mode upon USB reset */
>> > +    0xf8, 0x09, 0x05, 0x01, 0x01, 0x00, 0x00}      /* Switch mode to G29 with detach */
>> > +};
>> > +
>> >  /* EXT_CMD1 - Understood by DFP, G25, G27 and DFGT */
>> >  static const struct lg4ff_compat_mode_switch lg4ff_mode_switch_ext01_dfp = {
>> >     1,
>> > @@ -650,6 +681,23 @@ static const struct lg4ff_compat_mode_switch *lg4ff_get_mode_switch_command(cons
>> >                     return NULL;
>> >             }
>> >             break;
>> > +   case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
>> > +           switch (target_product_id) {
>> > +           case USB_DEVICE_ID_LOGITECH_DFP_WHEEL:
>> > +                   return &lg4ff_mode_switch_ext09_dfp;
>> > +           case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
>> > +                   return &lg4ff_mode_switch_ext09_dfgt;
>> > +           case USB_DEVICE_ID_LOGITECH_G25_WHEEL:
>> > +                   return &lg4ff_mode_switch_ext09_g25;
>> > +           case USB_DEVICE_ID_LOGITECH_G27_WHEEL:
>> > +                   return &lg4ff_mode_switch_ext09_g27;
>> > +           case USB_DEVICE_ID_LOGITECH_G29_WHEEL:
>> > +                   return &lg4ff_mode_switch_ext09_g29;
>> > +           /* G29 can only be switched to DF-EX, DFP, DFGT, G25, G27 or its native mode */
>> > +           default:
>> > +                   return NULL;
>> > +           }
>> > +           break;
>> >     case USB_DEVICE_ID_LOGITECH_DFGT_WHEEL:
>> >             switch (target_product_id) {
>> >             case USB_DEVICE_ID_LOGITECH_WHEEL:
>> > @@ -1232,12 +1280,13 @@ int lg4ff_init(struct hid_device *hid)
>> >             entry->wdata.set_range(hid, entry->wdata.range);
>> >
>> >  #ifdef CONFIG_LEDS_CLASS
>> > -   /* register led subsystem - G27 only */
>> > +   /* register led subsystem - G27/G29 only */
>> >     entry->wdata.led_state = 0;
>> >     for (j = 0; j < 5; j++)
>> >             entry->wdata.led[j] = NULL;
>> >
>> > -   if (lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G27_WHEEL) {
>> > +   if (lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G27_WHEEL ||
>> > +                   lg4ff_devices[i].product_id == USB_DEVICE_ID_LOGITECH_G29_WHEEL) {
>> >             struct led_classdev *led;
>> >             size_t name_sz;
>> >             char *name;
>>
>> I have a logitech cordless mouse/keyboard combo.  The keyboard still works.
>>
>> The following is part of my dmesg output on the previous commit (with the mouse working),
>>
>> before:
>>
>> [    1.566674] usb 4-3: New USB device found, idVendor=046d, idProduct=c517
>> [    1.566779] usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [    1.566881] usb 4-3: Product: USB Receiver
>> [    1.566982] usb 4-3: Manufacturer: Logitech
>> [    1.573671] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:12.1/usb4/4-3/4-3:1.0/0003:046D:C517.0003/input/input14
>> [    1.624510] logitech 0003:046D:C517.0003: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:12.1-3/input0
>> [    1.629313] tsc: Refined TSC clocksource calibration: 2511.094 MHz
>> [    1.629407] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x243229b6f8a, max_idle_ns: 440795226168 ns
>> [    1.631370] logitech 0003:046D:C517.0004: fixing up Logitech keyboard report descriptor
>> [    1.632203] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:12.1/usb4/4-3/4-3:1.1/0003:046D:C517.0004/input/input15
>> [    1.677588] random: nonblocking pool is initialized
>> [    1.683359] logitech 0003:046D:C517.0004: input,hiddev0,hidraw1: USB HID v1.10 Mouse [Logitech USB Receiver] on usb-0000:00:12.1-3/input1
>>
>> after:
>>
>> [    1.577748] usb 4-3: New USB device found, idVendor=046d, idProduct=c517
>> [    1.577859] usb 4-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
>> [    1.577963] usb 4-3: Product: USB Receiver
>> [    1.578064] usb 4-3: Manufacturer: Logitech
>> [    1.584746] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:12.1/usb4/4-3/4-3:1.0/0003:046D:C517.0003/input/input14
>> [    1.635596] logitech 0003:046D:C517.0003: input,hidraw0: USB HID v1.10 Keyboard [Logitech USB Receiver] on usb-0000:00:12.1-3/input0
>> [    1.642389] tsc: Refined TSC clocksource calibration: 2511.093 MHz
>> [    1.642507] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x24322913340, max_idle_ns: 440795255552 ns
>> [    1.696567] random: nonblocking pool is initialized
>>
>>
>> I can only guess that it is either now being misidentified (regression).
>> ... or do I perhaps need to enable a different driver now???
>> Happy to help if I can.
>>
>> warmest regards,
>>
>> Joshua Clayton
>>
