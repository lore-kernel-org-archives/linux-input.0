From: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: hyperv-keyboard: Use in-place iterator API in the
 channel callback
Date: Mon, 19 Aug 2019 20:18:05 -0700
Message-ID: <20190820031805.GO121898@dtor-ws>
References: <1566270066-27546-1-git-send-email-decui@microsoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1566270066-27546-1-git-send-email-decui@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dexuan Cui <decui@microsoft.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>, Sasha Levin <Alexander.Levin@microsoft.com>, "sashal@kernel.org" <sashal@kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, KY Srinivasan <kys@microsoft.com>, Michael Kelley <mikelley@microsoft.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

On Tue, Aug 20, 2019 at 03:01:23AM +0000, Dexuan Cui wrote:
> Simplify the ring buffer handling with the in-place API.
> 
> Also avoid the dynamic allocation and the memory leak in the channel
> callback function.
> 
> Signed-off-by: Dexuan Cui <decui@microsoft.com>
> ---
> 
> Hi Dmitry, can this patch go through Sasha's hyperv tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
> 
> This is a purely Hyper-V specific change.

Sure, no problem.

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

> 
>  drivers/input/serio/hyperv-keyboard.c | 35 ++++++-----------------------------
>  1 file changed, 6 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 88ae7c2..e486a8a 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -237,40 +237,17 @@ static void hv_kbd_handle_received_packet(struct hv_device *hv_dev,
>  
>  static void hv_kbd_on_channel_callback(void *context)
>  {
> +	struct vmpacket_descriptor *desc;
>  	struct hv_device *hv_dev = context;
> -	void *buffer;
> -	int bufferlen = 0x100; /* Start with sensible size */
>  	u32 bytes_recvd;
>  	u64 req_id;
> -	int error;
>  
> -	buffer = kmalloc(bufferlen, GFP_ATOMIC);
> -	if (!buffer)
> -		return;
> -
> -	while (1) {
> -		error = vmbus_recvpacket_raw(hv_dev->channel, buffer, bufferlen,
> -					     &bytes_recvd, &req_id);
> -		switch (error) {
> -		case 0:
> -			if (bytes_recvd == 0) {
> -				kfree(buffer);
> -				return;
> -			}
> -
> -			hv_kbd_handle_received_packet(hv_dev, buffer,
> -						      bytes_recvd, req_id);
> -			break;
> +	foreach_vmbus_pkt(desc, hv_dev->channel) {
> +		bytes_recvd = desc->len8 * 8;
> +		req_id = desc->trans_id;
>  
> -		case -ENOBUFS:
> -			kfree(buffer);
> -			/* Handle large packet */
> -			bufferlen = bytes_recvd;
> -			buffer = kmalloc(bytes_recvd, GFP_ATOMIC);
> -			if (!buffer)
> -				return;
> -			break;
> -		}
> +		hv_kbd_handle_received_packet(hv_dev, desc, bytes_recvd,
> +					      req_id);
>  	}
>  }
>  
> -- 
> 1.8.3.1
> 

-- 
Dmitry
