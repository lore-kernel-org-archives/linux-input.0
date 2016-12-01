From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] HID: intel_ish-hid: use %pUL for uuid formatting
Date: Thu, 1 Dec 2016 15:21:10 +0100
Message-ID: <20161201142110.GB1280@mail.corp.redhat.com>
References: <1480546127-3539-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1480546127-3539-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Nov 30 2016 or thereabouts, Rasmus Villemoes wrote:
> We have the %pU printf extension for doing exactly this. Saves some
> .text, and is likely also a little faster.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

> ---
>  drivers/hid/intel-ish-hid/ishtp/bus.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/intel-ish-hid/ishtp/bus.c b/drivers/hid/intel-ish-hid/ishtp/bus.c
> index 256521509d20..f4cbc744e657 100644
> --- a/drivers/hid/intel-ish-hid/ishtp/bus.c
> +++ b/drivers/hid/intel-ish-hid/ishtp/bus.c
> @@ -585,14 +585,7 @@ int ishtp_bus_new_client(struct ishtp_device *dev)
>  	 */
>  	i = dev->fw_client_presentation_num - 1;
>  	device_uuid = dev->fw_clients[i].props.protocol_name;
> -	dev_name = kasprintf(GFP_KERNEL,
> -		"{%02X%02X%02X%02X-%02X%02X-%02X%02X-%02X%02X-%02X%02X%02X%02X%02X%02X}",
> -		device_uuid.b[3], device_uuid.b[2], device_uuid.b[1],
> -		device_uuid.b[0], device_uuid.b[5], device_uuid.b[4],
> -		device_uuid.b[7], device_uuid.b[6], device_uuid.b[8],
> -		device_uuid.b[9], device_uuid.b[10], device_uuid.b[11],
> -		device_uuid.b[12], device_uuid.b[13], device_uuid.b[14],
> -		device_uuid.b[15]);
> +	dev_name = kasprintf(GFP_KERNEL, "{%pUL}", device_uuid.b);
>  	if (!dev_name)
>  		return	-ENOMEM;
>  
> -- 
> 2.1.4
> 
