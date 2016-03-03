From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] driver: input :touchscreen : add Raydium I2C touch
 driver
Date: Wed, 02 Mar 2016 19:55:28 -0800
Message-ID: <1456977328.4044.99.camel@perches.com>
References: <1456972150-32303-1-git-send-email-jeffrey.lin@rad-ic.com>
	 <1456973050.4044.81.camel@perches.com>
	 <9BE4B49389AB2F41A64A32DFC844F1DF73EF8627@RADHCMS5.corp.rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9BE4B49389AB2F41A64A32DFC844F1DF73EF8627@RADHCMS5.corp.rad-ic.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffrey Lin =?UTF-8?Q?=28=E6=9E=97=E7=BE=A9=E7=AB=A0=29?= <Jeffrey.Lin@rad-ic.com>, "jeffrey.lin" <yajohn@gmail.com>, "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "rydberg@euromail.se" <rydberg@euromail.se>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "jeesw@melfas.com" <jeesw@melfas.com>, "bleung@chromium.org" <bleung@chromium.org>, "scott.liu@emc.com.tw" <scott.liu@emc.com.tw>
Cc: Roger Yang =?UTF-8?Q?=28=E6=A5=8A=E9=8E=AE=E7=91=8B=29?= <Roger.Yang@rad-ic.com>, KP Li =?UTF-8?Q?=28=E6=9D=8E=E6=98=86=E5=80=8D=29?= <KP.Li@rad-ic.com>, Albert Shieh =?UTF-8?Q?=28=E8=AC=9D=E6=AC=A3=E7=91=8B=29?= <Albert.Shieh@rad-ic.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Thu, 2016-03-03 at 03:14 +0000, Jeffrey Lin (=E6=9E=97=E7=BE=A9=E7=AB=
=A0) wrote:
> Hi Joe:
> Thank you for your response. I'll follow your comments in next versio=
n.

OK, btw: the below looks very odd

> > +static int raydium_i2c_send_message(struct i2c_client *client,
> > +	size_t len, void *data)
> > +{
> > +	int error;
> > +	u8 buf[HEADER_SIZE], ii;
> > +
> > +	for (ii =3D 0; ii < HEADER_SIZE; ii++)
> > +		buf[ii] =3D ((u8 *)data)[3 - ii];

It intermixes a #define of 4 with a hard declaration of 3
to reverse copy a byte array of length HEADER_SIZE.

Maybe use:
	for (ii =3D 0; ii < HEADER_SIZE; ii++)
		buf[ii] =3D ((u8 *)data)[HEADER_SIZE - 1 - ii]
