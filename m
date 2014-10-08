From: =?utf-8?B?RUxBTiDlionlmInpp78=?= <scott.liu@emc.com.tw>
Subject: RE: Elan TS driver patch
Date: Wed, 8 Oct 2014 09:06:20 +0800
Message-ID: <006001cfe294$13720370$3a560a50$@emc.com.tw>
References: <005301cfe221$abcd2460$03676d20$@emc.com.tw> <20141007160358.GA16469@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:22634 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755136AbaJHBG2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Oct 2014 21:06:28 -0400
In-Reply-To: <20141007160358.GA16469@dtor-ws>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, bleung@chromium.org, 'Charles Mooney' <charliemooney@google.com>, "'Jeff.Chuang'" <Jeff.chuang@emc.com.tw>, =?utf-8?B?J+aigeWNmue/lCc=?= <paul.liang@emc.com.tw>

Hi Dmitry:
	Thank for reply. Please let me know if anything needs we do.

Thanks,
Scott
=09

-----Original Message-----
=46rom: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vge=
r.kernel.org] On Behalf Of Dmitry Torokhov
Sent: Wednesday, October 08, 2014 12:04 AM
To: ELAN =E5=8A=89=E5=98=89=E9=A7=BF
Cc: linux-input@vger.kernel.org; bleung@chromium.org; Charles Mooney; J=
eff.Chuang; '=E6=A2=81=E5=8D=9A=E7=BF=94'
Subject: Re: Elan TS driver patch

Hi Scott,

On Tue, Oct 07, 2014 at 07:27:25PM +0800, ELAN =E5=8A=89=E5=98=89=E9=A7=
=BF wrote:
> Hi Dmitry:
> 	I submitted a patch to upstream for support Elan TS. Please refer to=
=20
> below link:
> 	https://lkml.org/lkml/2013/12/27/92
>=20
> 	This driver is for many chromebook and you have some contributions o=
n=20
> this:
> 	https://chromium-review.googlesource.com/#/c/218723/
> =E3=80=80=E3=80=80https://chromium-review.googlesource.com/#/c/218612=
/
> =E3=80=80=E3=80=80https://chromium-review.googlesource.com/#/c/218613=
/
> =E3=80=80=E3=80=80https://chromium-review.googlesource.com/#/c/218722=
/
> =E3=80=80=E3=80=80=E2=80=A6
> =E3=80=80=E3=80=80
> 	Do we need to re-submit this patch or you will apply it from your=20
> modification?

I believe the driver needs a few more changes before I can merge it in =
mainline; I am looking at it.

Thanks.

--
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in the body of a message to majordomo@vger.kernel.org More majordomo in=
fo at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
