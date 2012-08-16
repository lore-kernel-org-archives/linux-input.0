From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 0/7] HID: picoLCD updates
Date: Thu, 16 Aug 2012 18:47:04 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1208161846240.28475@pobox.suse.cz>
References: <20120730213656.0a9f6d30@neptune.home> <alpine.LNX.2.00.1208151016221.7026@pobox.suse.cz> <20120815114236.0f7db40e@neptune.home> <alpine.LNX.2.00.1208151409500.7026@pobox.suse.cz> <20120815171635.2564a4a8@neptune.home> <alpine.LNX.2.00.1208152329580.7026@pobox.suse.cz>
 <20120816183021.68c37f37@neptune.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120816183021.68c37f37@neptune.home>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-15?Q?Bruno_Pr=E9mont?= <bonbons@linux-vserver.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 16 Aug 2012, Bruno Pr=C3=A9mont wrote:

> > I don't really understand this explanation. Once usb_kill_urb() ret=
urns,=20
> > the URB should be available for future use (and therefore all queue=
s=20
> > completely drained).
>=20
> I won't have time today to check, though my guess is that on each
> echo $usb-id > bind; echo $usb-id > unbind
> under /sys/bus/hid/drivers/hid-picolcd/ the USB urb queue fills a bit=
 does
> not get cleared.
>=20
> Is usb_kill_urb() called when unbinding just the specific hid driver?=
=20

Yup, through hid_hw_stop() -> usbhid_stop().

> If so my short timing between bind/unbind must be triggering somethin=
g=20
> else...
>=20
> Otherwise I'm missing something as at first time I got no "output que=
ue full"
> messages, but as I repeated the bind/unbind sequences the prints per =
bind/unbind
> iteration increased in number.
>=20
> Anyhow, on Friday evening/week-end I will continue digging and report=
 back with my
> findings.

Thank you, Bruno.

--=20
Jiri Kosina
SUSE Labs
