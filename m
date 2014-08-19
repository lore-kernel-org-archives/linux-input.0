From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] sparc: i8042-sparcio.h: fix unused kbd_res warning
Date: Tue, 19 Aug 2014 14:18:16 -0700
Message-ID: <20140819211816.GA12231@core.coreip.homeip.net>
References: <1408482577-17837-1-git-send-email-vincent.stehle@laposte.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:44678 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750861AbaHSVSW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Aug 2014 17:18:22 -0400
Content-Disposition: inline
In-Reply-To: <1408482577-17837-1-git-send-email-vincent.stehle@laposte.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@laposte.net>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

On Tue, Aug 19, 2014 at 11:09:37PM +0200, Vincent Stehl=C3=A9 wrote:
> kbd_res is used only when CONFIG_PCI is defined; condition its declar=
ation as
> well. This fixes the following compilation warning:
>=20
>   drivers/input/serio/i8042-sparcio.h:20:25: warning: =E2=80=98kbd_re=
s=E2=80=99 defined but not used [-Wunused-variable]
>=20
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@laposte.net>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
