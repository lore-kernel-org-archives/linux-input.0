From: Aniroop Mathur <a.mathur@samsung.com>
Subject: Re: [PATCH] Input: touchscreen: edt_ft5x06 - change msleep to
 usleep_range for small msecs
Date: Wed, 30 Nov 2016 02:24:17 +0530
Message-ID: <CAOXgUe1MULGQZJ=pNsSKrvVcCFptVn5b2Qafjao1_xrxVYn0JQ@mail.gmail.com>
References: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f193.google.com ([209.85.223.193]:35213 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbcK2UyT (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 29 Nov 2016 15:54:19 -0500
In-Reply-To: <1480358514-2894-1-git-send-email-a.mathur@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon.budig@kernelconcepts.de, daniel.wagener@kernelconcepts.de, LW@karo-electronics.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: s.samuel@samsung.com, r.mahale@samsung.com, Aniroop Mathur <aniroop.mathur@gmail.com>, Aniroop Mathur <a.mathur@samsung.com>

Dear Simon Budig / Daniel Wagener / Lothar Wa=C3=9Fmann,

Greetings!

I am Aniroop Mathur from Samsung R&D Institute, India.

I have submitted one patch as below for review to Linux Open Source.
The problem is that we do not have the hardware available with us to
test it and we would like to test it before actually applying it.
As you are the author of this driver, I am contacting you to request you to
provide your feedback upon this patch.

Also if you have the hardware available, could you please help to
test this patch on your hardware? or could you provide contact points
of individuals who could support to test it?

Thank you!

BR,
Aniroop Mathur

On Tue, Nov 29, 2016 at 12:11 AM, Aniroop Mathur <a.mathur@samsung.com> wro=
te:
> msleep(1~20) may not do what the caller intends, and will often sleep lon=
ger.
> (~20 ms actual sleep for any value given in the 1~20ms range)
> This is not the desired behaviour for many cases like device resume time,
> device suspend time, device enable time, retry logic, etc.
> Thus, change msleep to usleep_range for precise wakeups.
>
> Signed-off-by: Aniroop Mathur <a.mathur@samsung.com>
> ---
>  drivers/input/touchscreen/edt-ft5x06.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touch=
screen/edt-ft5x06.c
> index 703e295..379dd31 100644
> --- a/drivers/input/touchscreen/edt-ft5x06.c
> +++ b/drivers/input/touchscreen/edt-ft5x06.c
> @@ -67,7 +67,7 @@
>  #define EDT_SWITCH_MODE_RETRIES                10
>  #define EDT_SWITCH_MODE_DELAY          5 /* msec */
>  #define EDT_RAW_DATA_RETRIES           100
> -#define EDT_RAW_DATA_DELAY             1 /* msec */
> +#define EDT_RAW_DATA_DELAY             1000 /* usec */
>
>  enum edt_ver {
>         M06,
> @@ -664,7 +664,7 @@ static ssize_t edt_ft5x06_debugfs_raw_data_read(struc=
t file *file,
>         }
>
>         do {
> -               msleep(EDT_RAW_DATA_DELAY);
> +               usleep_range(EDT_RAW_DATA_DELAY, EDT_RAW_DATA_DELAY + 100=
);
>                 val =3D edt_ft5x06_register_read(tsdata, 0x08);
>                 if (val < 1)
>                         break;
> --
> 2.6.2
>
