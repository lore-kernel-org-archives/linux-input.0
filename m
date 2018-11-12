From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: atkbd: clean up indentation issue, add missing
 tab in an if statement
Date: Mon, 12 Nov 2018 11:41:51 -0800
Message-ID: <20181112194151.GG192687@dtor-ws>
References: <20181101151224.14840-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181101151224.14840-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Nov 01, 2018 at 03:12:24PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to clean up indentation issues, add missing tab
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/atkbd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 7e75835e220f..850bb259c20e 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -841,7 +841,7 @@ static int atkbd_select_set(struct atkbd *atkbd, int target_set, int allow_extra
>  	if (param[0] != 3) {
>  		param[0] = 2;
>  		if (ps2_command(ps2dev, param, ATKBD_CMD_SSCANSET))
> -		return 2;
> +			return 2;
>  	}
>  
>  	ps2_command(ps2dev, param, ATKBD_CMD_SETALL_MBR);
> -- 
> 2.19.1
> 

-- 
Dmitry
