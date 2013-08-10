From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 2/2] HID: hid-logitech-dj, querying_devices was never
 set
Date: Sat, 10 Aug 2013 19:21:30 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1308101921080.32627@pobox.suse.cz>
References: <1374153691-25100-1-git-send-email-nlopezcasad@logitech.com> <1374153691-25100-2-git-send-email-nlopezcasad@logitech.com> <CAN+gG=GcS7pfK9K5FuW9TyX+PJWNkXZWLk8UX9PzLXom2PSpgQ@mail.gmail.com> <alpine.LNX.2.00.1308020309340.24017@pobox.suse.cz>
 <CAN+gG=FV=OjnktkET-_KM_iTPStsWCKdj8fpyktnJczusFz0=w@mail.gmail.com> <alpine.LNX.2.00.1308051516181.17512@pobox.suse.cz> <CAN+gG=Hjd1Ay0=HrJdV9797DxTMf97_13kdkuHNWi24EfPL-ig@mail.gmail.com> <520164A5.2020008@molgaard.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:39706 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab3HJRVf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Aug 2013 13:21:35 -0400
In-Reply-To: <520164A5.2020008@molgaard.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Sune_M=F8lgaard?= <sune@molgaard.org>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Andrew de los Reyes <adlr@chromium.org>, joseph.salisbury@canonical.com, linux-input <linux-input@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 6 Aug 2013, Sune M=C3=B8lgaard wrote:

> Being affected by this bug, I can confirm that Linux 3.11-rc4 still
> exhibits the unwanted behaviour for me, but that commenting out the
> single line from the second patch makes it work.
>=20
> Thus, for requesting a revert on that line, you are most welcome to p=
ut
> me down as a "Tested-By".

Will be reverted in 3.11-rc5 (8e5654ce69).

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
