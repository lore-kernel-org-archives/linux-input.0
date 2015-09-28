From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: serio - fix blocking of parport
Date: Sun, 27 Sep 2015 17:18:08 -0700
Message-ID: <20150928001808.GA17818@dtor-ws>
References: <1443273801-8822-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:35755 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753398AbbI1ASM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 27 Sep 2015 20:18:12 -0400
Content-Disposition: inline
In-Reply-To: <1443273801-8822-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, stable@vger.kernel.org

On Sat, Sep 26, 2015 at 06:53:21PM +0530, Sudip Mukherjee wrote:
> If parkbd_allocate_serio() fails to allocate memory we are releasing the
> parport but we missed unregistering the device. As a result this device
> with exclusive access to that parport remains registered. And no other
> device will be able to use that parport even though this driver has
> failed to load.
> 
> Cc: <stable@vger.kernel.org> # 2.6.32+
> Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>

Applied, but I dropped stable annotation - since noone complained about
this and the issue is in error path that is unlikely anyway, I do not
think we need to bother stable guys with it.

Thanks!

> ---
> 
> Faced this problem while creating the patch series for input to use
> parallel port device model.
> 
>  drivers/input/serio/parkbd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/serio/parkbd.c b/drivers/input/serio/parkbd.c
> index 26b4593..1e8cd6f 100644
> --- a/drivers/input/serio/parkbd.c
> +++ b/drivers/input/serio/parkbd.c
> @@ -194,6 +194,7 @@ static int __init parkbd_init(void)
>  	parkbd_port = parkbd_allocate_serio();
>  	if (!parkbd_port) {
>  		parport_release(parkbd_dev);
> +		parport_unregister_device(parkbd_dev);
>  		return -ENOMEM;
>  	}
>  
> -- 
> 1.9.1
> 

-- 
Dmitry
