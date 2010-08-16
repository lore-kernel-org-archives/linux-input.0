From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH RESEND] USB HID: Add ID for eGalax Multitouch used in
 JooJoo tablet
Date: Mon, 16 Aug 2010 15:58:16 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1008161557020.1019@pobox.suse.cz>
References: <m339wl2ug6.fsf@pullcord.laptop.org>  <m3hbiz8m11.fsf@pullcord.laptop.org> <alpine.LNX.2.00.1008130113530.2702@pobox.suse.cz> <C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:45990 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507Ab0HPN6U (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Aug 2010 09:58:20 -0400
In-Reply-To: <C6B3DDC8-79F3-47FC-BC26-244C49998852@enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?St=E9phane_Chatty?= <chatty@enac.fr>
Cc: Chris Ball <cjb@laptop.org>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, tito@bankiz.org

On Fri, 13 Aug 2010, St=E9phane Chatty wrote:

> In summary this is a new kind of panel with an unusual HID prototol a=
nd the
> hid-egalax driver fails at producing a proper event sequence. The maj=
or issue
> here is that the key to resolving the problem does *not* lie in the d=
river:
> SYNC messages are produced in hid-input.c and drivers cannot block th=
em. To
> address this, one would need to make the <HID event> -> <input event>=
 + <sync>
> mapping less systematic. This could converge with the efforts require=
d if we
> were to have a more generic management of multitouch devices (we need=
 one
> driver for each device because hid-core.c was not designed with this =
kind of
> device in mind).
>=20
> My suggestions:
> - accept the patch, after adding a few comments in the code about thi=
s device
> requiring future care for its 'serial' protocol.
> - start thinking about what changes are required in hid-input and/or =
hid-core
> for a more generic management of multitouch devices.

Hi Stephane,

thanks for the analysis. How do devices in their report descriptor=20
describe the fact whether the events should be interleaved by sync or n=
ot?

We definitely could create a specialized version of=20
hidinput_report_event() for certain reports, which wouldn't issue the=20
input_sync() call, but I wonder what is the distinguishing factor.

--=20
Jiri Kosina
SUSE Labs, Novell Inc.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
