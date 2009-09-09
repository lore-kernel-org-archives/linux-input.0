From: Jinsung Yang <jsgood.yang@samsung.com>
Subject: RE: [PATCH 0/4] Fixed keypad driver for Samsung SoC
Date: Wed, 09 Sep 2009 20:27:46 +0900
Message-ID: <000f01ca3140$8e48bcc0$aada3640$%yang@samsung.com>
References: <000d01ca313e$867e7bd0$937b7370$%yang@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:13418 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752829AbZIILZD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Sep 2009 07:25:03 -0400
Received: from epmmp1 (mailout3.samsung.com [203.254.224.33])
 by mailout1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0KPP00E4MBPS61@mailout1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 09 Sep 2009 20:25:04 +0900 (KST)
Received: from JSGOODMAIN ([12.23.109.106])
 by mmp1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTPA id <0KPP00KGCBPS5V@mmp1.samsung.com> for
 linux-input@vger.kernel.org; Wed, 09 Sep 2009 20:25:04 +0900 (KST)
In-reply-to: <000d01ca313e$867e7bd0$937b7370$%yang@samsung.com>
Content-language: ko
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Jinsung Yang' <jsgood.yang@samsung.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, ben-linux@fluff.org
Cc: linux-input@vger.kernel.org, laforge@gnumonks.org, =?utf-8?B?J+q5gOqyveydvC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FMyjsgqzsm5Ap?= =?utf-8?B?L+yCvOyEseyghOyekCc=?= <ki0351.kim@samsung.com>, =?utf-8?B?J+q5gOq1reynhC9BUOqwnOuwnO2MgChTWVMuTFNJKS9FNSjssYXsnoQp?= =?utf-8?B?L+yCvOyEseyghOyekCc=?= <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org

Hi Ben,

Also old [PATCH 10/12] must be removed for new [PATCH 4/4].
I'm sorry for your confusion.

Best Regards
--
Jinsung, Yang <jsgood.yang@samsung.com>
AP Development Team
System LSI, Semiconductor Business
SAMSUNG Electronics Co., LTD


> -----Original Message-----
> From: linux-input-owner@vger.kernel.org [mailto:linux-input-
> owner@vger.kernel.org] On Behalf Of Jinsung Yang
> Sent: Wednesday, September 09, 2009 8:13 PM
> To: Dmitry Torokhov; ben-linux@fluff.org
> Cc: linux-input@vger.kernel.org; laforge@gnumonks.org; '=EA=B9=80=EA=B2=
=BD=EC=9D=BC/AP=EA=B0=9C=EB=B0=9C=ED=8C=80
> (SYS.LSI)/E3(=EC=82=AC=EC=9B=90)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90=
'; '=EA=B9=80=EA=B5=AD=EC=A7=84/AP=EA=B0=9C=EB=B0=9C=ED=8C=80(SYS.LSI)/=
E5(=EC=B1=85=EC=9E=84)/=EC=82=BC=EC=84=B1=EC=A0=84=EC=9E=90';
> linux-arm-kernel@lists.infradead.org
> Subject: [PATCH 0/4] Fixed keypad driver for Samsung SoC
>=20
> From: Jinsung Yang <jsgood.yang@samsung.com>
>=20
> To Dmitry:
> This patch series are including new Samsung SoC keypad driver with fi=
xing
> wrong implementations which commented by you.
> All changes and adds are in single patch.
>=20
> [PATCH 1/4] [INPUT][KEYBOARD] Samsung keypad driver support
>=20
> This patch depends on following architecture patches:
>=20
> [PATCH 2/4] [ARM][S3C] Add definition for keypad platform data
> [PATCH 3/4] [ARM][S3C] Add definition for keypad register
> [PATCH 4/4] [ARM][S3C] Add support keypad platform data
>=20
> To Ben:
> As you know, I sent to you 12 patches for keypad driver some days ago=
,
> however I need to change several patch files with following guidance:
>=20
> This [PATCH 2/4] must be used instead of old [PATCH 07/12]
> This [PATCH 3/4] must be used instead of old [PATCH 09/12]
> This [PATCH 4/4] must be used instead of old both [PATCH 11/12] and [=
PATCH
> 12/12]
>=20
> Best Regards
> --
> Jinsung, Yang <jsgood.yang@samsung.com>
> AP Development Team
> System LSI, Semiconductor Business
> SAMSUNG Electronics Co., LTD
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
