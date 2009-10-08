From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: ads7846 touchscreen: fix pressure
Date: Thu, 8 Oct 2009 10:39:39 +0530
Message-ID: <5d5443650910072209t63e3fa9dvff7ab2fee7bb2f88@mail.gmail.com>
References: <20091006195413.GA1469@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qy0-f194.google.com ([209.85.221.194]:42886 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbZJHFKQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Oct 2009 01:10:16 -0400
In-Reply-To: <20091006195413.GA1469@ucw.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: dtor@mail.ru, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>

Hi Pavel,

On Wed, Oct 7, 2009 at 1:24 AM, Pavel Machek <pavel@ucw.cz> wrote:
>
> On Zaurus, pressure is reported inverted -- the lighter the pressure,
> the bigger numerical value. This should fix it.
>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
>
> --- linux-rc/drivers/input.ofic/touchscreen/ads7846.c =A0 2009-10-06 =
13:49:56.000000000 +0200
> +++ linux-rc/drivers/input/touchscreen/ads7846.c =A0 =A0 =A0 =A02009-=
10-06 21:18:25.000000000 +0200
> @@ -608,12 +609,12 @@
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_X, x);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0input_report_abs(input, ABS_Y, y);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, R=
t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 input_report_abs(input, ABS_PRESSURE, t=
s->pressure_max-Rt);

but same behavior is seen by others using this chip on different
boards? If not, this has to be done through platform data.

--=20
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
