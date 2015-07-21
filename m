From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v1 7/7] input: cyapa: add CYAP0002 Gen6 device for ACPI
 configuration
Date: Mon, 20 Jul 2015 17:17:17 -0700
Message-ID: <20150721001717.GG15528@dtor-ws>
References: <1434358897-24668-1-git-send-email-dudl@cypress.com>
 <1434358897-24668-8-git-send-email-dudl@cypress.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1434358897-24668-8-git-send-email-dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, bleung-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, jmmahler-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On Mon, Jun 15, 2015 at 05:01:37PM +0800, Dudley Du wrote:
> Add CYTP0002 name for Gen6 device for ACPI configuration
> TEST=test on Chromebook.
> 
> Signed-off-by: Dudley Du <dudl-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org>

Applied, thank you.

> ---
>  drivers/input/mouse/cyapa.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/mouse/cyapa.c b/drivers/input/mouse/cyapa.c
> index 7b6d6d4..7f674aa 100644
> --- a/drivers/input/mouse/cyapa.c
> +++ b/drivers/input/mouse/cyapa.c
> @@ -1558,6 +1558,7 @@ MODULE_DEVICE_TABLE(i2c, cyapa_id_table);
>  static const struct acpi_device_id cyapa_acpi_id[] = {
>  	{ "CYAP0000", 0 },  /* Gen3 trackpad with 0x67 I2C address. */
>  	{ "CYAP0001", 0 },  /* Gen5 trackpad with 0x24 I2C address. */
> +	{ "CYAP0002", 0 },  /* Gen6 trackpad with 0x24 I2C address. */
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(acpi, cyapa_acpi_id);
> -- 
> 1.9.1
> 
> 
> ---------------------------------------------------------------
> This message and any attachments may contain Cypress (or its
> subsidiaries) confidential information. If it has been received
> in error, please advise the sender and immediately delete this
> message.
> ---------------------------------------------------------------
> 

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
