From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] HID: asus: only support backlight when it's not driven by WMI
Date: Tue, 9 Jan 2018 21:32:13 +0200
Message-ID: <CAHp75Veyrzh+gV_8ff7TRqWpVx4h+2Qg05j9OpNXCH+E1+hsQg@mail.gmail.com>
References: <20180109012042.13947-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:44831 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935470AbeAITcP (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 9 Jan 2018 14:32:15 -0500
In-Reply-To: <20180109012042.13947-1-drake@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input <linux-input@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Carlo Caione <carlo@endlessm.com>, Corentin Chary <corentin.chary@gmail.com>, acpi4asus-user <acpi4asus-user@lists.sourceforge.net>, Platform Driver <platform-driver-x86@vger.kernel.org>

On Tue, Jan 9, 2018 at 3:20 AM, Daniel Drake <drake@endlessm.com> wrote:
> The Asus GL502VSK has the same 0B05:1837 keyboard as we've seen in
> several Republic of Gamers laptops.
>
> However, in this model, the keybard backlight control exposed by hid-asus
> has no effect on the keyboard backlight. Instead, the keyboard
> backlight is correctly driven by asus-wmi.
>
> With two keyboard backlight devices available (and only the acer-wmi
> one working), GNOME is picking the wrong one to drive in the UI.
>
> Avoid this problem by not creating the backlight interface when we
> detect a WMI-driven keyboard backlight.
>
> We have also tested Asus GL702VMK which does have the hid-asus
> backlight present, and it still works fine with this patch (WMI method
> call returns UNSUPPORTED_METHOD).

>  config HID_ASUS
>         tristate "Asus"
>         depends on LEDS_CLASS
> +       depends on ACPI_WMI

No, for sure.
Imagine someone who on possession of laptop where it's not needed
having old kernel configuration.
Building new kernel with old configuration will bring a regression.

Selection is also not a solution since we don't need all crap in
kernel because of some particular case.

So, NO.

> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c

> +#define ASUS_WMI_MGMT_GUID             "97845ED0-4E6D-11DE-8A39-0800200C9A66"
> +#define ASUS_WMI_METHODID_DSTS2                0x53545344 /* Device STatuS #2*/
> +#define ASUS_WMI_DEVID_KBD_BACKLIGHT   0x00050021
> +#define ASUS_WMI_UNSUPPORTED_METHOD    0xFFFFFFFE
> +#define ASUS_WMI_DSTS_PRESENCE_BIT     0x00010000

> +/* WMI-based keyboard backlight LED control (via asus-wmi driver) takes
> + * precedence. We only activate HID-based backlight control when the
> + * WMI control is not available.
> + */
> +static bool asus_kbd_wmi_led_control_present(struct hid_device *hdev)
> +{

> +}

I have feelings that the code above should be located somewhere under
drivers/platform/x86.

-- 
With Best Regards,
Andy Shevchenko
