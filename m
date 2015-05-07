From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 00/15] HID: hid-lg, hid-lg4ff: Mostly cleanup
 patches
Date: Thu, 7 May 2015 16:29:03 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505071628560.8186@pobox.suse.cz>
References: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50233 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbbEGO3F (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 May 2015 10:29:05 -0400
In-Reply-To: <1428526613-24239-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, elias.vds@gmail.com, simon@mungewell.org

On Wed, 8 Apr 2015, Michal Mal=C3=BD wrote:

> Hello everyone,
>=20
> this is a mostly boring series that deals with a few inconsistencies =
in the
> code that have accumulated over the years. Besides that it patches up=
 a handful
> of problems such a return values not being checked etc.
>=20
> The only significant change comes in patches 8 through 10 which intro=
duce a
> spinlock to handle concurrent access to the HID report that is used b=
y the
> driver to send data to the wheel. I would appreciate some comments on=
 this one,
> particularly on the way it handles deinitialization. Patches 8 and 9 =
contain
> the necessary prep work, patch 10 adds the spinlocking.
>=20
> v2:
>   - Split previous patch 7 into three smaller patches
>   - Split the long line of text in patch 5 (now patch 6)
>   - Add another cleanup patch that removes unnecessary casts from voi=
d *

This is a nice cleanup. I've applied it to for-4.2/logitech.

Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
