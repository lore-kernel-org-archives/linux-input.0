From: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] Input: add support for the STMicroelectronics
 FingerTip touchscreen
Date: Wed, 26 Apr 2017 17:39:18 -0700
Message-ID: <20170427003918.GA1236@dtor-glaptop>
References: <20170327130743.27783-1-andi.shyti@samsung.com>
 <CGME20170327130756epcas1p321726d525c31814c3f76895b895739cd@epcas1p3.samsung.com>
 <20170327130743.27783-3-andi.shyti@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170327130743.27783-3-andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andi Shyti <andi.shyti-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andi Shyti <andi-ahk0KpmfxKRAfugRpC6u6w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Andi,

Quick question:

On Mon, Mar 27, 2017 at 10:07:43PM +0900, Andi Shyti wrote:
> +static irqreturn_t stmfts_irq_handler(int irq, void *dev)
> +{
> +	struct stmfts_data *sdata = dev;
> +	int ret;
> +
> +	mutex_lock(&sdata->mutex);
> +	ret = i2c_smbus_read_i2c_block_data(sdata->client,
> +						STMFTS_READ_ONE_EVENT,
> +						STMFTS_EVENT_SIZE, sdata->data);
> +
> +	if (ret < 0 || ret != STMFTS_EVENT_SIZE)
> +		goto exit;

Why do we split read into 2 chunks? Can we issue STMFTS_READ_ALL_EVENT
right away instead of reading first event, analyzing it, and then (maybe)
fetching the rest?

Also, why do we use smbus protocol for the first event and i2c for the
rest?

Thanks.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
