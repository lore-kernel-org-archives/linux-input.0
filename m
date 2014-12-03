From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Side effect of pressing special keys
Date: Wed, 3 Dec 2014 11:12:54 -0200
Message-ID: <20141203131254.GB20212@khazad-dum.debian.net>
References: <201411231441.17592@pali>
 <20141203124042.GA504@amd>
 <201412031346.13297@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45427 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751061AbaLCNNL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 3 Dec 2014 08:13:11 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 3389820D38
	for <linux-input@vger.kernel.org>; Wed,  3 Dec 2014 08:13:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <201412031346.13297@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-input@vger.kernel.org, platform-driver-x86@vger.kernel.org, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org

On Wed, 03 Dec 2014, Pali Roh=E1r wrote:
> Ok, and what about KEY_KBDILLUMTOGGLE when bios also handle=20
> keyboard backlight level? Should be this key filtered too?

IME, heck yes.

If you ever make the mistake of sending to userspace something the
BIOS/kernel already reacted to, they will find a way to loop it back to=
 you
and cause all sort of issues.

--=20
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
