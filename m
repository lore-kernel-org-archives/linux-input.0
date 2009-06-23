From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.29-rc2] input:  dm355evm_keys driver
Date: Mon, 22 Jun 2009 22:40:00 -0700
Message-ID: <200906222240.01093.david-b@pacbell.net>
References: <200901171315.08019.david-b@pacbell.net> <200906211710.50537.david-b@pacbell.net> <20090623050519.GA14724@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp119.sbc.mail.sp1.yahoo.com ([69.147.64.92]:39601 "HELO
	smtp119.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751352AbZFWFqk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 23 Jun 2009 01:46:40 -0400
In-Reply-To: <20090623050519.GA14724@dtor-d630.eng.vmware.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>

On Monday 22 June 2009, Dmitry Torokhov wrote:
>=20
> > Appended is a minor tweak to this code. =A0I'm going to resend
> > the patch again. =A0Maybe one day, soon, I can take it out of
> > my list of patches-due-to-hit-mainline ...
>=20
> As you have noticed the driver is in mainline already;

Actually I didn't notice until just now.  It was moved
from input/keyboard to input/misc.  And I wasn't cc'd
on this at any point ... so it's no wonder I had no idea
what was happening!

OK, so thanks for merging.  Kevin, this means you can
remove the original code ... and will want to update
the defconfig to use the new symbol.


> please submit=20
> additional changes to the driver as incremental patches.

Will do.

- Dave
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
