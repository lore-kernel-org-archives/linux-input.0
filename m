From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: HID battery strength does not emit power_suppy udev events
Date: Tue, 01 Jan 2013 20:56:50 +0000
Message-ID: <1357073810.8915.14.camel@localhost>
References: <CACo8zOe7MFp_O_2rQhkSPc_+LaSUBxHvsQwSY38ukKRioDHusA@mail.gmail.com>
	 <CAD2FfiEbqUvfuUYpgQFaXoUBAn_7TnV4FnGXNDeD-jHCCfpGVQ@mail.gmail.com>
	 <CACo8zOeSf_0ump=ChJKvgLQL1_OVoOE5Ts0ybw=5S3ZFMzZcGw@mail.gmail.com>
	 <CACo8zOc5QkhotrEPdeK23rfkjPeOa5PgXpXjBUeFPrPWbTAJ1w@mail.gmail.com>
	 <1357069586.8915.11.camel@localhost>
	 <CACo8zOf9LdPA_OZSLZp3iQj80+DvVvQh_Wc6Or902SSJ2hMWVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wren.arvixe.com ([50.97.138.99]:45537 "EHLO wren.arvixe.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440Ab3AAU4z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Jan 2013 15:56:55 -0500
In-Reply-To: <CACo8zOf9LdPA_OZSLZp3iQj80+DvVvQh_Wc6Or902SSJ2hMWVg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Nicoletti <dantti12@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jeremy Fitzhardinge <jeremy@goop.org>

Dnia 2013-01-01, wto o godzinie 18:39 -0200, Daniel Nicoletti pisze:
> Well from your logs you can see the udev emitted an 'add ' for
> wacom_battery, the odd part is that it sends several add for the
> battery.
> Wacom tablets have a different code from handling the battery, i wrote
> the code that'sgeneric for hid devices, and the battery part looks
> like a lot when looking to tje wacom one but it doesn't emits 'add '
> or 'del ' events...
> I'm not kernel dev and after reading docs and digging some code I 'm
> still clueless about it... 

Can you post the code?

Do you have this switched on in your kernel config (default = no)?

config HID_BATTERY_STRENGTH
        bool "Battery level reporting for HID devices"
        depends on HID && POWER_SUPPLY && HID = POWER_SUPPLY
        default n
        ---help---
        This option adds support of reporting battery strength (for HID
devices
        that support this feature) through power_supply class so that
userspace
        tools, such as upower, can display it.

-- 
Kind regards,
Przemo Firszt


