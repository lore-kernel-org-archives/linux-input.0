From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Re: [RFC3] Teach drivers/media/IR/ir-raw-event.c to use durations
Date: Sat, 10 Apr 2010 08:48:01 +0200
Message-ID: <20100410064801.GA2667@hardeman.nu>
References: <20100408113910.GA17104@hardeman.nu>
 <1270812351.3764.66.camel@palomino.walls.org>
 <s2o9e4733911004090531we8ff39b4r570e32fdafa04204@mail.gmail.com>
 <4BBF3309.6020909@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:43241 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982Ab0DJGsH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Apr 2010 02:48:07 -0400
Content-Disposition: inline
In-Reply-To: <4BBF3309.6020909@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@infradead.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Andy Walls <awalls@md.metrocast.net>, linux-input@vger.kernel.org, linux-media@vger.kernel.org

On Fri, Apr 09, 2010 at 11:00:41AM -0300, Mauro Carvalho Chehab wrote:
> struct {
> 	unsigned mark : 1;
> 	unsigned duration :31;
> }
>=20
> There's no memory spend at all: it will use just one unsigned int and=
 it is
> clearly indicated what's mark and what's duration.

If all three of you agree on this approch, I'll write a patch to conver=
t=20
ir-core to use it instead.

--=20
David H=E4rdeman
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
