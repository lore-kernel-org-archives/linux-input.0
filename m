From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Elan TS driver patch
Date: Tue, 7 Oct 2014 09:03:58 -0700
Message-ID: <20141007160358.GA16469@dtor-ws>
References: <005301cfe221$abcd2460$03676d20$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54280 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbaJGQED (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 12:04:03 -0400
Received: by mail-pa0-f50.google.com with SMTP id kx10so7504267pab.9
        for <linux-input@vger.kernel.org>; Tue, 07 Oct 2014 09:04:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <005301cfe221$abcd2460$03676d20$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: ELAN =?utf-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Cc: linux-input@vger.kernel.org, bleung@chromium.org, Charles Mooney <charliemooney@google.com>, "Jeff.Chuang" <Jeff.chuang@emc.com.tw>, =?utf-8?B?J+aigeWNmue/lCc=?= <paul.liang@emc.com.tw>

Hi Scott,

On Tue, Oct 07, 2014 at 07:27:25PM +0800, ELAN =E5=8A=89=E5=98=89=E9=A7=
=BF wrote:
> Hi Dmitry:
> 	I submitted a patch to upstream for support Elan TS. Please refer to
> below link:
> 	https://lkml.org/lkml/2013/12/27/92
>=20
> 	This driver is for many chromebook and you have some contributions
> on this:
> 	https://chromium-review.googlesource.com/#/c/218723/
> =E3=80=80=E3=80=80https://chromium-review.googlesource.com/#/c/218612=
/
> =E3=80=80=E3=80=80https://chromium-review.googlesource.com/#/c/218613=
/
> =E3=80=80=E3=80=80https://chromium-review.googlesource.com/#/c/218722=
/
> =E3=80=80=E3=80=80=E2=80=A6
> =E3=80=80=E3=80=80
> 	Do we need to re-submit this patch or you will apply it from your
> modification?

I believe the driver needs a few more changes before I can merge it in
mainline; I am looking at it.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
