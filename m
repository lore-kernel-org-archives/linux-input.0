From: Terry Lambert <tlambert@chromium.org>
Subject: Re: [PATCH] Driver for Primax keyboards violating USB HID spec
Date: Mon, 17 Oct 2011 12:21:16 -0700
Message-ID: <CAA_E9NH0EznO9xc7L=5GuqbZyFSWQU1J1HWzAYbuP5YTFzuXaw@mail.gmail.com>
References: <1318637934-30006-1-git-send-email-tlambert@chromium.org>
	<alpine.LNX.2.00.1110171710570.3541@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1110171710570.3541@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Cool, thanks! I was mildly unsure of that anyway, and had copied it
from a similar one for the Microsoft HID driver.

-- Terry

On Mon, Oct 17, 2011 at 8:11 AM, Jiri Kosina <jkosina@suse.cz> wrote:
> On Fri, 14 Oct 2011, Terry Lambert wrote:
>
>> Primax keyboards with the issue this driver addresses report modifie=
r
>> keys as in band key events instead of as out of band modifier bits,
>> resulting in the modifier keys generating key up events immediately
>> before the keys they are intended to modify. =A0This driver rewrites
>> the raw report data from such keyboards into USB HID 1.11 compliant
>> report data. =A0It only matches the USB vendor and product IDs for t=
he
>> keyboard it has been tested on. Since there are several keyboards,
>> notably a number of laptops and folding USB keyboards known to have
>> similar unresolved problem reports, the list is expected to grow.
>>
>> Signed-off-by: Terry Lambert <tlambert@chromium.org>
>> ---
>> =A0drivers/hid/Kconfig =A0 =A0 =A0| =A0 =A08 +++
>> =A0drivers/hid/Makefile =A0 =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-core.c =A0 | =A0 =A01 +
>> =A0drivers/hid/hid-ids.h =A0 =A0| =A0 =A03 +
>> =A0drivers/hid/hid-primax.c | =A0117 +++++++++++++++++++++++++++++++=
+++++++++++++++
>> =A05 files changed, 130 insertions(+), 0 deletions(-)
>> =A0create mode 100644 drivers/hid/hid-primax.c
>>
>> diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
>> index 1130a89..a097e17 100644
>> --- a/drivers/hid/Kconfig
>> +++ b/drivers/hid/Kconfig
>> @@ -441,6 +441,14 @@ config HID_PICOLCD_LEDS
>> =A0 =A0 =A0 ---help---
>> =A0 =A0 =A0 =A0 Provide access to PicoLCD's GPO pins via leds class.
>>
>> +config HID_PRIMAX
>> + =A0 =A0 tristate "Primax non-fully HID-compliant devices" if EXPER=
T
>> + =A0 =A0 depends on USB_HID
>> + =A0 =A0 default !EXPERT
>
> I have removed thi 'EXPERT' dependency (please see changelog of commi=
t
> 73d5e8f77e8 for rationale behind that) and applied. Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>
