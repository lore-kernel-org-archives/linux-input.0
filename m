From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH -next] Input: zforce - fix error return code in
 zforce_start()
Date: Wed, 18 Dec 2013 08:50:48 -0800
Message-ID: <20131218165048.GC30922@core.coreip.homeip.net>
References: <CAPgLHd8WBR38qd9VHfazXVTbuoJ=GPOafHzSz8d9XJ-F61a7nQ@mail.gmail.com>
 <201312171606.49401.heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:37559 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853Ab3LRQuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Dec 2013 11:50:52 -0500
Received: by mail-pa0-f50.google.com with SMTP id kl14so6227715pab.9
        for <linux-input@vger.kernel.org>; Wed, 18 Dec 2013 08:50:52 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201312171606.49401.heiko@sntech.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, rydberg@euromail.se, yongjun_wei@trendmicro.com.cn, linux-input@vger.kernel.org

On Tue, Dec 17, 2013 at 04:06:49PM +0100, Heiko St=FCbner wrote:
> Am Dienstag, 17. Dezember 2013, 04:27:16 schrieb Wei Yongjun:
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >=20
> > The error code was not set if unable to set config, so the error
> > condition wasn't reflected in the return value. Fix to return a
> > negative error code from the error handling case instead of 0.
> >=20
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
>=20
> Thanks for the catch.
>=20
> Acked-by: Heiko Stuebner <heiko@sntech.de>

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
