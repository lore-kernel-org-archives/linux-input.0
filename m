From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [PATCH 2/3] input: use input_mutex instead of BKL when opening input device
Date: Wed, 10 Mar 2010 07:49:20 +0100
Message-ID: <201003100749.20723.oliver@neukum.org>
References: <1268162386-2745-1-git-send-email-cascardo@holoscopio.com> <20100309205947.GB1498@holoscopio.com> <20100310062015.GA2445@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100310062015.GA2445@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, John Kacur <jkacur@gmail.com>, jkosina@suse.cz
List-Id: linux-input@vger.kernel.org

Am Mittwoch, 10. M=E4rz 2010 07:20:15 schrieb Dmitry Torokhov:
> > I was willing to let the open call go unprotected. But ended up che=
cking
> > that the three callees were fine (they do not call any of the other
> > functions that take the mutex).
> >=20
> > Since the fops_put/fops_get do protect that section from the handle=
r
> > removal and I can't think of any other race right now, I think your
> > version is really better.
> >=20
> > Acked-by: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
> >=20
>=20
> OK, applied 2 Thadeu's patches and one Arnd's.

Jiri,

it is possible that this requires a change in usbhid as it uses BKL.
Do you remember?

	Regards
		Oliver
