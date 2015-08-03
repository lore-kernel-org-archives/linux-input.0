From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: drivers/joystick: use parallel port device model
Date: Mon, 3 Aug 2015 14:41:27 +0200
Message-ID: <20150803124127.GF20682@pali>
References: <1438265194-20366-1-git-send-email-sudipm.mukherjee@gmail.com>
 <20150730165323.GC13165@dtor-ws>
 <20150731101525.GA7811@sudip-pc>
 <20150731165427.GB5613@dtor-ws>
 <20150731173426.GA23126@sudip-pc>
 <20150731203618.GA24494@kroah.com>
 <20150731204306.GM5613@dtor-ws>
 <20150801124348.GA10147@sudip-pc>
 <20150803122648.GE20682@pali>
 <20150803123626.GA4726@sudip-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f169.google.com ([209.85.212.169]:37752 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbHCMla (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 Aug 2015 08:41:30 -0400
Content-Disposition: inline
In-Reply-To: <20150803123626.GA4726@sudip-pc>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Monday 03 August 2015 18:06:26 Sudip Mukherjee wrote:
> On Mon, Aug 03, 2015 at 02:26:48PM +0200, Pali Roh=C3=A1r wrote:
> > On Saturday 01 August 2015 18:13:48 Sudip Mukherjee wrote:
> > >=20
> > >=20
> <snip>
> >=20
> > Hey! I believe you are not going to break my Atari joystick connect=
ed to
> > my desktop PC via special homemade reduction for parallel port... :=
-)
> > That Atari joystick uses db9.ko linux kernel driver and so any unte=
sted
> > changes to db9.c could break functionality!
> Can you please test the patch I am going to post in an hour or so? Th=
e
> changes which I am making should not break any functionality.
>=20
> regards
> sudip

I can test db9.c patches, but not right now... Desktop PC with joystick
is thousands of miles from me. It will take some time, maybe weeks...

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
