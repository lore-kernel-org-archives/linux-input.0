From: Oliver Neukum <oliver@neukum.org>
Subject: Re: [Discuss] What is causing C2? / USB autosuspension?
Date: Wed, 7 May 2008 14:57:15 +0200
Message-ID: <200805071457.16069.oliver@neukum.org>
References: <1015f9200805021702n1558873es72ac798ccdc06966@mail.gmail.com> <200805062212.31947.oliver@neukum.org> <4820DABA.3000700@student.cs.york.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:39036 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803AbYEGM5S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2008 08:57:18 -0400
In-Reply-To: <4820DABA.3000700@student.cs.york.ac.uk>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: alan-jenkins@tuffmail.co.uk, linux-input@vger.kernel.org
Cc: discuss@lesswatts.org

Am Mittwoch 07 Mai 2008 00:24:58 schrieb Alan Jenkins:
> I think I've worked out how to avoid the lost key-presses. =A0Sometim=
es
> they get lost; sometimes they don't. =A0The difference seems to how l=
ong I
> wait after the keyboard suspends. =A0If I wait a few seconds after it=
's
> suspended (as shown by the LEDs), then it resumes flawlessly. =A0It s=
hould
> be possible to reduce the impact of the hardware misfeature by
> increasing the timeout. =A0The longer the keyboard has been idle alre=
ady,
> the lower the probability it'll be used in the next few seconds.=20

This suggests a possible work around. Keyboards known to be buggy in th=
is
way could be reawoken periodically before the critical amount of time i=
s over.
How long is that time? What percentage of time does a keyboard need to =
be
suspended for a positive energy balance?

	Regards
		Oliver
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
