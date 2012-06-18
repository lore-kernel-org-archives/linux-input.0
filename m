From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH] HID: select NEW_LEDS for driver of Lenovo ThinkPad USB
 Keyboard with TrackPoint
Date: Mon, 18 Jun 2012 10:24:54 -0700
Message-ID: <4FDF6466.2040808@xenotime.net>
References: <1339930354-1040-1-git-send-email-bryan.wu@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from oproxy6-pub.bluehost.com ([67.222.54.6]:50575 "HELO
	oproxy6-pub.bluehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752272Ab2FRRZQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 13:25:16 -0400
In-Reply-To: <1339930354-1040-1-git-send-email-bryan.wu@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: mail@bernhard-seibold.de, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, torvalds@linux-foundation.org, jkosina@suse.cz, linux-input@vger.kernel.org, linux-leds@vger.kernel.org

On 06/17/2012 03:52 AM, Bryan Wu wrote:

> commit 'HID: Driver for Lenovo Keyboard with Trackpoint'
> (c1dcad2d32d0252e8a3023d20311b52a187ecda3) introduced a compiling error due to
> unmetting dependency of CONFIG_LEDS_CLASS.
> 
> on i386:
> 
> ERROR: "led_brightness_set" [drivers/leds/led-class.ko] undefined!
> ERROR: "leds_list" [drivers/leds/led-class.ko] undefined!
> ERROR: "leds_list_lock" [drivers/leds/led-class.ko] undefined!
> 
> and possibly related:
> 
> warning: (ADB_PMU_LED && IWLWIFI && IWLEGACY && ATH5K && ATH9K && ATH9K_HTC && CARL9170_LEDS && TABLET_USB_WACOM && INPUT_WISTRON_BTNS && SENSORS_APPLESMC && IR_WINBOND_CIR && BACKLIGHT_ADP8860 && BACKLIGHT_ADP8870 && HID_LENOVO_TPKBD && ACER_WMI && ASUS_LAPTOP && DELL_LAPTOP && HP_ACCEL && THINKPAD_ACPI && EEEPC_LAPTOP && ASUS_WMI && ACPI_TOSHIBA && SAMSUNG_LAPTOP) selects LEDS_CLASS which has unmet direct dependencies (NEW_LEDS)
> 
> Reported-by: Randy Dunlap <rdunlap@xenotime.net>
> Signed-off-by: Bryan Wu <bryan.wu@canonical.com>


Acked-by: Randy Dunlap <rdunlap@xenotime.net>

Thanks.


> ---
>  drivers/hid/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index bb4fd6b..cea0951 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -271,6 +271,7 @@ config HID_LCPOWER
>  config HID_LENOVO_TPKBD
>  	tristate "Lenovo ThinkPad USB Keyboard with TrackPoint"
>  	depends on USB_HID
> +	select NEW_LEDS
>  	select LEDS_CLASS
>  	---help---
>  	Support for the Lenovo ThinkPad USB Keyboard with TrackPoint.



-- 
~Randy
