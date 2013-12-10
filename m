From: "duson" <dusonlin@emc.com.tw>
Subject: RE: [PATCH 1/2] elantech: Properly differentiate between clickpads and normal touchpads
Date: Tue, 10 Dec 2013 17:29:09 +0800
Message-ID: <036E3BE6492F4925B4C5A93F2E2659E9@elan.corp>
References: <1386599551-2339-1-git-send-email-hdegoede@redhat.com> <CAN+gG=Eh72eBS67db_KNsUzXRNsOUXB8YkzuuHoJca22xRAkdQ@mail.gmail.com> <52A6169C.1020904@redhat.com> <CAN+gG=FgR9cBwJ_GFrU3RAmwma0XWzt8Wdi-HM2zEOOmdPNS+A@mail.gmail.com> <20131210061256.GA12524@core.coreip.homeip.net> <CF3F8F5F02EE401CBA8F5EFBCC62074D@elan.corp> <52A6D4B0.20206@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:53880 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753679Ab3LJJ3f convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Dec 2013 04:29:35 -0500
In-Reply-To: <52A6D4B0.20206@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Hans de Goede' <hdegoede@redhat.com>
Cc: 'linux-input' <linux-input@vger.kernel.org>, 'Peter Hutterer' <peter.hutterer@redhat.com>, =?big5?B?J7bApUDEUCc=?= <phoenix@emc.com.tw>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Benjamin Tissoires' <benjamin.tissoires@gmail.com>

Hi Hans:

> -----Original Message-----
> From: linux-input-owner@vger.kernel.org
[mailto:linux-input-owner@vger.kernel.org]
> On Behalf Of Hans de Goede
> Sent: Tuesday, December 10, 2013 4:46 PM
> To: duson; 'Dmitry Torokhov'; 'Benjamin Tissoires'
> Cc: 'linux-input'; 'Peter Hutterer'; '=B6=C0=A5@=C4P'
> Subject: Re: [PATCH 1/2] elantech: Properly differentiate between
clickpads and
> normal touchpads
>=20
> Hi Duson,
>=20
> On 12/10/2013 09:35 AM, duson wrote:
>=20
> <snip>
>=20
> >> We should not advertise events that device does not generate. This
> >> should help userspace to decide if emulation is needed or not. Inp=
ut
> >> core will drop events that are not set up as valid for device, so =
if we
> >> clear BTN_RIGHT there it should all work.
> >
> > Actually, our touchpad for PS2 protocol implements the left and rig=
ht
click
> > function, even thought, it is a click-pad. And the flag for left/ri=
ght
click
> > information is recorded in the first byte of the packet (when doing=
 sync
> > method).
> > 	Byte0 Bit 0 --> for left click flag
> > 	Byte0 Bit1 --> for right click flag
> > When user presses the left-bottom area of the click-pad, only the l=
eft
click
> > flag will be set to "1". On the other hand, pressing the right-bott=
om
area
> > of the click-pad, only the right click flag will be set to "1".
> > So, I think this is the cause of the BTN_RIGHT need to be set.
>=20
> Are you sure? All info we have so far indicates that the right button
needs
> to be emulated in software in the clickpad case, ie a while back this
> commit was added:
>=20
>
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/=
drive
rs/input/mous
> e/elantech.c?id=3De3dde4fba94e0ba5e1fd79ea9e5389eea1f0cfec
>=20
> To fix the right button not working, this also removes the checking
> for bit 1 / reporting of BTN_RIGHT events, so if the right click area
> would actually send right clicks I would expect the above commit to
> have broken right clicking for tons of users, and we have no bug repo=
rts
> about this (my patch fixes the right button being broken in the non
> clickpad case).
>=20
> Note that the Linux driver uses the touchpad in absolute mode, not in
> relative / ps/2 mouse emulation mode. Could it be that the handling o=
f the
> right button emulation for clickpads is only done in the firmware in
> relative mode ?
>=20
> Or maybe it is done in firmware for hardware v3 clickpads, but not fo=
r
> v4 clickpads ?
>=20
Sorry, this is my mistake. I had confirmed our firmware engineer again.
The correct answer is "When using click-pad in absolute mode only the l=
eft
click function work." So, both the left/right click function is enabled=
 when
using normal smart-pad (non-clickpad) or clickpad in relative mode.

Thanks,
Duson

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
