From: "Luis R. Rodriguez" <mcgrof@suse.com>
Subject: Re: [PATCH] Input: i8042 - force synchronous probing of PNP drivers
Date: Fri, 16 Dec 2016 09:56:24 +0100
Message-ID: <20161216085624.GJ13946@wotan.suse.de>
References: <20161213175632.GA12528@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33345 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934098AbcLPI4Z (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 16 Dec 2016 03:56:25 -0500
Content-Disposition: inline
In-Reply-To: <20161213175632.GA12528@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Marcos Paulo de Souza <marcos.souza.org@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, linux-kernel@vger.kernel.org

On Tue, Dec 13, 2016 at 09:56:32AM -0800, Dmitry Torokhov wrote:
> We rely on the result of scanning PNP bus for keyboard and mouse devices to
> decide whether we should continue initialization of i8042 driver or not, so
> the probes can not be asynchronous.

Can initializing of i8042 driver happen using a wait for completion ?
If so I'd be happy for the sort of change going in first and then a fix
to enable it so that others can rely on it as an example of how to shy
away from the temporary async probe blacklist.

And is there any grammatical expression which can be used to hunt for similar
types of incompatibilities with async probe ? I'm wondering if one can hunt
for them using for instance Coccinelle SmPL grammar

> Also, it is not a good idea to unbind either of the PNP devices while i8042
> is running, so let's disable bind/unbind for the PNP drivers through sysfs
> and rely on i8042 cleaning after itself properly. User can still unbind and
> rebind entire i8042 and that will take care of PNP drivers as well.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Otherwise:

Reviewed-by: Luis R. Rodriguez <mgrof@kernel.org>

  Luis
> ---
>  drivers/input/serio/i8042-x86ia64io.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/input/serio/i8042-x86ia64io.h b/drivers/input/serio/i8042-x86ia64io.h
> index 2503d01..79daea84 100644
> --- a/drivers/input/serio/i8042-x86ia64io.h
> +++ b/drivers/input/serio/i8042-x86ia64io.h
> @@ -925,6 +925,10 @@ static struct pnp_driver i8042_pnp_kbd_driver = {
>  	.name           = "i8042 kbd",
>  	.id_table       = pnp_kbd_devids,
>  	.probe          = i8042_pnp_kbd_probe,
> +	.driver         = {
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> +		.suppress_bind_attrs = true,
> +	},
>  };
>  
>  static struct pnp_device_id pnp_aux_devids[] = {
> @@ -947,6 +951,10 @@ static struct pnp_driver i8042_pnp_aux_driver = {
>  	.name           = "i8042 aux",
>  	.id_table       = pnp_aux_devids,
>  	.probe          = i8042_pnp_aux_probe,
> +	.driver         = {
> +		.probe_type = PROBE_FORCE_SYNCHRONOUS,
> +		.suppress_bind_attrs = true,
> +	},
>  };
>  
>  static void i8042_pnp_exit(void)
> -- 
> 2.8.0.rc3.226.g39d4020
> 
> 
> -- 
> Dmitry
> 

-- 
Luis Rodriguez, SUSE LINUX GmbH
Maxfeldstrasse 5; D-90409 Nuernberg
