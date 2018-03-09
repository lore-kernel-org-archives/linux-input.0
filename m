From: Stephan Mueller <smueller@chronox.de>
Subject: Re: [PATCH v3] input: bcm5974 - Add driver for Apple Magic Trackpad 2
Date: Fri, 09 Mar 2018 20:49:57 +0100
Message-ID: <2373130.0OS7LSYeBT@tauon.chronox.de>
References: <40764439.8xGR6LbaWR@positron.chronox.de> <2305311.UGlXl2onVb@positron.chronox.de> <1566223.3I8hjEaRec@tauon.chronox.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1566223.3I8hjEaRec@tauon.chronox.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, linux-input@vger.kernel.org, marek.wyborski@emwesoft.com, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Am Dienstag, 27. Februar 2018, 17:37:45 CET schrieb Stephan Mueller:

Hi Jiri, Dimity, Henrik,

> Am Sonntag, 21. Januar 2018, 23:06:55 CET schrieb Stephan M=FCller:
>=20
> Hi Jiri, Dimity, Henrik,
>=20
> > Hi,
> >=20
> > Changes v3:
> > * port to 4.15-rc8
> > * small code cleanups (isolation of type casts to functions pertaining
> >=20
> >   to the Apple Magic Trackpad 2
> >=20
> > * clean up all checkpatch.pl errors and warnings (except those
> >=20
> >   where the patch uses the structure of existing code fragments)
> >=20
> > * updated horizontal and vertical limits to capture start of movements
> >=20
> >   in the outer areas of the pad
> >=20
> > ---8<---
> >=20
> > Add support for Apple Magic Trackpad 2 in bcm5974 (MacBook Tochpad)
> > driver.
> > The Magic Trackpad 2 needs to be switched into the finger-reporting-mod=
e,
> > just like the other macbook touchpads as well. But the format is differ=
ent
> > to the ones before. The Header is 12 Bytes long and each reported finger
> > is additional 9 Bytes. The data order reported by the hardware is
> > different as well.
>=20
> May I ask whether there is an issue in the patch? I have not received any
> feedback and would like to inquire about the status of the patch.
>=20
> I would like to have Touchpad 2 properly supported.

<nudge>

Ciao
Stephan
