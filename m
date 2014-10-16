From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: misc: max77693-haptic - fix active state check in
 disable()
Date: Thu, 16 Oct 2014 14:00:18 -0700
Message-ID: <20141016210018.GD38361@dtor-ws>
References: <1413342978-30349-1-git-send-email-jaewon02.kim@samsung.com>
 <543DF56B.2080009@samsung.com>
 <543DF957.3040907@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:47890 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbaJPVAY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2014 17:00:24 -0400
Received: by mail-pa0-f52.google.com with SMTP id fb1so4107009pad.25
        for <linux-input@vger.kernel.org>; Thu, 16 Oct 2014 14:00:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <543DF957.3040907@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaewon Kim <jaewon02.kim@samsung.com>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, linux-input@vger.kernel.org

On Wed, Oct 15, 2014 at 01:34:31PM +0900, Jaewon Kim wrote:
> Hi Chanwoo,
>=20
>=20
> 2014=EB=85=84 10=EC=9B=94 15=EC=9D=BC 13:17=EC=97=90 Chanwoo Choi =EC=
=9D=B4(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> >Hi Jaewon,
> >
> >I think you better to use ':' instead of '-'.
> >- before: Input: misc: max77693-haptic -
> >- after : Input: misc: max77693-haptic:
> I refer past log message.
> I think '-' is input driver style.

Yes, the input style is "Input: <driver> - <short change title>"

Applied, thank you.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
