From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: uinput - unlock on allocation failure in ioctl
Date: Fri, 10 Nov 2017 10:22:27 -0800
Message-ID: <20171110182227.y2sqa3vtms5pn53h@dtor-ws>
References: <20171108083946.vbsixgkodhw6jh4q@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171108083946.vbsixgkodhw6jh4q@mwanda>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Wed, Nov 08, 2017 at 11:39:46AM +0300, Dan Carpenter wrote:
> We have to unlock before returning if input_allocate_device() fails.
> 
> Fixes: 04ce40a61a91 ("Input: uinput - remove uinput_allocate_device()")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied, thank you.


> 
> diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> index 7b41aad7ec27..39ddd9a73feb 100644
> --- a/drivers/input/misc/uinput.c
> +++ b/drivers/input/misc/uinput.c
> @@ -857,8 +857,10 @@ static long uinput_ioctl_handler(struct file *file, unsigned int cmd,
>  
>  	if (!udev->dev) {
>  		udev->dev = input_allocate_device();
> -		if (!udev->dev)
> -			return -ENOMEM;
> +		if (!udev->dev) {
> +			retval = -ENOMEM;
> +			goto out;
> +		}
>  	}
>  
>  	switch (cmd) {

-- 
Dmitry
