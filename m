From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/4] Input: elan_i2c - always output the device
 information
Date: Fri, 30 Sep 2016 16:52:49 -0700
Message-ID: <20160930235249.GA1680@dtor-ws>
References: <1475073244-23068-1-git-send-email-benjamin.tissoires@redhat.com>
 <1475073244-23068-3-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1475073244-23068-3-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: KT Liao <kt.liao@emc.com.tw>, Adrian Alves <aalves@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Sep 28, 2016 at 04:34:02PM +0200, Benjamin Tissoires wrote:
> it's always easier to retrieve these information in bug reports when
> it is always printed in the dmesg.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c b/drivers/input/mouse/elan_i2c_core.c
> index d15b338..2de1f75 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -1093,7 +1093,7 @@ static int elan_probe(struct i2c_client *client,
>  	if (error)
>  		return error;
>  
> -	dev_dbg(&client->dev,
> +	dev_info(&client->dev,
>  		"Elan Touchpad Information:\n"
>  		"    Module product ID:  0x%04x\n"
>  		"    Firmware Version:  0x%04x\n"

The format is acceptable for dev_dbg, but this multi-line output is not
too nice for normal logging, especially as we probe the device
asynchronously so there can easily be more output from other kernel
threads.

Thanks.

-- 
Dmitry
