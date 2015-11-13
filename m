From: =?iso-8859-1?Q?Cl=E9ment?= Vuchener <clement.vuchener@gmail.com>
Subject: Re: Assistance in remapping keys with no scancode in kernel module
Date: Fri, 13 Nov 2015 10:54:56 +0100
Message-ID: <20151113095456.GA24750@untxi.home>
References: <564543F9.9000109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35733 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753042AbbKMJzE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2015 04:55:04 -0500
Received: by wmdw130 with SMTP id w130so21768414wmd.0
        for <linux-input@vger.kernel.org>; Fri, 13 Nov 2015 01:55:03 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <564543F9.9000109@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marty Plummer <netz.kernel@gmail.com>
Cc: linux-input@vger.kernel.org

On Thu, Nov 12, 2015 at 07:59:21PM -0600, Marty Plummer wrote:
> Greetings
>=20
> Having recently purchased a Logitech G105 Gaming Keyboard(046d:c248) =
I've began
> the process of reverse engineering the effects of the proprietery Log=
itech
> Gaming Software (hereafter LGS) on the device to enable its full pote=
ntial in
> linux, using a number of tools (usbmon, hid-debug, virtual machines) =
to follow
> the actions and logic used.
>=20
> As of right now, I've discovered the following:
> 1. That the macro key remapping (either as standard keyboard keys or =
full macros)
>    occurs in software and is not stored on the device itself (as oppo=
sed to
>    other Logitech GSeries devices).
>=20
> 2. That keys G1-6 keys (hereafter GKeys) default to functioning as F1=
-6 until a
>    certain set of packets are sent to it from LGS or otherwise, after=
 which the
>    F1-6 functionality ends.
>=20
> 3. Before the F# keys are disabled, the GKeys sends hid reports on in=
terface 0
>    identical to 'normal' F# keys and special reports on interface 1, =
with no
>    scancode, of three bytes in size, on one hid usage, ff00.0003 (ven=
dor defined)
>    after the F# keys are disabled only the reports on interface 1 rem=
ain.
>=20
> 4. The M1-3 and MR keys (hereafter MKeys) send no reports on interfac=
e 0 at all,
>    and reports on the same usage (ff00.0003) as the GKeys.
>=20
> 5. One can easily determine which GKeys and MKeys are being pressed v=
ia bitwise
>    logic, as the three bytes follow a consistant pattern of:
>=20
>    >03 gg mm
>    where 03 is constant, gg is a value indicating the depressed GKeys=
 (0x01 << n-1)
>    AND'd together and mm is a value indicating the depressed MKeys (0=
x01 << n-1),
>    also AND'd together, where MR is treated as M4.
>=20
> 6. Absolutely no standard scancode/keycode/etc is reported for these =
keys (as
>    detectable by evtest, xev, showkeys, etc).
>=20
>=20
> My current dilemma is how one is to transform this data into somethin=
g usable,
> as the fact they all report on the same usage there is no simple way =
I can find
> to remap these keys.

You will have to parse these reports yourself by implementing the raw_e=
vent op and generate the appropriate input events. I think you also nee=
d to declare the keys you will be using in the input_configured op. You=
 should be able to find a lot of examples for that in the existing HID =
drivers.

>=20
> If anyone has any insight on this matter, please assist.
>=20
> Information on these reports and raw usbmon logs can be found at
> https://github.com/GSeriesDev/gseries-tools/g105
>=20
> 	Regards,
> 		Marty Plummer
>=20

> pub  4096R/C030918D 2015-10-13 keybase.io/the_netz <the_netz@keybase.=
io>
> sub  4096R/9FB3AD35 2015-10-13 [expire=A0: 2025-10-10]
>=20

> pub  4096R/C030918D 2015-10-13 keybase.io/the_netz <the_netz@keybase.=
io>
> sub  4096R/9FB3AD35 2015-10-13 [expire=A0: 2025-10-10]



--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
