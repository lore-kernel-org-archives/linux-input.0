From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: synaptics-rmi4: Clean up redundant check
Date: Mon, 9 Oct 2017 10:39:46 -0700
Message-ID: <20171009173946.GB19253@dtor-ws>
References: <1507501611-16703-1-git-send-email-chris.gekas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1507501611-16703-1-git-send-email-chris.gekas@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Christos Gkekas <chris.gekas@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Sun, Oct 08, 2017 at 11:26:51PM +0100, Christos Gkekas wrote:
> Variable size_presence_reg·is unsigned so checking whether it is less
> than zero is redundant.
> 
> Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>

I'd rather we kept the check as it documents the valid range of values.

> ---
>  drivers/input/rmi4/rmi_driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_driver.c b/drivers/input/rmi4/rmi_driver.c
> index 4f2bb59..68fcb30 100644
> --- a/drivers/input/rmi4/rmi_driver.c
> +++ b/drivers/input/rmi4/rmi_driver.c
> @@ -601,7 +601,7 @@ int rmi_read_register_desc(struct rmi_device *d, u16 addr,
>  		return ret;
>  	++addr;
>  
> -	if (size_presence_reg < 0 || size_presence_reg > 35)
> +	if (size_presence_reg > 35)
>  		return -EIO;
>  
>  	memset(buf, 0, sizeof(buf));
> -- 
> 2.7.4
> 

Thanks.

-- 
Dmitry
