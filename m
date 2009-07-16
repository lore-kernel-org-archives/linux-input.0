From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ads7846: allocate separate cache lines for tx and rx
	data
Date: Thu, 16 Jul 2009 21:06:28 +0100
Message-ID: <20090716200628.GA22111@n2100.arm.linux.org.uk>
References: <200907151106.47917.david-b@pacbell.net> <20090716071529.GA28840@n2100.arm.linux.org.uk> <200907160028.05114.david-b@pacbell.net> <200907161200.01020.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33341 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932816AbZGPUGw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Jul 2009 16:06:52 -0400
Content-Disposition: inline
In-Reply-To: <200907161200.01020.marek.vasut@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marek Vasut <marek.vasut@gmail.com>
Cc: David Brownell <david-b@pacbell.net>, Alessandro Rubini <rubini-list@gnudd.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.arm.linux.org.uk

On Thu, Jul 16, 2009 at 12:00:00PM +0200, Marek Vasut wrote:
> Dne =C4=8Ct 16. =C4=8Dervence 2009 09:28:04 David Brownell napsal(a):
> > On Thursday 16 July 2009, Russell King - ARM Linux wrote:
> > > Clearly David has no knowledge of DMA cache line handing and has =
not
> > > read the DMA API document.  I really suggest that you ignore him =
until
> > > he gets a fucking clue.
> >
> > Clearly common courtesy is too much for Russell.  I suggest you
> > ignore him until he learns to restrain his baser impulses ...
> > his personal attacks have no place in technical discussions.
>=20
> It's very interesting. I experienced no problems when it came to
> communicating with him (which I cant say about you though).

David and myself have a history of communication problems, to the
extent that I try to avoid reading his witterings.

However, the observant will notice that David has cut out the part
I quoted which elicited my response which I found offensive.

It would also be nice that if David knows the answer to something,
he doesn't spout unhelpful claptrap like "Who could have pointed out
instantly where the true bug resides" and instead be useful and
state the answer.

But, I guess such things are too much for some people.
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
