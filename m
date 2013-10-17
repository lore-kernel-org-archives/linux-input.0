From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 1/1] HID: Fix unit exponent parsing again
Date: Thu, 17 Oct 2013 14:56:16 -0400
Message-ID: <CAN+gG=FC8Zvkt+9wcaMyo+akmqY-mm=xSPDqWOqGHEPwZx3XTQ@mail.gmail.com>
References: <1381666192-25309-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lb0-f169.google.com ([209.85.217.169]:36301 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233Ab3JQS4S (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Oct 2013 14:56:18 -0400
Received: by mail-lb0-f169.google.com with SMTP id z5so2269643lbh.14
        for <linux-input@vger.kernel.org>; Thu, 17 Oct 2013 11:56:16 -0700 (PDT)
In-Reply-To: <1381666192-25309-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input <linux-input@vger.kernel.org>

Hi Nikolai,

On Sun, Oct 13, 2013 at 8:09 AM, Nikolai Kondrashov <spbnick@gmail.com> wrote:
> Revert some changes done in 774638386826621c984ab6994439f474709cac5e.
>
> Revert all changes done in hidinput_calc_abs_res as it mistakingly used
> "Unit" item exponent nibbles to affect resolution value. This wasn't
> breaking resolution calculation of relevant axes of any existing
> devices, though, as they have only one dimension to their units and thus
> 1 in the corresponding nible.
>
> Revert to reading "Unit Exponent" item value as a signed integer in
> hid_parser_global to fix reading specification-complying values. This
> fixes resolution calculation of devices complying to the HID standard,
> including Huion, KYE, Waltop and UC-Logic graphics tablets which have
> their report descriptors fixed by the drivers.
>
> Explanations follow.
>
> There are two "unit exponents" in HID specification and it is important
> not to mix them. One is the global "Unit Exponent" item and another is
> nibble values in the global "Unit" item. See 6.2.2.7 Global Items.
>
> The "Unit Exponent" value is just a signed integer and is used to scale
> the integer resolution unit values, so fractions can be expressed.
>
> The nibbles of "Unit" value are used to select the unit system (nibble
> 0), and presence of a particular basic unit type in the unit formula and
> its *exponent* (or power, nibbles 1-6). And yes, the latter is in two
> complement and zero means absence of the unit type.
>
> Taking the representation example of (integer) joules from the
> specification:
>
> [mass(grams)][length(centimeters)^2][time(seconds)^-2] * 10^-7
>
> the "Unit Exponent" would be -7 (or 0xF9, if stored as a byte) and the
> "Unit" value would be 0xE121, signifying:
>
> Nibble  Part        Value   Meaning
> -----   ----        -----   -------
> 0       System      1       SI Linear
> 1       Length      2       Centimeters^2
> 2       Mass        1       Grams
> 3       Time        -2      Seconds^-2
>
> To give the resolution in e.g. hundredth of joules the "Unit Exponent"
> item value should have been -9.
>
> See also the examples of "Unit" values for some common units in the same
> chapter.
>
> However, there is a common misunderstanding about the "Unit Exponent"
> value encoding, where it is assumed to be stored the same as nibbles in
> "Unit" item. This is most likely due to the specification being a bit
> vague and overloading the term "unit exponent". This also was and still
> is proliferated by the official "HID Descriptor Tool", which makes this
> mistake and stores "Unit Exponent" as such. This format is also
> mentioned in books such as "USB Complete" and in Microsoft's hardware
> design guides.
>
> As a result many devices currently on the market use this encoding and
> so the driver should support them.
> ---
>  drivers/hid/hid-core.c  | 11 ++++++-----
>  drivers/hid/hid-input.c | 13 ++++---------
>  2 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index b8470b1..013cad0 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -319,7 +319,7 @@ static s32 item_sdata(struct hid_item *item)
>
>  static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
>  {
> -       __u32 raw_value;
> +       __s32 raw_value;
>         switch (item->tag) {
>         case HID_GLOBAL_ITEM_TAG_PUSH:
>
> @@ -370,10 +370,11 @@ static int hid_parser_global(struct hid_parser *parser, struct hid_item *item)
>                 return 0;
>
>         case HID_GLOBAL_ITEM_TAG_UNIT_EXPONENT:
> -               /* Units exponent negative numbers are given through a
> -                * two's complement.
> -                * See "6.2.2.7 Global Items" for more information. */
> -               raw_value = item_udata(item);
> +               /* Many devices provide unit exponent as a two's complement
> +                * nibble due to the common misunderstanding of HID
> +                * specification 1.11, 6.2.2.7 Global Items. Attempt to handle
> +                * both this and the standard encoding. */
> +               raw_value = item_sdata(item);
>                 if (!(raw_value & 0xfffffff0))
>                         parser->global.unit_exponent = hid_snto32(raw_value, 4);
>                 else
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 8741d95..d97f232 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -192,6 +192,7 @@ static int hidinput_setkeycode(struct input_dev *dev,
>         return -EINVAL;
>  }
>
> +
>  /**
>   * hidinput_calc_abs_res - calculate an absolute axis resolution
>   * @field: the HID report field to calculate resolution for
> @@ -234,23 +235,17 @@ __s32 hidinput_calc_abs_res(const struct hid_field *field, __u16 code)
>         case ABS_MT_TOOL_Y:
>         case ABS_MT_TOUCH_MAJOR:
>         case ABS_MT_TOUCH_MINOR:
> -               if (field->unit & 0xffffff00)           /* Not a length */
> -                       return 0;
> -               unit_exponent += hid_snto32(field->unit >> 4, 4) - 1;
> -               switch (field->unit & 0xf) {
> -               case 0x1:                               /* If centimeters */
> +               if (field->unit == 0x11) {              /* If centimeters */
>                         /* Convert to millimeters */
>                         unit_exponent += 1;
> -                       break;
> -               case 0x3:                               /* If inches */
> +               } else if (field->unit == 0x13) {       /* If inches */
>                         /* Convert to millimeters */
>                         prev = physical_extents;
>                         physical_extents *= 254;
>                         if (physical_extents < prev)
>                                 return 0;
>                         unit_exponent -= 1;
> -                       break;
> -               default:
> +               } else {

I finally understood what you mean here, and why I introduced such a change.
I have weird report descriptors available in the field which are
making a funny use of units:

3M multitouch devices declare:
0x05, 0x01,                    //     Usage Page (Generic Desktop)    148
0x26, 0xff, 0x7f,              //     Logical Maximum (32767)         150
0x75, 0x10,                    //     Report Size (16)                153
0x55, 0x0e,                    //     Unit Exponent (-2)              155
0x65, 0x33,                    //     Unit (Inch^3,EngLinear)         157
0x09, 0x30,                    //     Usage (X)                       159
0x35, 0x00,                    //     Physical Minimum (0)            161
0x46, 0x3a, 0x06,              //     Physical Maximum (1594)         163
0x81, 0x02,                    //     Input (Data,Var,Abs)            166

which became fine with the non reverted code -> the unit exponent
became 1 ( = -2 + 3). However this is wrong according to the spec as
you mentioned because X and Y are not volumes (Inch^3), but Length
(Inch^1).

Even stranger, I have some eGalax devices which declares:
0x05, 0x01,                    //     Usage Page (Generic Desktop)    58
0x09, 0x30,                    //     Usage (X)                       60
0x75, 0x10,                    //     Report Size (16)                62
0x95, 0x01,                    //     Report Count (1)                64
0x55, 0x0d,                    //     Unit Exponent (-3)              66
0x65, 0x33,                    //     Unit (Inch^3,EngLinear)         68
0x35, 0x00,                    //     Physical Minimum (0)            70
0x46, 0xc1, 0x20,              //     Physical Maximum (8385)         72
0x26, 0xff, 0x7f,              //     Logical Maximum (32767)         75
0x81, 0x02,                    //     Input (Data,Var,Abs)            78

X is a volume, but if you compute in the way it is currently
implemented, it leads to a non unit value :)

Fortunately, latest Win 8 specification for multitouch screens,
requires the unit and unit exponent fields to be correctly
implemented, which I can see on the reports I have.

So I was trying to fix a wrong and fancy interpretation of the spec,
based on some devices which did this bad interpretation.

To sum up:
acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin


>                         return 0;
>                 }
>                 break;
> --
> 1.8.4.rc3
>
