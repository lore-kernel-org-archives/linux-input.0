From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xen/input: do not advertise multi-touch pressure support
Date: Tue, 2 Jan 2018 09:39:53 -0800
Message-ID: <20180102173953.tje4tz2ng3fnfijw@dtor-ws>
References: <1514880775-31185-1-git-send-email-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:35138 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeABRj5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 2 Jan 2018 12:39:57 -0500
Content-Disposition: inline
In-Reply-To: <1514880775-31185-1-git-send-email-andr2000@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>, Andrii Chepurnyi <andrii_chepurnyi@epam.com>

On Tue, Jan 02, 2018 at 10:12:55AM +0200, Oleksandr Andrushchenko wrote:
> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> 
> Some user-space applications expect multi-touch pressure
> on contact to be reported if it is advertised in device
> properties. Otherwise, such applications may treat reports
> not as actual touches, but hovering. Currently this is
> only advertised, but not reported.
> Fix this by not advertising that ABS_MT_PRESSURE is supported.
> 
> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
> Signed-off-by: Andrii Chepurnyi <andrii_chepurnyi@epam.com>

Applied, thank you.

> ---
>  drivers/input/misc/xen-kbdfront.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/misc/xen-kbdfront.c b/drivers/input/misc/xen-kbdfront.c
> index 6bf56bb5f8d9..d91f3b1c5375 100644
> --- a/drivers/input/misc/xen-kbdfront.c
> +++ b/drivers/input/misc/xen-kbdfront.c
> @@ -326,8 +326,6 @@ static int xenkbd_probe(struct xenbus_device *dev,
>  				     0, width, 0, 0);
>  		input_set_abs_params(mtouch, ABS_MT_POSITION_Y,
>  				     0, height, 0, 0);
> -		input_set_abs_params(mtouch, ABS_MT_PRESSURE,
> -				     0, 255, 0, 0);
>  
>  		ret = input_mt_init_slots(mtouch, num_cont, INPUT_MT_DIRECT);
>  		if (ret) {
> -- 
> 2.7.4
> 

-- 
Dmitry
