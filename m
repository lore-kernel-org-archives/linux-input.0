From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Subject: Re: [RFC][PATCH] Input: Use monotonic time for event time stamps.
Date: Wed, 21 Dec 2011 09:41:50 +0800
Message-ID: <4EF1395E.405@cn.fujitsu.com>
References: <1324429303.30527.92.camel@work-vm>
Reply-To: gaowanlong@cn.fujitsu.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:54409 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1753279Ab1LUBnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 20 Dec 2011 20:43:06 -0500
In-Reply-To: <1324429303.30527.92.camel@work-vm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: john stultz <johnstul@us.ibm.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>

On 12/21/2011 09:01 AM, john stultz wrote:

> Hi
> 	In reviewing the Android patch set, I noticed the following patch fr=
om
> Arve which looks like it resolves a reasonable issue (events using
> CLOCK_REALTIME timestamps, which can jump forwards or backwards via
> settimeofday()).
>=20
> I'm not very familiar with the evdev interface, so I'm not sure if
> changing the timestamps to CLOCK_MONOTONIC could cause an ABI problem
> with legacy apps. Even so, I wanted to send the patch out for review =
and
> consideration as it seems like a reasonable fix.
>=20
> thanks
> -john
>=20
>=20
>=20
>>From 20950b728f120cd808965c1a20b024aa79706d8d Mon Sep 17 00:00:00 200=
1
> From: =3D?UTF-8?q?=3D3D=3D3FUTF-8=3D3Fq=3D3FArve=3D3D20Hj=3D3DC3=3D3D=
B8nnev=3D3DC3=3D3DA5g=3D3F=3D3D?=3D <arve@android.com>
> Date: Fri, 2 Dec 2011 13:59:05 +0800
> Subject: [PATCH] Input: Use monotonic time for event time stamps.
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>=20
> Since wall time can jump backwards, it cannot be used to determine if=
 one
> event occured before another or for how long a key was pressed.


seems reasonable.

>=20
> CC: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> CC: linux-input@vger.kernel.org
> Signed-off-by: Arve Hj=C3=B8nnev=C3=A5g <arve@android.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> ---
>  drivers/input/evdev.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
> index 4cf2534..ec329b4 100644
> --- a/drivers/input/evdev.c
> +++ b/drivers/input/evdev.c
> @@ -94,8 +94,11 @@ static void evdev_event(struct input_handle *handl=
e,
>  	struct evdev *evdev =3D handle->private;
>  	struct evdev_client *client;
>  	struct input_event event;
> +	struct timespec ts;
> =20
> -	do_gettimeofday(&event.time);
> +	ktime_get_ts(&ts);
> +	event.time.tv_sec =3D ts.tv_sec;
> +	event.time.tv_usec =3D ts.tv_nsec / NSEC_PER_USEC;
>  	event.type =3D type;
>  	event.code =3D code;
>  	event.value =3D value;


--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
