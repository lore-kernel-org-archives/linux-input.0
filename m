From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Input-gameport: Use kmalloc_array() in
 joydump_connect()
Date: Sat, 24 Sep 2016 09:42:51 -0700
Message-ID: <20160924164251.GC40187@dtor-ws>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <7ff91d13-9111-c75a-1c1a-e119025866e7@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33536 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758851AbcIXQmy (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 24 Sep 2016 12:42:54 -0400
Content-Disposition: inline
In-Reply-To: <7ff91d13-9111-c75a-1c1a-e119025866e7@users.sourceforge.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Sat, Sep 24, 2016 at 03:46:21PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 24 Sep 2016 13:50:20 +0200
> 
> * A multiplication for the size determination of a memory allocation
>   indicated that an array data structure should be processed.
>   Thus use the corresponding function "kmalloc_array".
> 

-ENOPARSE.

>   This issue was detected by using the Coccinelle software.
> 
> * Replace the specification of a data structure by a pointer dereference
>   to make the corresponding size determination a bit safer according to
>   the Linux coding style convention.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/input/joystick/joydump.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/joystick/joydump.c b/drivers/input/joystick/joydump.c
> index d1c6e48..e515058 100644
> --- a/drivers/input/joystick/joydump.c
> +++ b/drivers/input/joystick/joydump.c
> @@ -79,8 +79,7 @@ static int joydump_connect(struct gameport *gameport, struct gameport_driver *dr
>  	}
>  
>  	timeout = gameport_time(gameport, 10000); /* 10 ms */
> -
> -	buf = kmalloc(BUF_SIZE * sizeof(struct joydump), GFP_KERNEL);
> +	buf = kmalloc_array(BUF_SIZE, sizeof(*buf), GFP_KERNEL);
>  	if (!buf) {
>  		printk(KERN_INFO "joydump: no memory for testing\n");
>  		goto jd_end;
> -- 
> 2.10.0
> 

-- 
Dmitry
