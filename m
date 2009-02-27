From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] mfd: twl4030: add twl4030-pwrbutton as our child
Date: Fri, 27 Feb 2009 15:20:56 -0800
Message-ID: <200902271520.56696.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <200902271358.46863.david-b@pacbell.net> <20090227141212.a2bc4a01.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:38263 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752781AbZB0XU7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 27 Feb 2009 18:20:59 -0500
In-Reply-To: <20090227141212.a2bc4a01.akpm@linux-foundation.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: me@felipebalbi.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, felipe.balbi@nokia.com, sameo@openedhand.com

On Friday 27 February 2009, Andrew Morton wrote:
> > >=20
> > > What has gone wrong here?
> >=20
> > Not much I can see. =A0It's registering a platform_device,
> > but only if it could be used on this system.
>=20
> Again, that all gets fixed if this is done the right way around. =A0R=
un
> your probe function. =A0If the hardware is there, register with the c=
ore
> and all the nodes appear. =A0If the hardware is not present: bale.

Right.  If there's no button hooked up to its "power button"
signal, don't register that "twl4030-pwrbutton" node.


> The design of the whole subsystem appears to be upside down :(

You seem to be missing something.  Is it only the lack of that
tweak Felipe sent?

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
