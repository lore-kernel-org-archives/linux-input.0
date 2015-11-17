From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/5] Input: db9 - clear unused function pointers
Date: Tue, 17 Nov 2015 10:00:52 -0800
Message-ID: <20151117180052.GB29423@dtor-ws>
References: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:34891 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753645AbbKQSAz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Nov 2015 13:00:55 -0500
Content-Disposition: inline
In-Reply-To: <1447767619-28329-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Nov 17, 2015 at 07:10:15PM +0530, Sudip Mukherjee wrote:
> db9_parport_cb is a local uninitialized structure and the member
> function pointers will be pointing to arbitrary locations unless they
> are cleared.
> 
> Fixes: 2260c419b52b ("Input: db9 - use parallel port device model")
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Applied all 5, thank you.

> ---
>  drivers/input/joystick/db9.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/joystick/db9.c b/drivers/input/joystick/db9.c
> index 932d073..da32609 100644
> --- a/drivers/input/joystick/db9.c
> +++ b/drivers/input/joystick/db9.c
> @@ -592,6 +592,7 @@ static void db9_attach(struct parport *pp)
>  		return;
>  	}
>  
> +	memset(&db9_parport_cb, 0, sizeof(db9_parport_cb));
>  	db9_parport_cb.flags = PARPORT_FLAG_EXCL;
>  
>  	pd = parport_register_dev_model(pp, "db9", &db9_parport_cb, port_idx);
> -- 
> 1.9.1
> 

-- 
Dmitry
