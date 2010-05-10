From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH 2/2 v3] elantech: Report multitouch with proper ABS_MT
 messages
Date: Mon, 10 May 2010 22:53:49 +0200
Message-ID: <4BE8725D.1060703@euromail.se>
References: <4BE593AA.6040408@tudelft.nl> <4BE86886.2080909@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp03.sth.basefarm.net ([80.76.149.214]:46934 "EHLO
	ch-smtp03.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751415Ab0EJUx4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 May 2010 16:53:56 -0400
In-Reply-To: <4BE86886.2080909@tudelft.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?w4lyaWMgUGllbA==?= <E.A.B.Piel@tudelft.nl>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Florian Ragwitz <rafl@debian.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi again =C3=89ric,

thanks for your changes, the first patch looks better now. However, bot=
h patches
still have style problems. Also, the second patch now makes unrelated c=
hanges to
the ABS_X etc, so it is difficult to even know what was tested, and whe=
ther the
first patch really works as claimed.

Henrik

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
