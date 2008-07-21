From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: [PATCH] linux-input: bcm5974-0.57: mode-switch to atp_open,
	cleanup bug fixed
Date: Mon, 21 Jul 2008 14:24:17 +0200
Message-ID: <1216643057.28594.6.camel@alnilam>
References: <1216466049.6238.0.camel@alnilam>
	 <20080720051016.GA7853@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp02.sth.basefarm.net ([80.76.149.213]:42875 "EHLO
	ch-smtp02.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750904AbYGUMYw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Jul 2008 08:24:52 -0400
In-Reply-To: <20080720051016.GA7853@anvil.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, robfitz@273k.net, akpm@osdl.org, jikos@jikos.cz, vojtech@suse.cz, dmonakhov@openvz.org, johannes@sipsolutions.net

=EF=BB=BFHello Dmitry,

thank you so much for the review. I will get back tonight with an
updated version.

> What will happen if bcm driver is attached first, before HID had a
> chance to do its part?

It seems it will still work, because the bcm5974 gets reopened after HI=
D
is initialized.

Cheers,
Henrik


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
