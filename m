From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH RESEND] HID: Stop hiding options with !EXPERT
Date: Mon, 16 Mar 2015 17:22:26 +0100
Message-ID: <1426522946.4248.131.camel@chaos.site>
References: <20150220173333.5a71d6cb@endymion.delvare>
	 <alpine.LNX.2.00.1503161600510.25438@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:52544 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933077AbbCPQWa (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Mar 2015 12:22:30 -0400
In-Reply-To: <alpine.LNX.2.00.1503161600510.25438@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

Le Monday 16 March 2015 =C3=A0 16:03 +0100, Jiri Kosina a =C3=A9crit :
> On Fri, 20 Feb 2015, Jean Delvare wrote:
>=20
> > Many HID driver options are hidden unless EXPERT is set. While I
> > understand the idea of simplifying the kernel configuration for mos=
t
> > users, in practice I believe it adds more confusion than it helps.
>=20
> OK, I think we've reached a point where this might actually be OK -- =
users=20
> which depended on those few drivers should now have explicit select i=
n=20
> their .config anyway.
>=20
> So I am applying this to for-4.1/kconfig-drop-expert-dependency, let'=
s see=20
> whether we receive any complaints.

This is great news, thank you very much :-)

--=20
Jean Delvare
SUSE L3 Support

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
