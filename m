From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 5/7] mfd: cros_ec: wait for completion of commands
 that return IN_PROGRESS
Date: Mon, 8 Sep 2014 13:48:11 +0100
Message-ID: <20140908124811.GD26284@lee--X1>
References: <1408974008-17184-1-git-send-email-javier.martinez@collabora.co.uk>
 <1408974008-17184-6-git-send-email-javier.martinez@collabora.co.uk>
 <20140904083426.GD8257@lee--X1>
 <540D9577.9000702@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <540D9577.9000702@collabora.co.uk>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Wolfram Sang <wsa@the-dreams.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Doug Anderson <dianders@chromium.org>, Simon Glass <sjg@chromium.org>, Bill Richardson <wfrichar@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Derek Basehore <dbasehore@chromium.org>, Todd Broch <tbroch@chromium.org>, Olof Johansson <olof@lixom.net>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mon, 08 Sep 2014, Javier Martinez Canillas wrote:
> On 09/04/2014 10:34 AM, Lee Jones wrote:
> > On Mon, 25 Aug 2014, Javier Martinez Canillas wrote:
> >> From: Andrew Bresticker <abrestic@chromium.org>
> >>=20
> >> When an EC command returns EC_RES_IN_PROGRESS, we need to query
> >> the state of the EC until it indicates that it is no longer busy.
> >> Do this in cros_ec_cmd_xfer() under the EC's mutex so that other
> >> commands (e.g. keyboard, I2C passtru) aren't issued to the EC whil=
e
> >> it is working on the in-progress command.
> >>=20
> >> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> >> Reviewed-by: Simon Glass <sjg@chromium.org>
> >> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora=
=2Eco.uk>
> >> ---
> >>=20
> >> Changes since v1:
> >>  - The *xfer() calls don't modify the passed cros_ec_command so th=
ere is
> >>    no need to populate it inside the for loop. Suggested by Lee Jo=
nes.
> >> ---
> >>  drivers/mfd/cros_ec.c | 34 +++++++++++++++++++++++++++++++++-
> >>  1 file changed, 33 insertions(+), 1 deletion(-)
> >>=20
> >> diff --git a/drivers/mfd/cros_ec.c b/drivers/mfd/cros_ec.c
> >> index c53804a..cd0c93c 100644
> >> --- a/drivers/mfd/cros_ec.c
> >> +++ b/drivers/mfd/cros_ec.c

[...]

> >>  	mutex_lock(&ec_dev->lock);
> >>  	ret =3D ec_dev->cmd_xfer(ec_dev, msg);
> >> +	if (ret =3D=3D -EAGAIN && msg->result =3D=3D EC_RES_IN_PROGRESS)=
 {
> >=20
> > Is there ever a time where (ret =3D=3D -EAGAIN) but (msg->result !=3D
> > EC_RES_IN_PROGRESS) [note the !=3D].  And/or is there ever a time w=
here
> > (msg->result =3D=3D EC_RES_IN_PROGRESS) but (ret !=3D -EAGAIN) [aga=
in, not
> > the !=3D].
> >=20
> > Another way of explaining it.  Can ret be anything other than -EAGA=
IN
> > when the result is EC_RES_IN_PROGRESS.  And can the result be anyth=
ing
> > other than EC_RES_IN_PROGRESS when ret is -EAGAIN?

[...]

> But after looking at all the cros_ec transport drivers it seems to be=
 safe to
> just check if result is EC_RES_IN_PROGRESS instead of checking also i=
f ret is
> -EAGAIN since (at least on all the current transport drivers) the for=
mer
> implies the later.

That's exactly what I was getting at.

[...]

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
