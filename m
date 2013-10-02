From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: Added Holtek USB ID 04d9:a081 SHARKOON DarkGlider
 Gaming mouse
Date: Wed, 2 Oct 2013 17:04:33 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1310021704260.29701@pobox.suse.cz>
References: <1380648125-5735-1-git-send-email-ablacksheep@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50832 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753050Ab3JBPEh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 2 Oct 2013 11:04:37 -0400
In-Reply-To: <1380648125-5735-1-git-send-email-ablacksheep@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?ISO-8859-15?Q?Anders_F=2E_U=2E_Ki=E6r?= <ablacksheep@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 1 Oct 2013, Anders F. U. Ki=C3=A6r wrote:

> Target: 3.11.2
> Added id, bindings and comments for Holtek USB ID 04d9:a081 SHARKOON
> DarkGlider Gaming mouse to use the same corrections of the report
> descriptor as Holtek 04d9:a04a. As the mouse exceed HID_MAX_USAGES
> at the same offsets in the reported descriptor.
> Tested on the hardware.
>=20
> Signed-off-by: Anders F. U. Ki=C3=A6r <ablacksheep@gmail.com>

Applied, thanks.

--=20
Jiri Kosina
SUSE Labs
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
