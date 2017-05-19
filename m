From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] input: touchscreen: atmel_mxt_ts: add T100 as a
 readable object
Date: Fri, 19 May 2017 14:59:48 -0700
Message-ID: <20170519215948.GF19281@dtor-ws>
References: <1495034973-30806-1-git-send-email-maxime.roussinbelanger@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33033 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756925AbdESV7v (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 17:59:51 -0400
Received: by mail-pf0-f196.google.com with SMTP id f27so10744762pfe.0
        for <linux-input@vger.kernel.org>; Fri, 19 May 2017 14:59:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1495034973-30806-1-git-send-email-maxime.roussinbelanger@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maxime =?iso-8859-1?Q?Roussin-B=E9langer?= <maxime.roussinbelanger@gmail.com>
Cc: Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, jeff.dagenais@gmail.com

On Wed, May 17, 2017 at 11:29:33AM -0400, Maxime Roussin-Bélanger wrote:
> When using the 'object' sysfs attribute, T100 is not displayed in
> the output.
> 
> Signed-off-by: Maxime Roussin-Bélanger <maxime.roussinbelanger@gmail.com>
> --

Applied, thank you.

> Changes in v2:
>   - Fix commit description 'sysfs file' to 'sysfs attribute'.-
> 
>  drivers/input/touchscreen/atmel_mxt_ts.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index e5d185f..090725e 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -350,6 +350,7 @@ static bool mxt_object_readable(unsigned int type)
>  	case MXT_TOUCH_KEYARRAY_T15:
>  	case MXT_TOUCH_PROXIMITY_T23:
>  	case MXT_TOUCH_PROXKEY_T52:
> +	case MXT_TOUCH_MULTITOUCHSCREEN_T100:
>  	case MXT_PROCI_GRIPFACE_T20:
>  	case MXT_PROCG_NOISE_T22:
>  	case MXT_PROCI_ONETOUCH_T24:
> -- 
> 2.1.4
> 

-- 
Dmitry
