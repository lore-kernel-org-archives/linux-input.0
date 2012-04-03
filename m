From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v4] HID: lg4ff: Remove sysfs iface before deallocating
 memory
Date: Tue, 3 Apr 2012 04:12:31 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204030412100.16928@pobox.suse.cz>
References: <2198552.DMoMTvshKQ@qosmio-x300>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:40813 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694Ab2DCCMd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Apr 2012 22:12:33 -0400
In-Reply-To: <2198552.DMoMTvshKQ@qosmio-x300>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Michal_Mal=FD?= <madcatxster@gmail.com>
Cc: linux-input@vger.kernel.org, simon@mungewell.org

On Sat, 31 Mar 2012, Michal Mal=FD wrote:

> Hi,
>=20
> This patch fixes a possible race condition caused by the sysfs
> interface being removed after the memory used by the interface
> was already kfree'd.
> Please note that this patch depends on "hid-lg: Allow for custom
> device-specific properties to be stored in private drv data" because
> it also fixes a tiny glitch - a leftover #include in the hid-lg.h

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
