From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v5 3/3] Input: xen-kbdfront - allow better run-time
 configuration
Date: Tue, 12 Jun 2018 15:07:22 -0700
Message-ID: <20180612220722.GA38773@dtor-ws>
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-4-andr2000@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180612074856.28451-4-andr2000@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Oleksandr Andrushchenko <andr2000@gmail.com>
Cc: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, jgross@suse.com, lyan@suse.com, boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, andrii_chepurnyi@epam.com, Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
List-Id: linux-input@vger.kernel.org

On Tue, Jun 12, 2018 at 10:48:56AM +0300, Oleksandr Andrushchenko wrote:
>  
> +	if (!(with_kbd | with_ptr | with_mtouch)) {

I changed this to logical "OR" and applied, thank you.

> +		ret = -ENXIO;
> +		goto error;
> +	}
> +
>  	ret = xenkbd_connect_backend(dev, info);
>  	if (ret < 0)
>  		goto error;
> -- 
> 2.17.1
> 

-- 
Dmitry
