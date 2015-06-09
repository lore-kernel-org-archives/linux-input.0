From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 14:20:34 +0200
Message-ID: <20150609122034.GB7999@type.lan>
References: <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
 <20150609105421.GA15814@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]:49015 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbFIM1i (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 08:27:38 -0400
Content-Disposition: inline
In-Reply-To: <20150609105421.GA15814@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Pavel Machek, le Tue 09 Jun 2015 12:54:21 +0200, a =E9crit :
> 1) input4::caps-lock -- default trigger was not set, so caps lock did
> not control the LED. That's bug, right?
>=20
> I did echo kbd-capslock > trigger, but still no luck. (That might be
> bug in Debian, IIRC?)

In console-setup, yers.

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
