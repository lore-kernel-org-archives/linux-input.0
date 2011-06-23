From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [PATCH 09/37] Remove unneeded version.h includes from drivers/input/
Date: Thu, 23 Jun 2011 18:50:32 -0400
Message-ID: <BANLkTimAJ3XCfhn5REP7dAaqRTxF93V8YA@mail.gmail.com>
References: <alpine.LNX.2.00.1106232344480.17688@swampdragon.chaosbits.net> <alpine.LNX.2.00.1106240009201.17688@swampdragon.chaosbits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62001 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760094Ab1FWWuy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2011 18:50:54 -0400
In-Reply-To: <alpine.LNX.2.00.1106240009201.17688@swampdragon.chaosbits.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jesper Juhl <jj@chaosbits.net>
Cc: LKML <linux-kernel@vger.kernel.org>, trivial@kernel.org, Michael Hennerich <michael.hennerich@analog.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@ipvvis.unipv.it>, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Thu, Jun 23, 2011 at 18:10, Jesper Juhl wrote:
> =C2=A0drivers/input/keyboard/adp5588-keys.c | =C2=A0 =C2=A01 -
> =C2=A0drivers/input/keyboard/adp5589-keys.c | =C2=A0 =C2=A01 -
> =C2=A0drivers/input/misc/bfin_rotary.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=
=A01 -

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
