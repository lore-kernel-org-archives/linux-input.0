From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/4] Input: cyttsp - use devres managed resource
 allocations
Date: Thu, 21 Jan 2016 11:29:24 -0800
Message-ID: <20160121192924.GB39970@dtor-ws>
References: <cover.1453403916.git.oreste.salerno@tomtom.com>
 <20e9f0188f07fc420912b3defa747303be3cf290.1453403916.git.oreste.salerno@tomtom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20e9f0188f07fc420912b3defa747303be3cf290.1453403916.git.oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Oreste Salerno <oreste.salerno-Jdzig1fPfSTQT0dZR+AlfA@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, fery-+wT8y+m8/X5BDgjK7y7TUQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Hi Oreste,

On Thu, Jan 21, 2016 at 08:21:13PM +0100, Oreste Salerno wrote:
> Use devm_() functions for allocating memory, input device and IRQ.
> 

...

> @@ -625,11 +620,8 @@ EXPORT_SYMBOL_GPL(cyttsp_probe);
>  
>  void cyttsp_remove(struct cyttsp *ts)
>  {
> -	free_irq(ts->irq, ts);
> -	input_unregister_device(ts->input);
>  	if (ts->pdata->exit)
>  		ts->pdata->exit();
> -	kfree(ts);

This is not quite correct as it changes the operations order... Given
that it is going to be removed in the next patch I guess it is OK, but
ideally you can add a custom devm action to shut off the chip.

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
