From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 00/14 v3] cleanup atmel_mxt_ts
Date: Tue, 8 May 2012 22:48:36 -0700
Message-ID: <20120509054836.GE10514@core.coreip.homeip.net>
References: <1334755319-21365-1-git-send-email-djkurtz@chromium.org>
 <CAGS+omDm36Sxpv_e1=W6BNx9EoeWd1H2EaPqHAaGYYWnaZjZAw@mail.gmail.com>
 <20120505121626.GA754@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60280 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751056Ab2EIFsm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 May 2012 01:48:42 -0400
Content-Disposition: inline
In-Reply-To: <20120505121626.GA754@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Daniel Kurtz <djkurtz@chromium.org>, Joonyoung Shim <jy0922.shim@samsung.com>, Nick Dyer <nick.dyer@itdev.co.uk>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>

Hi Henrik,

On Sat, May 05, 2012 at 02:16:26PM +0200, Henrik Rydberg wrote:
>=20
> > > =A0Input: atmel_mxt_ts - verify object size in mxt_write_object
>=20
> OK, also stable material.

No, I don't think we need it in stable as it is not exposed to
unprivileged userspace and we did not have reports of it causing
issues...

Daniel,

I applied patches 1, 2, 4, 5, and 6. The rest seem to need more
discussion.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
