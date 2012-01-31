From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1][INCREMENTAL] Input: cyttsp - Fixes to clean-up patch
Date: Tue, 31 Jan 2012 00:21:52 -0800
Message-ID: <20120131082152.GA4064@core.coreip.homeip.net>
References: <1327816430-19887-1-git-send-email-javier@dowhile0.org>
 <20120129061802.GA25977@core.coreip.homeip.net>
 <CAAwP0s16iO_w9cTLY_ps-X5uBCks4p15XBs2Ea69Gu7Qm7Xe_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:35355 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752397Ab2AaIV7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Jan 2012 03:21:59 -0500
Received: by iacb35 with SMTP id b35so536674iac.19
        for <linux-input@vger.kernel.org>; Tue, 31 Jan 2012 00:21:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAAwP0s16iO_w9cTLY_ps-X5uBCks4p15XBs2Ea69Gu7Qm7Xe_Q@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>, Henrik Rydberg <rydberg@euromail.se>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org

On Sun, Jan 29, 2012 at 04:28:12PM +0100, Javier Martinez Canillas wrot=
e:
> On Sun, Jan 29, 2012 at 7:18 AM, Dmitry Torokhov
> <dmitry.torokhov@gmail.com> wrote:
> > On Sun, Jan 29, 2012 at 06:53:50AM +0100, Javier Martinez Canillas =
wrote:
> >> This is patch fixes two bugs in Dmitry's last cleanup patch.
> >>
> >> 1- The hardware tracking ids are stored in the ids array and the i=
nformation for
> >> =A0 =A0each contact is obtained calling cyttsp_get_tch() with an i=
ndex. In the clean-up
> >> =A0 =A0patch the value of the tracking id was used instead of the =
contact index.
> >>
> >
> > Oops, thank you for fixing that.
> >
> >> 2- i2c_set_clientdata() is called after the generic cyttsp_probe()=
 function and
> >> =A0 =A0this function calls cyttsp_power_on() that sends an ttsp co=
mmand to the device
> >> =A0 =A0and needs the client data before is set. The fix is to exec=
ute cyttsp_power_on
> >> =A0 =A0inside the transport specific probe function (I2C, SPI) aft=
er the generic probe
> >> =A0 =A0function is executed and the client data is set.
> >>
> >
> > Not quite happy about this one, how about we pass cyttsp directly t=
o bus
> > methods instead of relying on drvdata (as in the patch below)?
> >
> > Thanks.
> >
> > --
> > Dmitry
>=20
> Hi Dmitry,
>=20
> Yes, you are right that is a much more clever solution to the issue.
> Thank you for suggesting that.
>=20
> I just sent an v2 of the incremental patch to be applied on top of
> your last clean-up.
>=20
> This fixes the index bug stated before and the dev->i2c_client->cytts=
p
> reference being NULL issue changing the read/write methods signature
> as you suggested.
>=20
> It also fixes an unbalanced IRQ warning since soft_reset() now is
> called inside the probe function and removes the wake_up platform
> function in enable() as with the incremental v1.
>=20
> Thanks a lot for your help and best regards,

=46olded everything up and applied to my 3.4 queue.

Thank you Javier.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
