From: Mustafa Kuscu <mustafakuscu@gmail.com>
Subject: Re: [PATCH] HID: asus: only support backlight when it's not driven by WMI
Date: Fri, 12 Jan 2018 22:33:25 +0300
Message-ID: <CAMz_NCr-3taeHeZ3NF2LYXrMGf25gWgL+dzdO=Ca=Bxug2EbCw@mail.gmail.com>
References: <20180109012042.13947-1-drake@endlessm.com> <CAHp75Veyrzh+gV_8ff7TRqWpVx4h+2Qg05j9OpNXCH+E1+hsQg@mail.gmail.com>
 <CAD8Lp46gbny3mV2CgWnrJnEpZpNo-P-GgKA5-DypykbmGoUhQg@mail.gmail.com> <CAHp75Vc962G3rufA_D1GY=Giy7u0vri4_vQnFPYCxZ_w6N_2GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:42154 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964998AbeALTd2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 12 Jan 2018 14:33:28 -0500
In-Reply-To: <CAHp75Vc962G3rufA_D1GY=Giy7u0vri4_vQnFPYCxZ_w6N_2GQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Daniel Drake <drake@endlessm.com>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Carlo Caione <carlo@endlessm.com>, Corentin Chary <corentin.chary@gmail.com>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Tue, Jan 9, 2018 at 10:58 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Jan 9, 2018 at 9:41 PM, Daniel Drake <drake@endlessm.com> wrote:
>> On Tue, Jan 9, 2018 at 1:32 PM, Andy Shevchenko
>> <andy.shevchenko@gmail.com> wrote:
>>> Imagine someone who on possession of laptop where it's not needed
>>> having old kernel configuration.
>>> Building new kernel with old configuration will bring a regression.
>>>
>>> Selection is also not a solution since we don't need all crap in
>>> kernel because of some particular case.
>>>
>>> So, NO.
>>
>> If I can't use depends nor select, then what options are left? What
>> alternative solutions do you have in mind?
>
> If you would able to move code under corresponding WMI driver, make it
> use any means of autodetection (it looks like you found a way via
> checking return code of method call) and
> then rely on distributions that they enable necessary modules
> (HID_ASUS, ASUS_WMI or alike).
>
> --
> With Best Regards,
> Andy Shevchenko
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


Hi,

It is interesting that the backlight buttons did not work for you. I
think your keyboard (0b05:1837)is a
USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2.
I also have a ROG laptop (GL553VD) whose keyboard (0b05:1854) is being
identified as USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1. Its keyboard
backlight shortcuts are enabled only after applying the following
patch. I am wondering why this harmless one liner did not find its way
into the modules tree. It's difficult to apply the patch to every keep
up with the latest. Maybe other ASUS people confirm this and help
pushing it further..
Kind Regards...

Signed-off-by: Mustafa C Kuscu <mustafakuscu@gmail.com>
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index a4a3c38bc145..39068eddc03c 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -593,7 +593,7 @@ static const struct hid_device_id asus_devices[] = {
     { HID_I2C_DEVICE(USB_VENDOR_ID_ASUSTEK,
         USB_DEVICE_ID_ASUSTEK_I2C_TOUCHPAD), I2C_TOUCHPAD_QUIRKS },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
-        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1) },
+        USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD1), QUIRK_USE_KBD_BACKLIGHT },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
         USB_DEVICE_ID_ASUSTEK_ROG_KEYBOARD2), QUIRK_USE_KBD_BACKLIGHT },
     { HID_USB_DEVICE(USB_VENDOR_ID_ASUSTEK,
