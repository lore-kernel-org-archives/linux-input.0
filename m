From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 2.6.29-rc2] input:  dm355evm_keys driver
Date: Mon, 22 Jun 2009 23:06:05 -0700
Message-ID: <20090623060604.GB14724@dtor-d630.eng.vmware.com>
References: <200901171315.08019.david-b@pacbell.net> <200906211710.50537.david-b@pacbell.net> <20090623050519.GA14724@dtor-d630.eng.vmware.com> <200906222240.01093.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.174]:7029 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754940AbZFWGGG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 02:06:06 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1633787wfd.4
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2009 23:06:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200906222240.01093.david-b@pacbell.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-input@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Mon, Jun 22, 2009 at 10:40:00PM -0700, David Brownell wrote:
> On Monday 22 June 2009, Dmitry Torokhov wrote:
> >=20
> > > Appended is a minor tweak to this code. =A0I'm going to resend
> > > the patch again. =A0Maybe one day, soon, I can take it out of
> > > my list of patches-due-to-hit-mainline ...
> >=20
> > As you have noticed the driver is in mainline already;
>=20
> Actually I didn't notice until just now.  It was moved
> from input/keyboard to input/misc.  And I wasn't cc'd
> on this at any point ... so it's no wonder I had no idea
> what was happening!
>=20

Ah, sorry, it was me - all RC drivers live in input/misc,
that's why I moved it there.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
