Return-Path: <SRS0=MdzI=CT=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC735C43461
	for <linux-input@archiver.kernel.org>; Thu, 10 Sep 2020 06:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E55207EA
	for <linux-input@archiver.kernel.org>; Thu, 10 Sep 2020 06:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599718865;
	bh=JWNUxWZbGJJ1fihwnRRpBTK9XQnFPsAPD0+ab1fseg0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=EjO1y45hdu6h0UiTvLQw7iO+Wn1HBkb6tKlJzFfi92bhmVpzdc4iC2l/ssavxI5Os
	 0YZI+ihlI/gL1L92UsQUQzYHkj/8Kz29lLbsb8bzMWoG+E7th+YQBs5EQDi32maI9I
	 aTx9Ibxehq4oUyfksl7R7qEZrkJ00jFhetmLwePE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgIJGVD (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 10 Sep 2020 02:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:48470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725971AbgIJGVD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Sep 2020 02:21:03 -0400
Received: from localhost (p5486ceec.dip0.t-ipconnect.de [84.134.206.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BED97207DE;
        Thu, 10 Sep 2020 06:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599718862;
        bh=JWNUxWZbGJJ1fihwnRRpBTK9XQnFPsAPD0+ab1fseg0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbiWPiLGCvPfrqWWZo5JFgb0/Uw26pu9zVq68ZQqhDRwSWZe7agcZkOIx1SnYzMrh
         hnkhvpGayepHpld0KmFCoOuDnFXWPZ3SrV6glb+8+a81MN0AIqWOSVgFBX+/2a7T7+
         cFq8vyvDSlE68w43+QHICEgzMmKiGQGYDpZIWA38=
Date:   Thu, 10 Sep 2020 08:20:58 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-aspeed@lists.ozlabs.org, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        dmitry.torokhov@gmail.com, joel@jms.id.au, andrew@aj.id.au,
        benh@kernel.crashing.org, brendanhiggins@google.com,
        rentao.bupt@gmail.com, ryan_chen@aspeedtech.com
Subject: Re: [PATCH v3 3/5] i2c: aspeed: Mask IRQ status to relevant bits
Message-ID: <20200910062058.GC1031@ninjato>
References: <20200909203059.23427-1-eajames@linux.ibm.com>
 <20200909203059.23427-4-eajames@linux.ibm.com>
 <20200910061813.GB1031@ninjato>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="adJ1OR3c6QgCpb/j"
Content-Disposition: inline
In-Reply-To: <20200910061813.GB1031@ninjato>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org


--adJ1OR3c6QgCpb/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 10, 2020 at 08:18:13AM +0200, Wolfram Sang wrote:
> On Wed, Sep 09, 2020 at 03:30:57PM -0500, Eddie James wrote:
> > Mask the IRQ status to only the bits that the driver checks. This
> > prevents excessive driver warnings when operating in slave mode
> > when additional bits are set that the driver doesn't handle.
> >=20
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > Reviewed-by: Tao Ren <rentao.bupt@gmail.com>
>=20
> I reconsidered and applied it now because this helps whenever slave mode
> is used. So, applied to for-current, thanks!

If someone could provide a Fixes tag, that would be welcome. For me, not
knowing the HW it doesn't look trivial to determine.


--adJ1OR3c6QgCpb/j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAl9ZxckACgkQFA3kzBSg
KbZ3iA//cQfh41pbKdqYAo099C5IRm15SZnDi0WxKZpIYlYR22XokN01zfTYj/vX
AIy+9J85UNFbLBhrASWn/Zuu7/4VkAKQgBPZChEH6EJ4wRe9RGHg6+Em21n0gqR9
pyWNMkX4S/iSeLdhsi0HZ23Lg9KyN8tFUiw1Wj4DCcQGEDe8W1oOBkW1X1r2YLTk
p99q/blvdOcfPUqfSFRxBYCKFYwipTllZMAklQ52sHDKpabgIxdNtUsffSrZaabr
4UNtkX4cf+S5KZb87uXXb3zeVFRpr/tls4CQDAMyJHiqvrMT9gLGmpmKAX93RDy9
dln32Q1uJbhiTjQc/tTuxQiiCiexc0vpk0uf1yliEbToVzb7rLCXz/ms9sY+oPZM
tOzbG8/ERYdkUAbdkMIrgASNgDgrQvISH8pyLIIGfrGsiz2FcFBHUCBCONeyZgR8
kndwyqr0plUr0RsCibBkkyRRKT/D9SkJAAMDBaAg68j2Uj+PEr+ccagf/AH+Fdbb
gTLE64Mx1awSmGF6RpOHEgvEG+o62GDbZk/TmKD7GIWjeXqpZwoG1OySHc/gmFrJ
lB4SN2kjxbHhcOB+D0YatsuVmrwEbQFTMMTH01gWjwLRpjNQ9TOxrMgmOhtiMyh/
C7jkwvhOCiwtvd5zmD2JTn7r/0GhZXU6dg3DLlZQzMsh9NhV45s=
=24Fn
-----END PGP SIGNATURE-----

--adJ1OR3c6QgCpb/j--
