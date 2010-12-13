From: "Kim, HeungJun" <riverful.kim@samsung.com>
Subject: Re: [PATCH v2 2/2] input: keyboard: MCS5080: support shutdown.
Date: Mon, 13 Dec 2010 19:30:22 +0900
Message-ID: <4D05F5BE.8000905@samsung.com>
References: <4CE617CD.2090006@samsung.com>
 <20101213090121.GG21401@core.coreip.homeip.net>
Reply-To: riverful.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:63781 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756964Ab0LMKae (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Dec 2010 05:30:34 -0500
Received: from epmmp1 (mailout1.samsung.com [203.254.224.24])
 by mailout1.samsung.com
 (Oracle Communications Messaging Exchange Server 7u4-19.01 64bit (built Sep  7
 2010)) with ESMTP id <0LDD00CMS3UVZAA0@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 13 Dec 2010 19:30:31 +0900 (KST)
Received: from TNRNDGASPAPP1.tn.corp.samsungelectronics.net ([165.213.149.150])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0LDD005NK3UVVD@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Mon, 13 Dec 2010 19:30:31 +0900 (KST)
In-reply-to: <20101213090121.GG21401@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

And the reason to insert powerof() function is that,
the MCS50XX series has some HW bugs like following:

If the MCS50XX is not yet powered down before the whole system is power=
-down,
when control pins like a powerup or interrupt is pulluped,
the residue current is flow into chips and the chip still consume the p=
ower.

It seems not be important general PC(if this small device is implemente=
d with PC),
but it's very important in the mobile device.

sorry not to write such specific contents before.

Thanks.

Regards,
HeungJun Kim


2010-12-13 =EC=98=A4=ED=9B=84 6:01, Dmitry Torokhov =EC=93=B4 =EA=B8=80=
:
> On Fri, Nov 19, 2010 at 03:23:09PM +0900, Kim, HeungJun wrote:
>> This patch supports shutdown functions for mcs5080 touchkey
>> driver.
>>
>=20
> Rarely a device needs shutdown method; normally it is enough to simpl=
y
> cut power off. Why this device needs it?
>=20
> Thanks.
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
