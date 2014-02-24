From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: [PATCH v2 1/4] Add ff-memless-next driver
Date: Mon, 24 Feb 2014 04:11:04 +0200
Message-ID: <530AAA38.3090700@iki.fi>
References: <1516865.M993BQAYe4@geidi-prime> <3364546.xScl1m6sdc@geidi-prime> <530A931D.9030308@iki.fi> <1651798.4YaLXnucpJ@geidi-prime>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sinikuusama.dnainternet.net ([83.102.40.134]:48438 "EHLO
	sinikuusama.dnainternet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752264AbaBXCLO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 Feb 2014 21:11:14 -0500
In-Reply-To: <1651798.4YaLXnucpJ@geidi-prime>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-1?Q?Michal_Mal=FD?= <madcatxster@prifuk.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, elias.vds@gmail.com, jkosina@suse.cz, simon@mungewell.org

24.02.2014 03:54, Michal Mal=FD kirjoitti:
> I forgot to comment on this:
>> Stopped effects should still be able to be updated.
> Fair enough. I could not find a definitive answer to what is expected=
 behavior=20
> in this case. As far as I can tell, there are following cases:
> - Effects with no duration and delay: they shall be updated right awa=
y.
> - Effects with delay: updated parameters shall be sent to the device =
at the=20
> correct time.
> - "Expired" effects with finite duration - ??? I assumed that effects=
 with=20
> finite duration that have already finished playing cannot be updated =
because=20
> it does not seem to make much sense to do so.

"Expired" effects can always be played back again later - if that
happens, the updated parameters will be in effect.

> Shall such an effect be=20
> restarted when it is updated?

No.

> Is there any guideline I should stick to I am=20
> not aware of?

Only "3.7 Dynamic update of an effect" of input/ff.txt.

--=20
Anssi Hannula
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
