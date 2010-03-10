From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] input: use input_mutex instead of BKL when opening input device
Date: Tue, 9 Mar 2010 22:56:38 -0800
Message-ID: <201003092256.39223.dmitry.torokhov@gmail.com>
References: <1268162386-2745-1-git-send-email-cascardo@holoscopio.com> <20100310062015.GA2445@core.coreip.homeip.net> <201003100749.20723.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201003100749.20723.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Kacur <jkacur@gmail.com>, jkosina@suse.cz
List-Id: linux-input@vger.kernel.org

On Tuesday 09 March 2010 10:49:20 pm Oliver Neukum wrote:
> Am Mittwoch, 10. M=E4rz 2010 07:20:15 schrieb Dmitry Torokhov:
> > > I was willing to let the open call go unprotected. But ended up
> > > checking that the three callees were fine (they do not call any o=
f the
> > > other functions that take the mutex).
> > >=20
> > > Since the fops_put/fops_get do protect that section from the hand=
ler
> > > removal and I can't think of any other race right now, I think yo=
ur
> > > version is really better.
> > >=20
> > > Acked-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> >=20
> > OK, applied 2 Thadeu's patches and one Arnd's.
>=20
> Jiri,
>=20
> it is possible that this requires a change in usbhid as it uses BKL.
> Do you remember?
>

No, different layer altogether.

--=20
Dmitry
