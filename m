From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: [PATCH 0/3] Switch input leds over to standard LED class devices
Date: Tue, 9 Jun 2015 15:42:41 +0200
Message-ID: <20150609134241.GB3045@type>
References: <1433799790-31873-4-git-send-email-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from domu-toccata.ens-lyon.fr ([140.77.166.138]:50148 "EHLO
	sonata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751158AbbFINnH (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Jun 2015 09:43:07 -0400
Content-Disposition: inline
In-Reply-To: <1433799790-31873-4-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-3-git-send-email-dmitry.torokhov@gmail.com>
 <1433799790-31873-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rpurdie@rpsys.net, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Dmitry Torokhov, le Mon 08 Jun 2015 14:43:07 -0700, a =E9crit :
> If user wants all keyboards to light up CapsLock LED when VT state lo=
cks
> CtrlL modifier they need to write a udev rule or similar to set up
> "kbd-ctrlllock" trigger for all appearing "input%::capslock" LED clas=
s
> devices.

I guess console-setup's maintainer will not be happy about it.  I'd
say it'd be good to at least give examples how to do it in the
documentation.

That being said, patches 2 & 3 looked fine to me.

I have only my internal laptop keyboard right now so I haven't
completely tested this yet.

Thanks for your time on this,
Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
