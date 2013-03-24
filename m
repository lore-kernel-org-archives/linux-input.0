From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Subject: Re: Caps lock XOR on multiple keyboards?
Date: Sun, 24 Mar 2013 23:39:24 +0100
Message-ID: <20130324223924.GI6234@type.youpi.perso.aquilenet.fr>
References: <20121203211911.20156.qmail@science.horizon.com>
 <20121203235848.04228689@bob.linux.org.uk>
 <20130324103018.GA4156@amd.pavel.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from toccata.ens-lyon.org ([140.77.166.68]:36053 "EHLO
	toccata.ens-lyon.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754912Ab3CXWpy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 24 Mar 2013 18:45:54 -0400
Content-Disposition: inline
In-Reply-To: <20130324103018.GA4156@amd.pavel.ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Cox <alan@linux.intel.com>, linux-input@vger.kernel.org, jkosina@suse.cz, George Spelvin <linux@horizon.com>, chris@the-brannons.com, gregkh@linuxfoundation.org, jslaby@suse.cz, linux-kernel@vger.kernel.org

Hello,

I can confirm that things go fine on the Linux console.  There is just
one state, which is shown on all keyboards.  This is really a bug in
Xorg, please report the issue there.

Pavel Machek, le Sun 24 Mar 2013 11:30:18 +0100, a =E9crit :
> There is patch to drive keyboard LEDs through LED subsystem, perhaps
> that would be good idea?

My patch won't fix the issue for Xorg, but it'd still be a good thing t=
o
at last apply it :)

Samuel
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
