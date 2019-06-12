From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: alps: Drop unlikely before IS_ERR(_OR_NULL)
Date: Tue, 11 Jun 2019 17:59:13 -0700
Message-ID: <20190612005913.GJ143729@dtor-ws>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
 <20190605142428.84784-5-wangkefeng.wang@huawei.com>
 <20190605144240.pfrvlgxsdpacpwxf@pali>
 <36eac452-5477-3670-7980-765d0879ead4@huawei.com>
 <a1908a998b6d1d1e4cdd097a50b9c9ac9b00caae.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a1908a998b6d1d1e4cdd097a50b9c9ac9b00caae.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Joe,

On Wed, Jun 05, 2019 at 07:28:53PM -0700, Joe Perches wrote:
> On Thu, 2019-06-06 at 09:08 +0800, Kefeng Wang wrote:
> > On 2019/6/5 22:42, Pali Rohár wrote:
> > > On Wednesday 05 June 2019 22:24:28 Kefeng Wang wrote:
> > > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
> > > > so no need to do that again from its callers. Drop it.
> > > Hi! I already reviewed this patch and rejected it, see:
> > > https://patchwork.kernel.org/patch/10817475/
> > OK, please ignore it.
> 
> I think the stated reason of better readability isn't
> particularly sensible as the object code produced is
> actually slightly larger.
> 
> x86-64 defconfig (gcc 8.3.0)
> 
> $ size drivers/input/mouse/alps.o*
>    text	   data	    bss	    dec	    hex	filename
>   29416	     56	      0	  29472	   7320	drivers/input/mouse/alps.o.new
>   29432	     56	      0	  29488	   7330	drivers/input/mouse/alps.o.old

If gcc produces worse code for double unlikely, you should probably
report it to gcc folks, no? Or double unlikely turns into likely?

> 
> Also if this unlikely is _really_ useful, perhaps the
> !IS_ERR immediately after could also use likely as the
> test seems only done for an OOM condition.

No, once you take the IS_ERR_OR_NULL(priv->dev3) == true branch it stops
being hot path and additional annotations are completely unneeded.

And if we failed to create and register priv->dev3 device - that's an
error and system is degraded. Can't do much here.

Thanks.

-- 
Dmitry
