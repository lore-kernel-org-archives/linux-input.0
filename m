From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 0/4] HID: hid-lg4ff: Improve handling of Logitech
 multimode wheels
Date: Wed, 18 Feb 2015 21:15:49 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502182115040.28769@pobox.suse.cz>
References: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34357 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751456AbbBRUPv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 15:15:51 -0500
In-Reply-To: <1424278763-29072-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org, elias.vds@gmail.com

On Wed, 18 Feb 2015, Michal Mal=C3=BD wrote:

> This patch series improves handling of various Logitech gaming wheels=
 and
> allows switching between various compatibility modes which might be u=
seful
> to improve compatibility with very old games and testing purposes.
>=20
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>
>=20
> v3: - Marked all internal functions static
>     - Moved function and external variable declarations to hid-lg4ff.=
h
>=20
> v2: - Rebased against latest linux-next
>     - Document the newly introduced sysfs interfaces in appropriate c=
ommits
>     - Assume that we are targeting kernel version 4.1
>     - Fix a misleading error message regarding unsupported wheel mode

I have applied the series. Thanks,

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
