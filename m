From: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: [PATCH] Input: /input/mouse/elan_i2c_core.c Fix some Asus touchapod which casue TP no funciton sometimes, the patch detect some specific touchpad and run a special initialize
Date: Tue, 12 Jul 2016 22:19:07 +0800
Message-ID: <008a01d1dc48$5a2957f0$0e7c07d0$@emc.com.tw>
References: <1467979929-3409-1-git-send-email-kt.liao@emc.com.tw> <20160709002448.GI28589@dtor-ws> <019201d1db71$7986cd80$6c946880$@emc.com.tw> <20160711170321.GB26822@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:31353 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751352AbcGLOTN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Jul 2016 10:19:13 -0400
In-Reply-To: <20160711170321.GB26822@dtor-ws>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'KT Liao' <ktalex.liao@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

Hi Dmitry,

-----Original Message-----
=46rom: 'Dmitry Torokhov' [mailto:dmitry.torokhov@gmail.com]=20
Sent: Tuesday, July 12, 2016 1:03 AM
To: =E5=BB=96=E5=B4=87=E6=A6=AE
Cc: 'KT Liao'; linux-kernel@vger.kernel.org; linux-input@vger.kernel.or=
g; phoenix@emc.com.tw
Subject: Re: [PATCH] Input: /input/mouse/elan_i2c_core.c Fix some Asus =
touchapod which casue TP no funciton sometimes, the patch detect some s=
pecific touchpad and run a special initialize

On Mon, Jul 11, 2016 at 08:40:58PM +0800, =E5=BB=96=E5=B4=87=E6=A6=AE w=
rote:
> > +
> > +	error =3D data->ops->get_sm_version(client, &data->ic_type,
> > +					  &data->sm_version);
> > +	if (error)
> > +		return false;
>=20
> That means we'd be fetching product ID and IC type twice when initial=
izing the device. Can we come with a way to do it once?
> [KT]:Because the elan_query_device_info() is behind the elan_initiali=
ze(). That's why I fetching product ID and IC type in the elan_initiali=
ze()
>     I will discuss with FW team and then execute elan_query_device_in=
fo() first to get product_id and ic_type.=20

We might need to split fetching product ID and IC type form the rest of=
 the device info.
[KT] : ok, I will extract "product ID" and "IC type" to another query-d=
evice function. and it won't change original flow too much.

Thanks.

--
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
