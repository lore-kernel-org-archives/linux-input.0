From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: usbhid: PicoLCD 256x64 USB error -71
Date: Sun, 18 May 2014 20:37:18 +0200
Message-ID: <20140518203718.5422588f@neptune.home>
References: <032001cf7156$31a75610$94f60230$@obe.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from hygieia.santi-shop.eu ([78.46.175.2]:49158 "EHLO
	hygieia.santi-shop.eu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766AbaERSng convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 18 May 2014 14:43:36 -0400
In-Reply-To: <032001cf7156$31a75610$94f60230$@obe.tv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kieran Kunhya <kierank@obe.tv>
Cc: linux-input@vger.kernel.org

Hi Kieran,

On Fri, 16 May 2014 "Kieran Kunhya" <kierank@obe.tv> wrote:
> As requested I forward my bug report to the list:
>=20
> From time to time on an ASRock IMB-181D motherboard this device fails=
 to be
> added.=C2=A0
> It seems to work reliably when using Windows 7.=C2=A0
> The errors in dmesg vary but usually take the form:=C2=A0
> [=C2=A0 5.328040] usb 3-7: string descriptor 0 read error: -71=C2=A0
> (snip)=C2=A0
> [=C2=A0 10.333605] usbhid 3-7:1.0: can't add hid device: -71=C2=A0
> [=C2=A0 10.333639] usbhid: probe of 3-7:1.0 failed with error -71=C2=A0
> I can provide a PicoLCD unit if necessary and possibly also fund a
> fix/workaround.
>=20
> More information is available here:
> https://bugzilla.kernel.org/show_bug.cgi?id=3D76341

Hm, picoLCD works for me, but I get -71 error code if I swap both
data pins (but with read failure "device descriptor read/64, error -71"=
).

Here it works with:
  J4, pin 1 =3D red
  J4, pin 2 =3D white
  J4, pin 3 =3D green
  J4, pin 4 =3D black
  J4, pin 5 =3D n/a

I successfully tried on:
- Gigabyte mainboard (GA-A75M-UD2H) (USB2 & USB3 ports) [3.15-rc5, 64bi=
t]
- Acer Travelmate 66x [3.15-rc2, 32bit]
- Commell LE-365 [3.14, 32bit]
- IEI KINO-690S1 [3.14, 64bit]


Did some previous kernel release work?
Could you provide verbose lsusb output and firmware version for your Pi=
coLCD?

Thanks,
Bruno
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
