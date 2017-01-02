From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] input: synaptics-rmi4: check for non zero version
 logically dead code
Date: Mon, 2 Jan 2017 10:03:08 +0100
Message-ID: <20170102090308.GB5767@mail.corp.redhat.com>
References: <20161220095649.7674-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161220095649.7674-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Nick Dyer <nick@shmanahar.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Dec 20 2016 or thereabouts, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> version is a u8, the check for version > 0 means that version can only
> be zero, so the subsequent check for version != 0 is never true and
> hence is redudant code and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Works for me:
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

>  drivers/input/rmi4/rmi_f34.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f34.c b/drivers/input/rmi4/rmi_f34.c
> index 9774dfb..c3285ce 100644
> --- a/drivers/input/rmi4/rmi_f34.c
> +++ b/drivers/input/rmi4/rmi_f34.c
> @@ -441,8 +441,6 @@ static int rmi_f34_probe(struct rmi_function *fn)
>  	/* v5 code only supported version 0, try V7 probe */
>  	if (version > 0)
>  		return rmi_f34v7_probe(f34);
> -	else if (version != 0)
> -		return -ENODEV;
>  
>  	f34->bl_version = 5;
>  
> -- 
> 2.10.2
> 
