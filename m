From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v7 1/3] Input: add regulator haptic driver
Date: Wed, 17 Dec 2014 17:20:33 -0800
Message-ID: <1633066.YGSdCsNTgy@dtor-glaptop>
References: <1418787308-29019-1-git-send-email-jaewon02.kim@samsung.com> <20141217220602.GC32399@dtor-ws> <54922B36.8050306@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f171.google.com ([209.85.213.171]:48455 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbaLRBUh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Dec 2014 20:20:37 -0500
In-Reply-To: <54922B36.8050306@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-input@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Hyunhee Kim <hyunhee.kim@samsung.com>

On Thursday, December 18, 2014 10:17:42 AM Jaewon Kim wrote:
> Hi Dmity,
>=20
> 2014=EB=85=84 12=EC=9B=94 18=EC=9D=BC 07:06=EC=97=90 Dmitry Torokhov =
=EC=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> > HI Jaewon,
> >=20
> > On Wed, Dec 17, 2014 at 12:35:06PM +0900, Jaewon Kim wrote:
> >> This patch adds support for haptic driver controlled by
> >> voltage of regulator. And this driver support for
> >> Force Feedback interface from input framework
> >>=20
> >> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> >> Signed-off-by: Hyunhee Kim <hyunhee.kim@samsung.com>
> >> Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
> >> Tested-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
> >> Reviewed-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> >=20
> > Does the driver still work if you apply the patch below on top of y=
ours?
> >=20
> > Thanks.
>=20
> Yes, there is no problem to apply this one first.

Thank you. Then I'll fold it into yours and queue the driver for the ne=
xt=20
release.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
