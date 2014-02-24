From: Michal =?ISO-8859-1?Q?Mal=FD?= <madcatxster@prifuk.cz>
Subject: Re: [PATCH v2 1/4] Add ff-memless-next driver
Date: Mon, 24 Feb 2014 03:45:01 +0100
Message-ID: <2308366.HeZmROk36g@geidi-prime>
References: <1516865.M993BQAYe4@geidi-prime> <1651798.4YaLXnucpJ@geidi-prime> <530AAA38.3090700@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.prifuk.cz ([31.31.77.241]:41785 "EHLO prifuk.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751310AbaBXCpF convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 21:45:05 -0500
In-Reply-To: <530AAA38.3090700@iki.fi>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@iki.fi>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, elias.vds@gmail.com, jkosina@suse.cz, simon@mungewell.org

On Monday 24 of February 2014 04:11:04 Anssi Hannula wrote:
> 24.02.2014 03:54, Michal Mal=FD kirjoitti:
> > I forgot to comment on this:
> >> Stopped effects should still be able to be updated.
> >=20
> > Fair enough. I could not find a definitive answer to what is expect=
ed
> > behavior in this case. As far as I can tell, there are following ca=
ses:
> > - Effects with no duration and delay: they shall be updated right a=
way.
> > - Effects with delay: updated parameters shall be sent to the devic=
e at
> > the
> > correct time.
> > - "Expired" effects with finite duration - ??? I assumed that effec=
ts with
> > finite duration that have already finished playing cannot be update=
d
> > because it does not seem to make much sense to do so.
>=20
> "Expired" effects can always be played back again later - if that
> happens, the updated parameters will be in effect.
Okay, let me make this clear. When an effect "expires", update of its=20
parameters shall not trigger a restart, therefore it will not play. How=
ever,=20
when its parameters are updated and the effect is started again at some=
 point,=20
the updated parameters shall be used. I will double-check this just to =
be on=20
the safe side, but MLNX always stores the updated parameters no matter =
what=20
the status of the effect is, so it should behave exactly as you suggest=
=2E=20
Perhaps it was just me misinterpreting the semantics of "update"?

To bring this to a conclusion:
- Do you think that this work is worth mainlining?
- If it is, what do you suggest I change?

Thanks a lot for your input.

Michal M.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
