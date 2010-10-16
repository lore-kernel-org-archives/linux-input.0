From: Mike Frysinger <vapier.adi@gmail.com>
Subject: Re: [Device-drivers-devel] [PATCH 3/3] Input: touchscreen: ad7877
 filter events where pressure is beyond the maximum
Date: Fri, 15 Oct 2010 21:51:12 -0400
Message-ID: <AANLkTimg2Uv26dcU7noSGCX7SHOn2+p6-LH_q=h9NtWc@mail.gmail.com>
References: <1287139250-24777-1-git-send-email-michael.hennerich@analog.com> <1287139250-24777-3-git-send-email-michael.hennerich@analog.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59634 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752348Ab0JPBve convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 15 Oct 2010 21:51:34 -0400
Received: by wyb28 with SMTP id 28so1240686wyb.19
        for <linux-input@vger.kernel.org>; Fri, 15 Oct 2010 18:51:33 -0700 (PDT)
In-Reply-To: <1287139250-24777-3-git-send-email-michael.hennerich@analog.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: michael.hennerich@analog.com
Cc: dmitry.torokhov@gmail.com, drivers@analog.com, device-drivers-devel@blackfin.uclinux.org, linux-input@vger.kernel.org

On Fri, Oct 15, 2010 at 06:40,  <michael.hennerich@analog.com> wrote:
> Suppress events where pressure > pressure_max.
> These events come typically along with inaccurate X and Y samples.

were you going to commit to the blackfin tree ?

> --- a/drivers/input/touchscreen/ad7877.c
> +++ b/drivers/input/touchscreen/ad7877.c
> @@ -360,6 +360,13 @@ static int ad7877_rx(struct ad7877 *ts)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Rt /=3D z1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Rt =3D (Rt + 2=
047) >> 12;
>
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Sample fou=
nd inconsistent, pressure is beyond
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* the maximu=
m. Don't report it to user space.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (Rt > ts->press=
ure_max)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return -EINVAL;

this has spaces in the middle of your tab indents ...
-mike
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
