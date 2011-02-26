From: Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH] input: evdev: Add a read() callback
Date: Fri, 25 Feb 2011 20:46:24 -0600
Message-ID: <AANLkTikWA3Vsa2O4_yi1L78_xX18_7WqVKqhTaD1-6Wm@mail.gmail.com>
References: <1298297930-3937-1-git-send-email-bgat@billgatliff.com>
	<20110222002315.GA18299@sirena.org.uk>
	<AANLkTik8d1KZd_qSr2tKrBHq2X-9agA1BG7guK1SqzAd@mail.gmail.com>
	<20110222043302.GD18299@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43269 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827Ab1BZCqY convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Feb 2011 21:46:24 -0500
In-Reply-To: <20110222043302.GD18299@sirena.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-input@vger.kernel.org, linux-embedded@vger.kernel.org

Mark:

On Mon, Feb 21, 2011 at 10:33 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
>
> But surely the most obvious solution here is to standardise a rate
> control interface?

Yes, and no.  A standardized rate control interface would deal with
the rate control problem, but leave the synchronization problem
unsolved.

> The problem you're trying to solve is also an issue for really common
> and standard things like touchscreens and polled switches/keys (the
> latter of which you mentioned in your mail) which are used by standar=
d
> applications.

The existing "polled switch" implementation sets up a throttled
polling loop in kernel code.  The "polled switch" that I was thinking
of when I wrote the essay for the commit was "a switch that is polled
each time read() gets called".  I should have been clearer--- and
probably picked a different name.  :)

> Have you looked at the IIO subsystem for things like this? =A0There h=
as
> been talk of putting accelerometers in there and it certainly fits in
> with the sync requirements you're mentioning.

Now that I have found the code, I'm looking at it.  Can't say yet
whether it's the solution I'm seeking, or not.

> The problem with your proposal as it stands is that if they do use th=
e
> new interface they interact badly with existing applications. =A0This
> isn't really a decision the driver should be taking, it needs to be
> userspace policy if it's going to be a decision at all.

Yea, I'm agreeing with you more than I was at the beginning of this thr=
ead.


b.g.
--=20
Bill Gatliff
bgat@billgatliff.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
