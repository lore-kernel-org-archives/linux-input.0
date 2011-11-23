From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH RFC] hid-input: add support for HID devices reporting
 Battery Strength
Date: Wed, 23 Nov 2011 08:36:11 -0800
Message-ID: <4ECD20FB.7030705@canonical.com>
References: <4EC75224.7070207@goop.org> <alpine.LNX.2.00.1111191212140.15187@pobox.suse.cz> <4EC820F8.4070900@goop.org> <alpine.LNX.2.00.1111201110480.15187@pobox.suse.cz> <4ECA7E7D.80207@goop.org> <alpine.LNX.2.00.1111220028130.28728@pobox.suse.cz> <4ECAE019.4000409@goop.org> <alpine.LNX.2.00.1111220049470.28728@pobox.suse.cz> <4ECCB38A.8000503@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:48804 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688Ab1KWQgW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Nov 2011 11:36:22 -0500
In-Reply-To: <4ECCB38A.8000503@goop.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, vojtech@ucw.cz, Przemo Firszt <przemo@firszt.eu>

On 11/23/2011 12:49 AM, Jeremy Fitzhardinge wrote:
> Some HID devices, such as my Bluetooth mouse, report their battery
> strength as an event.  Rather than passing it through as a strange
> absolute input event, this patch registers it with the power_supply
> subsystem as a battery, so that the device's Battery Strength can be
> reported to usermode.
> 
> The battery appears in sysfs names
> /sys/class/power_supply/hid-<UNIQ>-battery, and it is a child of the
> battery-containing device, so it should be clear what it's the battery of.
> 
> Unfortunately on my current Fedora 16 system, while the battery does
> appear in the UI, it is listed as a Laptop Battery with 0% charge (since
> it ignores the "capacity" property of the battery and instead computes
> it from the "energy*" fields, which we can't supply given the limited
> information contained within the HID Report).
> 
> Still, this patch is the first step.
> 
> Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
> 
> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
> index 22a4a05..3a97f1f 100644
> --- a/drivers/hid/Kconfig
> +++ b/drivers/hid/Kconfig
> @@ -31,6 +31,11 @@ config HID
>  
>  	  If unsure, say Y.
>  
> +config HID_BATTERY_STRENGTH
> +	bool
> +	depends on POWER_SUPPLY
> +	default y

This functionality will be great to have :). I'm curious why you made a
config option for it, though. It's not a big patch, I can't think of any
reason people wouldn't want it, and this could lead to dependency issues
(i.e. needing to sprinkle #ifdef HID_BATTERY_STRENGTH in drivers).

-- Chase
