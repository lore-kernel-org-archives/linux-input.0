From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v5 4/8] input: misc: Add driver for AXP20x Power Enable
 Key
Date: Mon, 19 May 2014 08:23:48 +0100
Message-ID: <20140519072348.GD2339@lee--X1>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-5-git-send-email-carlo@caione.org>
 <20140503010604.GE4090@lukather>
 <20140519055745.GL29386@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140519055745.GL29386@core.coreip.homeip.net>
Sender: linux-doc-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Carlo Caione <carlo@caione.org>, linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, boris.brezillon@free-electrons.com
List-Id: linux-input@vger.kernel.org

> > > This patch add support for the Power Enable Key found on MFD AXP2=
02 and
> > > AXP209. Besides the basic support for the button, the driver adds=
 two
> > > entries in sysfs to configure the time delay for power on/off.
> > >=20
> > > Signed-off-by: Carlo Caione <carlo@caione.org>
> >=20
> > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> How are we merging it? MFD tree?

Yes, I'm happy to do that.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
