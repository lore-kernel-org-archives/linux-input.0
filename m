From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: new driver for non-compliant Saitek devices
Date: Wed, 22 Feb 2012 11:34:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1202221134040.31150@pobox.suse.cz>
References: <1329873006-29473-1-git-send-email-andreas@k4n.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:36059 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753456Ab2BVKeQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Feb 2012 05:34:16 -0500
In-Reply-To: <1329873006-29473-1-git-send-email-andreas@k4n.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Andreas_H=FCbner?= <andreas@k4n.de>
Cc: linux-input@vger.kernel.org

On Wed, 22 Feb 2012, Andreas H=C3=BCbner wrote:

> The driver currently only supports the PS1000 controller.
> It fixes the report descriptor by removing a non-existing axis and
> clearing the constant bit on the d-pad and button input reports.
>=20
> Signed-off-by: Andreas H=C3=BCbner <andreas@k4n.de>

Applied, thanks Andreas.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
