From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: /input/mouse/elan_i2c_core.c Fix some Asus
 touchapod which casue TP no funciton sometimes, the patch detect some
 specific touchpad and run a special initialize
Date: Mon, 11 Jul 2016 10:03:21 -0700
Message-ID: <20160711170321.GB26822@dtor-ws>
References: <1467979929-3409-1-git-send-email-kt.liao@emc.com.tw>
 <20160709002448.GI28589@dtor-ws>
 <019201d1db71$7986cd80$6c946880$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35576 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030774AbcGKRDZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jul 2016 13:03:25 -0400
Content-Disposition: inline
In-Reply-To: <019201d1db71$7986cd80$6c946880$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: 'KT Liao' <ktalex.liao@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, phoenix@emc.com.tw

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

We might need to split fetching product ID and IC type form the rest of
the device info.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
