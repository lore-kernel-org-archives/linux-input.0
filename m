From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 2/5] platform/x86: intel-vbtn: Support separate
 press/release events
Date: Thu, 9 Nov 2017 18:15:55 -0800
Message-ID: <20171110021555.GF9783@fury>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de>
 <024c7574-12f2-4708-9f90-1192856df401@rwthex-w2-a.rwth-ad.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <024c7574-12f2-4708-9f90-1192856df401@rwthex-w2-a.rwth-ad.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Stefan =?iso-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Nov 09, 2017 at 11:44:33PM +0100, Stefan Brüns wrote:
> Currently all key events use autorelease, but this forbids use as a
> modifier key.
> 
> As all event codes come in even/odd pairs, we can lookup the key type
> (KE_KEY/KE_IGNORE) for the key up event corresponding to the currently
> handled key down event. If the key up is ignored, we keep setting the
> autorelease flag for the key down.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

+Dmitry, curious for your take on this approach.

> 
> ---
> 
> Changes in v2:
> - New patch, add support for seperate key up/down in intel-vbtn
> 
>  drivers/platform/x86/intel-vbtn.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel-vbtn.c b/drivers/platform/x86/intel-vbtn.c
> index ae55be91a64b..e3f6375af85c 100644
> --- a/drivers/platform/x86/intel-vbtn.c
> +++ b/drivers/platform/x86/intel-vbtn.c
> @@ -76,14 +76,27 @@ static void notify_handler(acpi_handle handle, u32 event, void *context)
>  {
>  	struct platform_device *device = context;
>  	struct intel_vbtn_priv *priv = dev_get_drvdata(&device->dev);
> +	const struct key_entry *ke_rel;
> +	bool autorelease;
>  
>  	if (priv->wakeup_mode) {
>  		if (sparse_keymap_entry_from_scancode(priv->input_dev, event)) {
>  			pm_wakeup_hard_event(&device->dev);
>  			return;
>  		}
> -	} else if (sparse_keymap_report_event(priv->input_dev, event, 1, true)) {
> -		return;
> +	} else {
> +		/* Use the fact press/release come in even/odd pairs */
> +		if ((event & 1) && sparse_keymap_report_event(priv->input_dev,
> +							      event, 0, false))
> +			return;
> +
> +		ke_rel = sparse_keymap_entry_from_scancode(priv->input_dev,
> +							   event | 1);
> +		autorelease = !ke_rel || ke_rel->type == KE_IGNORE;
> +
> +		if (sparse_keymap_report_event(priv->input_dev, event, 1,
> +					       autorelease))
> +			return;
>  	}
>  	dev_dbg(&device->dev, "unknown event index 0x%x\n", event);
>  }
> -- 
> 2.15.0
> 
> 

-- 
Darren Hart
VMware Open Source Technology Center
