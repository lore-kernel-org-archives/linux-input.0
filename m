From: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Subject: Re: [PATCH 2/2 v3] elantech: Report multitouch with proper ABS_MT
 messages
Date: Tue, 11 May 2010 00:27:57 +0200
Message-ID: <4BE8886D.4040302@tudelft.nl>
References: <4BE593AA.6040408@tudelft.nl> <4BE86886.2080909@tudelft.nl> <4BE8725D.1060703@euromail.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:40088 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0EJW2A (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 18:28:00 -0400
In-Reply-To: <4BE8725D.1060703@euromail.se>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Op 10-05-10 22:53, Henrik Rydberg schreef:
> Hi again =C3=89ric,
>=20
> thanks for your changes, the first patch looks better now. However, b=
oth patches
> still have style problems. Also, the second patch now makes unrelated=
 changes to
> the ABS_X etc, so it is difficult to even know what was tested, and w=
hether the
> first patch really works as claimed.
What are the style problems of the first patch? I tried to fix all of t=
hem.

Concerning the second patch, it's necessary to change the lines with
ABS_X, because otherwise the computation would be duplicated for the MT
part and it would make everything look more complicated. Honestly, I
think this change is still very limited and can easily be reviewed for
not changing the semantic. Well, I think it would be a bit overkill, bu=
t
if really considered necessary, I can do a third intermediary patch...
Dmitry let me know if you can merge the patch as is.

Eric

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
