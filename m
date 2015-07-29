From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH acer-switch12-keyboard] hid core: Enable support for Fn+
 controls keys on Acer Aspire Switch 12 keyboard
Date: Wed, 29 Jul 2015 14:16:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507291416360.925@pobox.suse.cz>
References: <1437474712.5279.1.camel@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49452 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752948AbbG2MQ6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2015 08:16:58 -0400
In-Reply-To: <1437474712.5279.1.camel@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?KOI8-R?B?7snLz8zByiDr1cTS0dfDxdc=?= <nkudriavtsev@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, 21 Jul 2015, =D0=9D=D0=B8=D0=BA=D0=BE=D0=BB=D0=B0=D0=B9 =D0=9A=D1=
=83=D0=B4=D1=80=D1=8F=D0=B2=D1=86=D0=B5=D0=B2 wrote:

> Acer Aspire Switch 12 keyboard Chicony's controller reports too big u=
sage
> index on the 1st interface. The patch fixes the report. The work base=
d on
> solution from drivers/hid/hid-holtek-mouse.c
>=20
> Bug report: https://bugzilla.kernel.org/show_bug.cgi?id=3D101721
>=20
> Signed-off-by: Nicholas Kudriavtsev <nkudriavtsev@gmail.com>
> ---
> Tested on git://git.kernel.org/pub/scm/linux/kernel/git/jikos/hid.git=
 and it
> works

Applied to for-4.3/chicony (with updates subject so that it makes the=20
usual format used for HID patches).

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
