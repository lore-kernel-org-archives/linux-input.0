From: Scott <scott.liu@emc.com.tw>
Subject: Re: Elan TS driver patch
Date: Sun, 12 Oct 2014 23:22:37 +0800
Message-ID: <24A1508F-93CB-4139-BF22-4BD7A118E005@emc.com.tw>
References: <005301cfe221$abcd2460$03676d20$@emc.com.tw> <20141007160358.GA16469@dtor-ws> <006001cfe294$13720370$3a560a50$@emc.com.tw> <20141010221137.GD38320@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from elanic.emc.com.tw ([192.72.220.188]:54126 "EHLO
	elanic.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751494AbaJLPWz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Oct 2014 11:22:55 -0400
In-Reply-To: <20141010221137.GD38320@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, bleung@chromium.org, Charles Mooney <charliemooney@google.com>, "Jeff.Chuang" <Jeff.chuang@emc.com.tw>, =?big5?B?seez1bW+?= <paul.liang@emc.com.tw>


Hi Dmitry:

Dmitry Torokhov <dmitry.torokhov@gmail.com> =A9=F3 2014/10/11 =A4W=A4=C8=
6:11 =BCg=B9D=A1G

> Hi Scott,
>=20
> On Wed, Oct 08, 2014 at 09:06:20AM +0800, ELAN =BCB=B9=C5=C2@ wrote:
>> Hi Dmitry:
>> 	Thank for reply. Please let me know if anything needs we do.
>=20
> What is the part name/number of this touchscreen. As the example with
> touchpad shown us device tree folks are not happy with the generic
> "i2c_touchpad" or "elants_i2c" and would rather we used proper model
> number in bindings.
>=20

	I would call this driver name as =A1=A7Elan Large-Size Touchscreen=A1=A8=
=2E
	We (Elan) have two types of TS series internally, Large-size( > 10=A1=A8=
 ~ 20") and small-size ( <=3D 10=A1=A8)
	and this driver patch is for large size. thanks.

BR
Scott


> Thanks.
>=20
> --=20
> Dmitry
> --
> To unsubscribe from this list: send the line "unsubscribe linux-input=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
