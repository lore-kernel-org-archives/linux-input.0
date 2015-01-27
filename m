From: Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
Subject: Re: Re: [PATCH] arm: sunxi: input: RFC: Add sysfs
 voltage for sun4i-lradc driver
Date: Tue, 27 Jan 2015 11:49:49 +0200
Message-ID: <1422352189.23189.12.camel@plaes.org>
References: <1422291516-24895-1-git-send-email-plaes@plaes.org>
	 <20150127091829.GD7200@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBDJLTBEBXENBBQF6TWTAKGQEIHTAWXQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <20150127091829.GD7200@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org


On Tue, 2015-01-27 at 10:18 +0100, Maxime Ripard wrote:
> Hi,
>=20
> On Mon, Jan 26, 2015 at 06:58:32PM +0200, Priit Laes wrote:
> > ---
>=20
> Like Hans was pointing out, commit log and signed-off-by please
>=20
> >  .../ABI/testing/sysfs-driver-input-sun4i-lradc     |  4 ++
> >  drivers/input/keyboard/sun4i-lradc-keys.c          | 49=20
> > +++++++++++++++++-----
> >  2 files changed, 43 insertions(+), 10 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-input-
> > sun4i-lradc
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-driver-input-sun4i-
> > lradc b/Documentation/ABI/testing/sysfs-driver-input-sun4i-lradc
> > new file mode 100644
> > index 0000000..e4e6448
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-input-sun4i-lradc
> > @@ -0,0 +1,4 @@
> > +What:          /sys/class/input/input(x)/device/voltage
> > +Date:          February 2015
> > +Contact:       Priit Laes <plaes-q/aMd4JkU83YtjvyW6yDsg@public.gmane.org>
> > +Description:   ADC output voltage in microvolts or 0 if device is=20
> > not opened.
>=20
> Why is it returning 0 when "device is not opened" ? What does that=20
> even mean? You can't read that file without opening it.

It means that something has to open the /dev/input/inputX device which=20
sets up the ADC before the voltage can be read from the sysfs file.

[...]


>=20
> As I told you already, if you're going to expose this an ADC in the=20
> end, the proper solution is to use the IIO framework, not adding a=20
> custom sysfs file.

My intention was to expose just a simple debug output, so one can=20
press the buttons and read the voltages for devicetree keymap.

If anyone can suggest a simpler approach than current sysfs based one,=20
I would do it. But full blown iio driver is currently out of scope.=20
Also, Carlo's (ccaione) initially submitted (?) driver for lradc=20
utilized iio subsystem.

P=C3=A4ikest,
Priit :)

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
