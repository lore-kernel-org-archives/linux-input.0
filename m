From: Benjamin Tissoires <btissoir@redhat.com>
Subject: Re: [RFC 1/5] INPUT: xpad: Add minimal support for Logitech G920
 Wheel
Date: Mon, 9 Nov 2015 02:54:42 -0500 (EST)
Message-ID: <2114631127.4162575.1447055682337.JavaMail.zimbra@redhat.com>
References: <1445621247-18806-1-git-send-email-simon@mungewell.org> <alpine.LNX.2.00.1510301450380.17538@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.LNX.2.00.1510301450380.17538@pobox.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Simon Wood <simon@mungewell.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Edwin <Edwin@Velds.nl>, Michal =?utf-8?B?TWFsw70=?= <madcatxster@devoid-pointer.net>, elias vanderstuyft <elias.vds@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

Hi,

----- Original Message -----
> From: "Jiri Kosina" <jikos@kernel.org>
> To: "Simon Wood" <simon@mungewell.org>
> Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, "Edwin=
" <Edwin@Velds.nl>, "Michal Mal=C3=BD"
> <madcatxster@devoid-pointer.net>, "elias vanderstuyft" <elias.vds@gma=
il.com>, "Benjamin Tissoires"
> <benjamin.tissoires@redhat.com>
> Sent: Friday, October 30, 2015 2:51:47 PM
> Subject: Re: [RFC 1/5] INPUT: xpad: Add minimal support for Logitech =
G920 Wheel
>=20
> On Fri, 23 Oct 2015, Simon Wood wrote:
>=20
> > When plugged in the Logitech G920 wheel starts with USBID 046d:c261
> > and behaviors as a vendor specific class. If a 'magic' byte sequenc=
e
> > is sent the wheel will detach and reconnect as a HID device with th=
e
> > USBID 046d:c262.
>=20
> [ Benjamin added to CC ]
>=20
> Benjamin, before I proceed with this series, I'd like you to have rev=
iew
> the HID++ bits at least, if possible. Thanks,
>=20

Sorry for the lag everybody. I have been busy the past week with my mov=
e across the Atlantic. I'll review it in a few minutes.

Just so you know Jiri, I have seen preliminary patches of this series w=
hile it was still embargoed by Logitech, and IIRC Simon already include=
d changes I requested at the time.

Cheers,
Benjamin
