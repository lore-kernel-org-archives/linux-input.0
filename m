From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc2] input:  dm355evm_keys driver
Date: Wed, 24 Jun 2009 10:18:55 -0700
Message-ID: <200906241018.55308.david-b@pacbell.net>
References: <200901171315.08019.david-b@pacbell.net> <200906222240.01093.david-b@pacbell.net> <20090623060604.GB14724@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp104.sbc.mail.gq1.yahoo.com ([67.195.15.63]:35288 "HELO
	smtp104.sbc.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752602AbZFXRZd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2009 13:25:33 -0400
In-Reply-To: <20090623060604.GB14724@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Monday 22 June 2009, Dmitry Torokhov wrote:
>=20
> > > As you have noticed the driver is in mainline already;
> >=20
> > Actually I didn't notice until just now. =A0It was moved
> > from input/keyboard to input/misc. =A0And I wasn't cc'd
> > on this at any point ... so it's no wonder I had no idea
> > what was happening!
> >=20
>=20
> Ah, sorry, it was me - all RC drivers live in input/misc,
> that's why I moved it there.

It's not purely an RC driver, but I can understand
wanting to overlook the other five buttons.  ;)

- Dave

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
