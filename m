From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: vmmouse - remove port reservation
Date: Thu, 23 Jun 2016 17:39:04 -0700
Message-ID: <20160624003904.GT32561@dtor-ws>
References: <1464715558-3343-1-git-send-email-syeh@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36525 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750874AbcFXAjN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Jun 2016 20:39:13 -0400
Content-Disposition: inline
In-Reply-To: <1464715558-3343-1-git-send-email-syeh@vmware.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sinclair Yeh <syeh@vmware.com>
Cc: "# 4 . 1-" <stable@vger.kernel.org>, linux-input@vger.kernel.org, pv-drivers@vmware.com

On Tue, May 31, 2016 at 10:25:58AM -0700, Sinclair Yeh wrote:
> The VMWare EFI BIOS will expose port 0x5658 as an ACPI resource.  This
> causes the port to be reserved by the APCI module as the system comes up,
> making it unavailable to be reserved again by other drivers, thus
> preserving this VMWare port for special use in a VMWare guest.
> 
> This port is designed to be shared among multiple VMWare services, such as
> the VMMOUSE.  Because of this, VMMOUSE should not try to reserve this port
> on its own.
> 
> The VMWare non-EFI BIOS does not do this to preserve compatibility with
> existing/legacy VMs.  It is known that there is small chance a VM may be
> configured such that these ports get reserved by other non-VMWare devices,
> and if this ever happens, the result is undefined.
> 
> Signed-off-by: Sinclair Yeh <syeh@vmware.com>
> Reviewed-by: Thomas Hellstrom <thellstrom@vmware.com>
> Cc: <stable@vger.kernel.org> # 4.1-
> Cc: linux-input@vger.kernel.org
> Cc: pv-drivers@vmware.com

Applied, thank you.

> ---
> My previous attempt at sending this might have failed.
> Resending...
> ---
>  drivers/input/mouse/vmmouse.c | 19 +------------------
>  1 file changed, 1 insertion(+), 18 deletions(-)
> 
> diff --git a/drivers/input/mouse/vmmouse.c b/drivers/input/mouse/vmmouse.c
> index a3f0f5a..8f2c408 100644
> --- a/drivers/input/mouse/vmmouse.c
> +++ b/drivers/input/mouse/vmmouse.c
> @@ -355,16 +355,10 @@ int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
>  		return -ENXIO;
>  	}
>  
> -	if (!request_region(VMMOUSE_PROTO_PORT, 4, "vmmouse")) {
> -		psmouse_dbg(psmouse, "VMMouse port in use.\n");
> -		return -EBUSY;
> -	}
> -
>  	/* Check if the device is present */
>  	response = ~VMMOUSE_PROTO_MAGIC;
>  	VMMOUSE_CMD(GETVERSION, 0, version, response, dummy1, dummy2);
>  	if (response != VMMOUSE_PROTO_MAGIC || version == 0xffffffffU) {
> -		release_region(VMMOUSE_PROTO_PORT, 4);
>  		return -ENXIO;
>  	}
>  
> @@ -374,8 +368,6 @@ int vmmouse_detect(struct psmouse *psmouse, bool set_properties)
>  		psmouse->model = version;
>  	}
>  
> -	release_region(VMMOUSE_PROTO_PORT, 4);
> -
>  	return 0;
>  }
>  
> @@ -394,7 +386,6 @@ static void vmmouse_disconnect(struct psmouse *psmouse)
>  	psmouse_reset(psmouse);
>  	input_unregister_device(priv->abs_dev);
>  	kfree(priv);
> -	release_region(VMMOUSE_PROTO_PORT, 4);
>  }
>  
>  /**
> @@ -438,15 +429,10 @@ int vmmouse_init(struct psmouse *psmouse)
>  	struct input_dev *rel_dev = psmouse->dev, *abs_dev;
>  	int error;
>  
> -	if (!request_region(VMMOUSE_PROTO_PORT, 4, "vmmouse")) {
> -		psmouse_dbg(psmouse, "VMMouse port in use.\n");
> -		return -EBUSY;
> -	}
> -
>  	psmouse_reset(psmouse);
>  	error = vmmouse_enable(psmouse);
>  	if (error)
> -		goto release_region;
> +		return error;
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
>  	abs_dev = input_allocate_device();
> @@ -502,8 +488,5 @@ init_fail:
>  	kfree(priv);
>  	psmouse->private = NULL;
>  
> -release_region:
> -	release_region(VMMOUSE_PROTO_PORT, 4);
> -
>  	return error;
>  }
> -- 
> 2.7.4
> 

-- 
Dmitry
