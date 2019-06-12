From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH] Input: alps: Drop unlikely before IS_ERR(_OR_NULL)
Date: Wed, 12 Jun 2019 09:14:44 +0200
Message-ID: <20190612071444.5uih6em5o73dbvtf@pali>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
 <20190605142428.84784-5-wangkefeng.wang@huawei.com>
 <20190605144240.pfrvlgxsdpacpwxf@pali>
 <36eac452-5477-3670-7980-765d0879ead4@huawei.com>
 <a1908a998b6d1d1e4cdd097a50b9c9ac9b00caae.camel@perches.com>
 <20190612005913.GJ143729@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190612005913.GJ143729@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Joe Perches <joe@perches.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Tuesday 11 June 2019 17:59:13 Dmitry Torokhov wrote:
> Hi Joe,
> 
> On Wed, Jun 05, 2019 at 07:28:53PM -0700, Joe Perches wrote:
> > On Thu, 2019-06-06 at 09:08 +0800, Kefeng Wang wrote:
> > > On 2019/6/5 22:42, Pali Rohár wrote:
> > > > On Wednesday 05 June 2019 22:24:28 Kefeng Wang wrote:
> > > > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
> > > > > so no need to do that again from its callers. Drop it.
> > > > Hi! I already reviewed this patch and rejected it, see:
> > > > https://patchwork.kernel.org/patch/10817475/
> > > OK, please ignore it.
> > 
> > I think the stated reason of better readability isn't
> > particularly sensible as the object code produced is
> > actually slightly larger.
> > 
> > x86-64 defconfig (gcc 8.3.0)
> > 
> > $ size drivers/input/mouse/alps.o*
> >    text	   data	    bss	    dec	    hex	filename
> >   29416	     56	      0	  29472	   7320	drivers/input/mouse/alps.o.new
> >   29432	     56	      0	  29488	   7330	drivers/input/mouse/alps.o.old
> 
> If gcc produces worse code for double unlikely, you should probably
> report it to gcc folks, no? Or double unlikely turns into likely?

Is measured size of stripped or unstripped binary? Plus with or without
debug symbols? Double unlikely version should have more debug symbols
and therefore also larger size.

But if unstripped version with double unlikely is larger then it is for
sure compiler bug.

-- 
Pali Rohár
pali.rohar@gmail.com
