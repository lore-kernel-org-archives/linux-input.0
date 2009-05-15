From: Kwangwoo Lee <kwangwoo.lee@gmail.com>
Subject: Re: [PATCH] Input: tsc2007: Remove a useless code and check a
	necessary function is provided or not
Date: Fri, 15 May 2009 16:50:33 +0900
Message-ID: <483a38b80905150050v41358f89yf0c7aeb7fe9cf990@mail.gmail.com>
References: <483a38b80905142247l31dc77f6sd3deb511fc171f5e@mail.gmail.com>
	 <20090515072658.GB32380@roarinelk.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wf-out-1314.google.com ([209.85.200.175]:50900 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026AbZEOHub convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 May 2009 03:50:31 -0400
Received: by wf-out-1314.google.com with SMTP id 26so1059000wfd.4
        for <linux-input@vger.kernel.org>; Fri, 15 May 2009 00:50:33 -0700 (PDT)
In-Reply-To: <20090515072658.GB32380@roarinelk.homelinux.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Lauss <mano@roarinelk.homelinux.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thierry Reding <thierry.reding@avionic-design.de>, Trilok Soni <soni.trilok@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Fri, May 15, 2009 at 4:26 PM, Manuel Lauss
<mano@roarinelk.homelinux.net> wrote:
> On Fri, May 15, 2009 at 02:47:12PM +0900, Kwangwoo Lee wrote:
>> --- a/drivers/input/touchscreen/tsc2007.c
>> +++ b/drivers/input/touchscreen/tsc2007.c
>> @@ -253,11 +253,11 @@ static int tsc2007_probe(struct i2c_client *cl=
ient,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 const struct i2c_device_=
id *id)
>> =A0{
>> =A0 =A0 =A0 struct tsc2007 *ts;
>> - =A0 =A0 struct tsc2007_platform_data *pdata =3D pdata =3D client->=
dev.platform_data;
>> + =A0 =A0 struct tsc2007_platform_data *pdata =3D client->dev.platfo=
rm_data;
>
> This change is already in a previous patch of yours.
> (http://www.spinics.net/lists/linux-input/msg03404.html)

Yes, I know.
The patch has a bit different subject. And it is requried to review mor=
e.
This patch just includes small fix and check.

>
> Manuel Lauss
>

--=20
Kwangwoo Lee <kwangwoo.lee@gmail.com>
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
