From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/5] input: wacom: Add support for the Bamboo Touch
 trackpad (rev3)
Date: Fri, 3 Sep 2010 09:26:08 -0700
Message-ID: <20100903162608.GA2200@core.coreip.homeip.net>
References: <1283516247-11624-1-git-send-email-rydberg@euromail.se>
 <1283516247-11624-4-git-send-email-rydberg@euromail.se>
 <6753EB6004AFF34FAA275742C104F952022BB10E@wacom-nt10.wacom.com>
 <4C80F2CD.2040708@euromail.se>
 <AANLkTinUxPMezfSHjfPPJ6PoZ1Put26ZAMrzQ36K2fjV@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:60106 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752655Ab0ICQ0T (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 3 Sep 2010 12:26:19 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTinUxPMezfSHjfPPJ6PoZ1Put26ZAMrzQ36K2fjV@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Ping Cheng <pingc@wacom.com>, Chris Bagwell <chris@cnpbagwell.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, Sep 03, 2010 at 05:30:27PM +0200, Ping Cheng wrote:
> On Fri, Sep 3, 2010 at 3:06 PM, Henrik Rydberg <rydberg@euromail.se> =
wrote:
> > On 09/03/2010 03:01 PM, Ping Cheng wrote:
> > [...]
> >
> >> + =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D =
0);
> >> + =A0 =A0 input_report_key(input, BTN_MIDDLE, (data[1] & 0x04) !=3D=
 0);
> >> + =A0 =A0 input_report_key(input, BTN_4, (data[1] & 0x02) !=3D 0);
> >> + =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=3D=
 0);
> >>
> >> Since you are assigning meaningful defaults to three of the tablet
> >> buttons instead of using BTN_#, can we move one more step to make =
the
> >> fourth button useful out-of-box too? I am thinking of something li=
ke
> >> BTN_FORWARD and BTN_BACK while getting rid of the BTN_MIDDLE. So, =
it
> >> would be:
> >>
> >> =A0 =A0 =A0 input_report_key(input, BTN_LEFT, (data[1] & 0x08) !=3D=
 0);
> >> =A0 =A0 =A0 input_report_key(input, BTN_FORWARD, (data[1] & 0x04) =
!=3D 0);
> >> =A0 =A0 =A0 input_report_key(input, BTN_BACK, (data[1] & 0x02) !=3D=
 0);
> >> =A0 =A0 =A0 input_report_key(input, BTN_RIGHT, (data[1] & 0x01) !=3D=
 0);
> >>
> >> Does this make sense to you?
> >
> >
> > Well, this is all a matter of taste, isn't it. If middle-button emu=
lation works
> > out of the box, for the benefit of us old X users who seem unwillin=
g to ever let
> > go of the click-to-paste functionality, then I would not mind terri=
bly.
>=20
> I agree and I use middle click more than right click myself ;). I jus=
t
> wanted to give BTN_4 a life. If no one has a good suggestion for that=
,
> I can live with it.
>=20

Another option could be allowing usirs to remap buttons via EVIOGSKEYCO=
DE.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
