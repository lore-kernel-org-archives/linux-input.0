From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 1/7] Input: pixcir_i2c_ts: Use devres managed resource
 allocations
Date: Wed, 30 Apr 2014 09:30:41 -0700
Message-ID: <20140430163041.GB13624@core.coreip.homeip.net>
References: <1398861392-8959-1-git-send-email-rogerq@ti.com>
 <1398861392-8959-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1398861392-8959-2-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, mugunthanvnm-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Roger,

On Wed, Apr 30, 2014 at 03:36:26PM +0300, Roger Quadros wrote:

>  static int pixcir_i2c_ts_remove(struct i2c_client *client)
> @@ -198,10 +194,8 @@ static int pixcir_i2c_ts_remove(struct i2c_client *client)
>  
>  	tsdata->exiting = true;
>  	mb();
> -	free_irq(client->irq, tsdata);
>  
>  	input_unregister_device(tsdata->input);

There is no need to call input_unregister_device for managed input
devices.

> -	kfree(tsdata);
>  
>  	return 0;
>  }
> -- 
> 1.8.3.2
> 

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
