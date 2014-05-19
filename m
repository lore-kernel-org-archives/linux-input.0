From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [linux-sunxi] Re: [PATCH v5 4/8] input: misc: Add driver for
 AXP20x Power Enable Key
Date: Mon, 19 May 2014 14:28:37 +0100
Message-ID: <20140519132837.GI4978@lee--X1>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-5-git-send-email-carlo@caione.org>
 <20140503010604.GE4090@lukather>
 <20140519055745.GL29386@core.coreip.homeip.net>
 <CAOQ7t2bPHnjfpeqQjMsYJs--qpd1_1RvBEFXztTDgnf5yW=Yxg@mail.gmail.com>
 <20140519091553.GC4978@lee--X1>
 <CAOQ7t2a=V_dO17Xg4VJUTV3W_OFCaE5Wuj15_Fox2jywjH+RPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOQ7t2a=V_dO17Xg4VJUTV3W_OFCaE5Wuj15_Fox2jywjH+RPg@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org, boris.brezillon@free-electrons.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-sunxi@googlegroups.com
List-Id: linux-input@vger.kernel.org

On Mon, 19 May 2014, Carlo Caione wrote:

> On Mon, May 19, 2014 at 11:15 AM, Lee Jones <lee.jones@linaro.org> wr=
ote:
> > On Mon, 19 May 2014, Carlo Caione wrote:
> >
> >> On Mon, May 19, 2014 at 7:57 AM, Dmitry Torokhov
> >> <dmitry.torokhov@gmail.com> wrote:
> >> > On Fri, May 02, 2014 at 06:06:04PM -0700, Maxime Ripard wrote:
> >> >> On Thu, May 01, 2014 at 02:29:30PM +0200, Carlo Caione wrote:
> >> >> > This patch add support for the Power Enable Key found on MFD =
AXP202 and
> >> >> > AXP209. Besides the basic support for the button, the driver =
adds two
> >> >> > entries in sysfs to configure the time delay for power on/off=
=2E
> >> >> >
> >> >> > Signed-off-by: Carlo Caione <carlo@caione.org>
> >> >>
> >> >> Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> >> >
> >> > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> >> >
> >> > How are we merging it? MFD tree?
> >>
> >> No idea. Lee, can you help in merging it?
> >> The only thing still  left out is the DT to be merged through Maxi=
me
> >> (I need to submit a v6 only for that).
> >
> > Yes.
> >
> > Weren't you in receipt of my email sent out an hour before this one=
?
>=20
> Yes, but this email was sent before receiving yours :)
>=20
> > I thought you were re-sending the test though (v6?).
> >
> > If you can set that, complete with all the Acks, I'd be much oblige=
d.
>=20
> Ok, no problem. I'll also fix a small compilation-warning spotted by =
Hans.

Great thanks, and sorry for all the typos, I was in a rush. :)

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
