From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: TOUCHSCREEN_TSC2005 should depend on
 GENERIC_HARDIRQS
Date: Mon, 21 Mar 2011 02:37:35 -0700
Message-ID: <20110321093735.GB6897@core.coreip.homeip.net>
References: <alpine.DEB.2.00.1103201312320.6633@ayla.of.borg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53801 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705Ab1CUJhk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Mar 2011 05:37:40 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1103201312320.6633@ayla.of.borg>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Lauri Leukkunen <lauri.leukkunen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Linux Kernel Development <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org

On Sun, Mar 20, 2011 at 01:23:16PM +0100, Geert Uytterhoeven wrote:
> drivers/input/touchscreen/tsc2005.c: In function =E2=80=98tsc2005_pro=
be=E2=80=99:
> drivers/input/touchscreen/tsc2005.c:666: error: implicit declaration =
of function =E2=80=98set_irq_wake=E2=80=99
>=20
> In addition, migrate from set_irq_wake() (marked "do not use" as of c=
ommit
> a0cd9ca2b907d7ee26575e7b63ac92dad768a75e ("genirq: Namespace cleanup"=
)) to
> irq_set_irq_wake().
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Applied, thank you Geert.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
