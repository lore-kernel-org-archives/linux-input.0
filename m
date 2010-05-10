From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2 v3] elantech: Report multitouch with proper ABS_MT
 messages
Date: Tue, 11 May 2010 01:58:43 +0200
Message-ID: <4BE89DB3.1050206@euromail.se>
References: <4BE593AA.6040408@tudelft.nl> <4BE86886.2080909@tudelft.nl> <4BE8725D.1060703@euromail.se> <4BE8886D.4040302@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:38306 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932117Ab0EJX7H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 19:59:07 -0400
In-Reply-To: <4BE8886D.4040302@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

=C3=89ric Piel wrote:
> Op 10-05-10 22:53, Henrik Rydberg schreef:
>> Hi again =C3=89ric,
>>
>> thanks for your changes, the first patch looks better now. However, =
both patches
>> still have style problems. Also, the second patch now makes unrelate=
d changes to
>> the ABS_X etc, so it is difficult to even know what was tested, and =
whether the
>> first patch really works as claimed.
> What are the style problems of the first patch? I tried to fix all of=
 them.

WARNING: line over 80 characters
#212: FILE: drivers/input/mouse/elantech.c:483:
+		input_set_abs_params(dev, ABS_TOOL_WIDTH, ETP_WMIN_V2, ETP_WMAX_V2, =
0, 0);

WARNING: line over 80 characters
#119: FILE: drivers/input/mouse/elantech.c:498:
+		input_set_abs_params(dev, ABS_MT_POSITION_X, ETP_XMIN_V2, ETP_XMAX_V=
2, 0, 0);

WARNING: line over 80 characters
#120: FILE: drivers/input/mouse/elantech.c:499:
+		input_set_abs_params(dev, ABS_MT_POSITION_Y, ETP_YMIN_V2, ETP_YMAX_V=
2, 0, 0);

>=20
> Concerning the second patch, it's necessary to change the lines with
> ABS_X, because otherwise the computation would be duplicated for the =
MT
> part and it would make everything look more complicated. Honestly, I
> think this change is still very limited and can easily be reviewed fo=
r
> not changing the semantic.

Yes, you are right about x1 and y1. The patch patch touches the width v=
ariable
for no apparent reason, and I stopped reading there.

If this process seems trivial and tedious to you, consider how it must =
appear to
those who deal with patches every day. Most people will not even look a=
t a patch
with style problems, so the real review _starts_ when those issues are =
fixed.

Henrik
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
