From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] Input: Document no-sleep requirement for playback()
 callback
Date: Tue, 27 Nov 2012 06:47:41 +0000
Message-ID: <20121127064741.GW9411@opensource.wolfsonmicro.com>
References: <1353997935-7210-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20121127064238.GA1989@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rUGnr7B6Y4qPBmNO"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:58145 "EHLO
	opensource.wolfsonmicro.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755574Ab2K0Gro (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Nov 2012 01:47:44 -0500
Content-Disposition: inline
In-Reply-To: <20121127064238.GA1989@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org


--rUGnr7B6Y4qPBmNO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 26, 2012 at 10:42:38PM -0800, Dmitry Torokhov wrote:

> We already have a few lines below:

> > * Note that playback(), set_gain() and set_autocenter() are called with
> > * dev->event_lock spinlock held and interrupts off and thus may not
> > * sleep.

> So I doubt they will pay more attention to your addition ;)

Ah, it's quite a few lines below - it was actually off the bottom of my
screen which rather buried the lead (though TBH I think I was most
surprised by the fact that the lock isn't actually in the struct).

--rUGnr7B6Y4qPBmNO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQtGHZAAoJELSic+t+oim9G3gQAIvu0tJkCo8w0K87PsqHIpS+
ImE1QVPB5ppPzYtuIn5VzXDYJRY88fRSYtlbMDuEu92OZ6T+VyKuDgMU3gYBwl+I
xRY/r89w+VvFd1KFDBvhKgpD8yriGn2ePMKeNrQVipZovXYR4PMC4jHlHwJJwbdL
YPCy4xWcQef0n9PFuxI7G3cMTUsOX7j3yUktSgxmr/5QZ3m9FuyUHsM5PTCrPRGP
HWxFf4RwIduNx477RsmF6RIetS/4KQ46MZb8vXgCi2DvqbiMCRH4QqryoTHgRCaF
Q5kfzmumm5tV2znQyabaCF9tRTfF4fl+H7dQJqW4qjjQnMLrgUr+Twx1KnkDPe1d
Ft5jI1Id7CjpS6FoFSm6RDXX+yzgUq1ZNoQ7VD7ROzwEEuNddaqD+ICw5rGmB/9D
7aaxJDRZ/JW8ZSxh4LlWu0j8xTLkGPDqBcVOsBpc0x7vlC0js+3NfN1tRKRYBQ04
lYzmrP556huLN40ycTRxEk8LneNxlPMPWz7JsAoK8MET2Plnvk/+WYXc/3/+vuGp
/AnlkQqdl5y2iX1ihziWwOWzSBcmruWae4yERNrhB3LDulWnvAsc2mcEeoL3rkYk
TE+S1WRl7RC5otYbPXsXgXLYAi/+KGzwpHqJDZ+gWGeRBMRYNX1fBM5GwYHxuv4j
S2tph9KembDvX4HwRILV
=lQVQ
-----END PGP SIGNATURE-----

--rUGnr7B6Y4qPBmNO--
