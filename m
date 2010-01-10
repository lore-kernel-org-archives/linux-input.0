From: Artem Bityutskiy <dedekind1@gmail.com>
Subject: Re: [PATCH v3 0/1] Input: gpio-keys: support for disabling GPIOs
Date: Sun, 10 Jan 2010 13:45:34 +0200
Message-ID: <1263123934.30988.8.camel@localhost.localdomain>
References: <cover.1259674171.git.ext-mika.1.westerberg@nokia.com>
	 <20091203061912.GA5626@gw.healthdatacare.com>
	 <20091203062641.GH9121@core.coreip.homeip.net>
	 <20091215070507.GD25613@gw.healthdatacare.com>
	 <20091216082528.GI2699@core.coreip.homeip.net>
Reply-To: dedekind1@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f225.google.com ([209.85.220.225]:54743 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0AJLpi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 10 Jan 2010 06:45:38 -0500
Received: by fxm25 with SMTP id 25so19674fxm.21
        for <linux-input@vger.kernel.org>; Sun, 10 Jan 2010 03:45:36 -0800 (PST)
In-Reply-To: <20091216082528.GI2699@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>, linux-input@vger.kernel.org

On Wed, 2009-12-16 at 00:25 -0800, Dmitry Torokhov wrote:
> On Tue, Dec 15, 2009 at 09:05:07AM +0200, Mika Westerberg wrote:
> > On Wed, Dec 02, 2009 at 10:26:41PM -0800, Dmitry Torokhov wrote:
> > > On Thu, Dec 03, 2009 at 08:19:12AM +0200, Mika Westerberg wrote:
> > > > On Tue, Dec 01, 2009 at 03:53:45PM +0200, Mika Westerberg wrote=
:
> > > > >
> > > > > This is third version of the series. Purpose of this patch is=
 to allow
> > > > > userland to disable GPIO buttons interrupting the CPU. There =
is now sysfs
> > > > > interface that can be used to control the buttons by key code=
 or by switch
> > > > > code.
> > > > >=20
> > > > > I merged those previous 2 patches as one. This is because it =
made little
> > > > > sense of having separate patch for adding the 'can_disable' f=
ield.
> > > > >=20
> > > > > Changes in v3:
> > > > > 	- merged previous 2 patches into one
> > > > > 	- buttons have 'can_disable' field instead of irqflags field
> > > > >=20
> > > > > Tested with RX-51.
> > > >=20
> > > > Hi Dmitry,
> > > >=20
> > > > Any comments on this? Is it OK to be applied or do I need to ch=
ange
> > > > something.
> > > >=20
> > >=20
> > > Hi Mika,
> > >=20
> > > SOrry, I am still pondering how to go about it. I am sure that th=
e sysfs
> > > interface is proper, so at this point it is just implementation d=
etails
> > > that I am not quite sure yet...
> >=20
> > Hi Dmitry,
> >=20
> > Have you decided yet what to do with these patches?
> >=20
>=20
> Hi Mika,
>=20
> Sorry, not yet, have been busy with some other stuff ;(

Hi Dmitry,

just a humble reminder.

(We missed .33, would be really cool not to miss .34)

--=20
Best Regards,
Artem Bityutskiy (=D0=90=D1=80=D1=82=D1=91=D0=BC =D0=91=D0=B8=D1=82=D1=8E=
=D1=86=D0=BA=D0=B8=D0=B9)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
