From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.29-rc2] input:  dm355evm_keys driver
Date: Mon, 29 Jun 2009 19:32:45 -0700
Message-ID: <20090630023245.GE10652@dtor-d630.eng.vmware.com>
References: <200901171315.08019.david-b@pacbell.net> <200906222240.01093.david-b@pacbell.net> <20090623060604.GB14724@dtor-d630.eng.vmware.com> <200906261204.31927.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.232]:55035 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760151AbZF3Ccq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 29 Jun 2009 22:32:46 -0400
Received: by rv-out-0506.google.com with SMTP id f6so1390556rvb.1
        for <linux-input@vger.kernel.org>; Mon, 29 Jun 2009 19:32:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200906261204.31927.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Samuel Ortiz <sameo@openedhand.com>, linux-input@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Fri, Jun 26, 2009 at 12:04:31PM -0700, David Brownell wrote:
> On Monday 22 June 2009, Dmitry Torokhov wrote:
> >=20
> > > > As you have noticed the driver is in mainline already;
> > >=20
> > > Actually I didn't notice until just now. =A0It was moved
> > > from input/keyboard to input/misc. =A0And I wasn't cc'd
> > > on this at any point ... so it's no wonder I had no idea
> > > what was happening!
> > >=20
> >=20
> > Ah, sorry, it was me - all RC drivers live in input/misc,
> > that's why I moved it there.
>=20
> Moving it did break more than just config files ... see
> the appended fixup patch.  I'll suggest that it go through
> the input tree to keep things together, though if Sam wants
> to take this through MFD he surely has that option.  :)
>=20

Well, I picked it up for 'for-linus' branch, will push in
the next round. Thanks David.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
