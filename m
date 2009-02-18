From: Oliver Neukum <oliver@neukum.org>
Subject: Re: linux-next: USB mouse won't work after resume.
Date: Wed, 18 Feb 2009 09:47:16 +0100
Message-ID: <200902180947.17338.oliver@neukum.org>
References: <20090216172016.f1d159a7.sfr@canb.auug.org.au> <200902172142.57302.oliver@neukum.org> <499B56D3.3080701@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out002.kontent.com ([81.88.40.216]:52134 "EHLO
	smtp-out002.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246AbZBRIp2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2009 03:45:28 -0500
In-Reply-To: <499B56D3.3080701@free.fr>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: linux-input@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

Am Wednesday 18 February 2009 01:31:15 schrieb Laurent Riffard:
> > Please try the attached patch.
> >=20
> > =A0=A0=A0=A0=A0=A0Regards
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0Oliver
> >=20
>=20
> This patch does fix the behaviour, my USB mouse now works after suspe=
nd/resume. Thanks.

Very good. I've submitted the patch.

	Thanks
		Oliver

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
