From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: evdev - fix variable initialisation
Date: Fri, 3 Feb 2012 00:37:08 -0800
Message-ID: <20120203083707.GC24226@core.coreip.homeip.net>
References: <201201312224.46360.heiko@sntech.de>
 <CAPz4a6DDwt2uEX1o3ULSESjnVqMA1gBWoFP27XCviaOXd1-fpw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPz4a6DDwt2uEX1o3ULSESjnVqMA1gBWoFP27XCviaOXd1-fpw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dima Zavin <dima@android.com>
Cc: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tue, Jan 31, 2012 at 01:40:42PM -0800, Dima Zavin wrote:
> ugh, thanks for fixing this.
>=20
> On Tue, Jan 31, 2012 at 1:24 PM, Heiko St=FCbner <heiko@sntech.de> wr=
ote:
> > Commit 509f87c5f564 (evdev - do not block waiting for an event if f=
d
> > is nonblock) created a code path were it was possible to use retval
> > uninitialized.
> >
> > This could lead to the xorg evdev input driver getting corrupt data
> > and refusing to work with log messages like
> > =A0 =A0 =A0 =A0AUO-Pixcir touchscreen: Read error: Success
> > =A0 =A0 =A0 =A0sg060_keys: Read error: Success
> > =A0 =A0 =A0 =A0AUO-Pixcir touchscreen: Read error: Success
> > =A0 =A0 =A0 =A0sg060_keys: Read error: Success
> > (for drivers auo-pixcir-ts and gpio-keys).
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
>=20
> Acked-by: Dima Zavin <dima@android.com>
>=20

Applied, thank you.

--=20
Dmitry
