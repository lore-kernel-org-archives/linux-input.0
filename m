From: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 6/7 v2] HID: picoLCD: drop version check during probe
Date: Mon, 17 Sep 2012 20:21:08 +0200
Message-ID: <20120917202108.3e39dedb@neptune.home>
References: <20120730213656.0a9f6d30@neptune.home>
	<20120730213859.063173c1@neptune.home>
	<alpine.LNX.2.00.1208151015220.7026@pobox.suse.cz>
	<20120819185631.3a984aa4@neptune.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay.restena.lu ([158.64.1.62]:53784 "EHLO
	smtprelay.restena.lu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932343Ab2IQSWE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Sep 2012 14:22:04 -0400
In-Reply-To: <20120819185631.3a984aa4@neptune.home>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org

Jiri,

You seem not to have applied this one yet (it doesn't show up in picolc=
d
branch).

Could you please apply it?
(or did I miss locking changes making it obsolete?)

Thanks,
Bruno

On Sun, 19 August 2012 Bruno Pr=C3=A9mont <bonbons@linux-vserver.org> w=
rote:
> Commit 4ea5454203d991ec85264f64f89ca8855fce69b0
> [HID: Fix race condition between driver core and ll-driver] introduce=
d
> new locking around probe/remove functions that prevents any report/re=
ply
> from hardware to reach driver until it returned from probe.
>=20
> As such, the ask-reply way to checking picoLCD firmware version durin=
g
> probe is bound to timeout and let probe fail.
>=20
> Drop the check to let driver successfully probe again (until locking =
issues
> are resolved allowing to reinstate the check).
>=20
> Signed-off-by: Bruno Pr=C3=A9mont <bonbons@linux-vserver.org>
> ---
>=20
> Changes since v1:
> - drop version check during probe instead of commenting it out.
>=20
>=20
>  drivers/hid/hid-picolcd_core.c |   18 ------------------
>  1 files changed, 0 insertions(+), 18 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
