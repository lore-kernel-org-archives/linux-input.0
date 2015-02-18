From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: hid-lg4ff: Fix "undefined reference" build issue
 with CONFIG_USB disabled.
Date: Wed, 18 Feb 2015 23:50:26 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1502182350130.28769@pobox.suse.cz>
References: <1424296173-22718-1-git-send-email-madcatxster@devoid-pointer.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44148 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752668AbbBRWu2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Feb 2015 17:50:28 -0500
In-Reply-To: <1424296173-22718-1-git-send-email-madcatxster@devoid-pointer.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@devoid-pointer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, simon@mungewell.org

On Wed, 18 Feb 2015, Michal Mal=C3=BD wrote:

> Fix "undefined reference" build issue with CONFIG_USB disabled.
>=20
> Signed-off-by: Michal Mal=C3=BD <madcatxster@devoid-pointer.net>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
