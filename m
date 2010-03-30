From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Logitech M705 thumb button
Date: Mon, 29 Mar 2010 23:56:25 -0700
Message-ID: <20100330065625.GC12764@core.coreip.homeip.net>
References: <hoqak4$m6t$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f193.google.com ([209.85.210.193]:50740 "EHLO
	mail-yx0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754273Ab0C3G4a (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 30 Mar 2010 02:56:30 -0400
Received: by yxe31 with SMTP id 31so6702836yxe.16
        for <linux-input@vger.kernel.org>; Mon, 29 Mar 2010 23:56:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <hoqak4$m6t$1@dough.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Octoploid <Cryptooctoploid@gmail.com>
Cc: linux-input@vger.kernel.org

Hi,

On Mon, Mar 29, 2010 at 03:40:20PM +0200, Octoploid wrote:
> Just bought a Logitech M705 mouse today and everything is working
> fine except the thumb button. I just don't get any events in =BBxev=AB=
 or=20
> =BBxinput test=AB when I press that button.
> This mouse comes with the new =BBUnifying USB receiver=AB.
>=20
> Any hints on how I could get that button working?=20
>=20

Start with locating "evtest" utility and confirming that the kerenl doe=
s
not emit any events for the thumb button.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
