From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: sony: remove redundant check for -ve err
Date: Fri, 31 Mar 2017 11:01:31 +0200
Message-ID: <20170331090131.GG22683@mail.corp.redhat.com>
References: <20170327175118.28322-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170327175118.28322-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Mar 27 2017 or thereabouts, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> err is being checked for failure each time it is being updated
> so this err check is totally redundant and can be removed
> 
> Detected with CoverityScan, CID#1420665 ("Logically dead code")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Indeed. Not sure if it will conflict with Roderick's series, but still:

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-sony.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
> index bb124e339d26..e3c6fe554056 100644
> --- a/drivers/hid/hid-sony.c
> +++ b/drivers/hid/hid-sony.c
> @@ -2614,9 +2614,6 @@ static int sony_input_configured(struct hid_device *hdev,
>  		ret = 0;
>  	}
>  
> -	if (ret < 0)
> -		goto err_stop;
> -
>  	if (sc->quirks & SONY_LED_SUPPORT) {
>  		ret = sony_leds_init(sc);
>  		if (ret < 0)
> -- 
> 2.11.0
> 
