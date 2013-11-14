From: Grant Likely <grant.likely@linaro.org>
Subject: Re: [PATCH v2] input: ti_am33x_tsc: make the documentation for the ti,wire-config parameter clear
Date: Thu, 14 Nov 2013 10:56:15 +0900
Message-ID: <20131114015615.4A46BC4061A@trevor.secretlab.ca>
References: <1384273323-15329-1-git-send-email-bigeasy@linutronix.de> <5C68A2CC-A8C8-4B56-A414-B9EBE438F767@codeaurora.org> <20131112174001.GA21881@linutronix.de> <15DA7589-35BD-4B24-B8A1-D44429ACC888@codeaurora.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f48.google.com ([209.85.160.48]:36663 "EHLO
	mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab3KNCOW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Nov 2013 21:14:22 -0500
Received: by mail-pb0-f48.google.com with SMTP id mc17so1311955pbc.35
        for <linux-input@vger.kernel.org>; Wed, 13 Nov 2013 18:14:21 -0800 (PST)
In-Reply-To: <15DA7589-35BD-4B24-B8A1-D44429ACC888@codeaurora.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kumar Gala <galak@codeaurora.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Rob Herring <rob.herring@calxeda.com>, devicetree@vger.kernel.org, o2g.org.ru@gmail.com

On Tue, 12 Nov 2013 12:26:14 -0600, Kumar Gala <galak@codeaurora.org> w=
rote:
>=20
> On Nov 12, 2013, at 11:40 AM, Sebastian Andrzej Siewior <bigeasy@linu=
tronix.de> wrote:
>=20
> > The document says "first four bits" and means the upper nibble. Mos=
t
> > people would probably agree that the first four bits are bits 0=E2=80=
=A63 and
> > that is the lower nibble.
> > This patch updates the documentation so it is clear what is meant.
> >=20
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
> > v1=E2=80=A6v2:
> > 	- use most/least significant instead of upper/ lower nibble
> > 	- add an example.
> >=20
> > .../devicetree/bindings/input/touchscreen/ti-tsc-adc.txt    | 13 ++=
++++++-----
> > 1 file changed, 8 insertions(+), 5 deletions(-)
>=20
> Thanks
>=20
> Acked-by: Kumar Gala <galak@codeaurora.org>

Kumar, for patches like this, do you want to put them into a git tree
instead of acking? It will help spread the load.

g.

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
