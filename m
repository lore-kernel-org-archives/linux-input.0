From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [RFC, PATCH 1/2] gspca: add input support for interrupt
 endpoints
Date: Fri, 20 Nov 2009 10:19:51 +0100
Message-ID: <20091120101951.720e5703@tele>
References: <4B04F7E0.1090803@freemail.hu>
 <4B05074B.1030407@redhat.com>
 <4B0641C2.1050200@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp3-g21.free.fr ([212.27.42.3]:40682 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750803AbZKTJTg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Nov 2009 04:19:36 -0500
In-Reply-To: <4B0641C2.1050200@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, V4L Mailing List <linux-media@vger.kernel.org>

Hi,

On Fri, 20 Nov 2009 08:14:10 +0100
N=E9meth M=E1rton <nm127@freemail.hu> wrote:
> Hans de Goede wrote:
> > On 11/19/2009 08:46 AM, N=E9meth M=E1rton wrote: =20
> >> Add helper functions for interrupt endpoint based input handling. =
=20
> > First of all many many thanks for doing this! =20
>=20
> You are welcome :-) . My goal is to just make my webcam working
> properly...

Many thanks from me too. This job will be useful for other webcams.

	[snip]
> > I'm personally not a big fan of adding more configuration options,
> > what should be done instead is make the compilation dependent on th=
e
> > CONFIG_INPUT kernel config option, I see no reason not to enable
> > this when CONFIG_INPUT is enabled. =20
>=20
> I added dependency on CONFIG_INPUT.

The option USB_GSPCA_SN9C20X_EVDEV should be removed too.

> > Some other remarks, you are using:
> > printk(KERN_DEBUG
> > In various places, please use
> > PDEBUG(D_FOO
> > instead so that the output can be controlled using the gspca
> > module's debug parameter. =20
>=20
> I created a PDEBUG_INPUT() for this otherwise there is a circular
> dependency between gspca_main and gspca_input because of the variable
> gspca_debug.

That is because you created a separate module.

> > And in gspca_input_connect() you are setting name to "pac7302", thi=
s
> > needs to be generalized somehow, =20
>=20
> I use now gspca_dev->sd_desc->name.

OK for me.

> > and also you are not setting the
> > input device's parent there, I think we need to fix that too
> > (although I'm not sure what it should be set to). =20
>=20
> I don't know what to use there, maybe somebody on the linux-input
> mailing list could tell.

sn9c20x sets it to &gspca_dev->dev->dev.

> Also, I am not sure about setting of input_dev->id.version.

It seems it can be EV_VERSION only.

> Unfortunately I still get the following error when I start streaming,
> stop streaming or unplug the device:
>=20
> [ 6876.780726] uhci_hcd 0000:00:10.1: dma_pool_free buffer-32,
> de0ad168/1e0ad168 (bad dma)

As there is no 'break' in gspca_input_create_urb(), many URBs are
created.

> Please find the new version of this patch later in this mail.

Here are some other remarks:

- As the input functions are called from the gspca main only, and as
  they cannot be used by other drivers, there is no need to have a
  separate module.

- Almost all other webcams who have buttons ask for polling. So, the
  'int_urb' should be pac7302 dependent (in 'struct sd' and not in
  'struct gspca_dev').

Cheers.

--=20
Ken ar c'henta=F1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
