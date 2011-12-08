From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] HID: wiimote: Select INPUT_FF_MEMLESS
Date: Thu, 8 Dec 2011 09:31:20 +0100
Message-ID: <CANq1E4T6uoezonoaBk6agD4-6A7QMSiP0ySDPg+5r50G8LYWTA@mail.gmail.com>
References: <4EDFD23D.4030703@xenotime.net>
	<1323290039-28073-1-git-send-email-dh.herrmann@googlemail.com>
	<b92a2d1d30910b75f3354926d9fa26f6.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <b92a2d1d30910b75f3354926d9fa26f6.squirrel@host171.canaca.com>
Sender: linux-next-owner@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org, rdunlap@xenotime.net, linux-next@vger.kernel.org, jkosina@suse.cz, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Dec 7, 2011 at 10:07 PM,  <simon@mungewell.org> wrote:
>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index edf2b2b..dae04a0 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -591,6 +591,7 @@ config HID_WIIMOTE
>> =A0 =A0 =A0 depends on BT_HIDP
>> =A0 =A0 =A0 depends on LEDS_CLASS
>> =A0 =A0 =A0 select POWER_SUPPLY
>> + =A0 =A0 select INPUT_FF_MEMLESS
>> =A0 =A0 =A0 ---help---
>> =A0 =A0 =A0 Support for the Nintendo Wii Remote bluetooth device.
>
> I don't mean to be a complainer, but shouldn't the WiiMote module dep=
end
> on FF_MEMLESS rather than just forcing it on.

I have considered that but "grep -r FF_MEMLESS" returned no other
driver using "depend" so I decided to use "select", too.

> The module could also #define the appropriate bits so that FF_MEMLESS=
 was
> only used when available, the rumble motor is a very small part of th=
e
> WiiMote's feature set.
>
> Some people might not want FF_MEMLESS enabled.

Why? It is a really small feature that depends only on CONFIG_INPUT.
Just 600 lines of code. I don't see why someone who wants to enable
the way bigger wiimote driver and HID core would bother about
=46F_MEMLESS? Why should someone want to disable the rumble-feature of
the wiimote?
I cannot see any real use-case here. Maybe you can explain a bit more.

> Simon.
>

Cheers
David
