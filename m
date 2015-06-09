From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 1/3] Input: export LEDs as class devices in sysfs
Date: Tue, 9 Jun 2015 15:27:34 +0200
Message-ID: <20150609132734.GA3132@type>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-2-git-send-email-dmitry.torokhov@gmail.com>
 <20150609131955.GA3045@type>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sonata.ens-lyon.org ([140.77.166.138]:49968 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750946AbbFIN2F (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 09:28:05 -0400
Content-Disposition: inline
In-Reply-To: <20150609131955.GA3045@type>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Samuel Thibault, le Tue 09 Jun 2015 15:19:55 +0200, a =E9crit :
> > +	[LED_NUML]	=3D { "num-lock", VT_TRIGGER("kbd-numlock") },
> > +	[LED_CAPSL]	=3D { "caps-lock", VT_TRIGGER("kbd-capslock") },
> > +	[LED_SCROLLL]	=3D { "scroll-lock", VT_TRIGGER("kbd-scrollock") },
>=20
> I'd tend to think we'd want to harmonize the user-visible LED names a=
nd
> kbd trigger names,

And perhaps fix that odd-looking "scrollock"?

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
