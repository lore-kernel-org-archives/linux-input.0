From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] Input: alps: Drop unlikely before IS_ERR(_OR_NULL)
Date: Wed, 05 Jun 2019 19:28:53 -0700
Message-ID: <a1908a998b6d1d1e4cdd097a50b9c9ac9b00caae.camel@perches.com>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
         <20190605142428.84784-5-wangkefeng.wang@huawei.com>
         <20190605144240.pfrvlgxsdpacpwxf@pali>
         <36eac452-5477-3670-7980-765d0879ead4@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36eac452-5477-3670-7980-765d0879ead4@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kefeng Wang <wangkefeng.wang@huawei.com>, Pali =?ISO-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, 2019-06-06 at 09:08 +0800, Kefeng Wang wrote:
> On 2019/6/5 22:42, Pali Rohár wrote:
> > On Wednesday 05 June 2019 22:24:28 Kefeng Wang wrote:
> > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag,
> > > so no need to do that again from its callers. Drop it.
> > Hi! I already reviewed this patch and rejected it, see:
> > https://patchwork.kernel.org/patch/10817475/
> OK, please ignore it.

I think the stated reason of better readability isn't
particularly sensible as the object code produced is
actually slightly larger.

x86-64 defconfig (gcc 8.3.0)

$ size drivers/input/mouse/alps.o*
   text	   data	    bss	    dec	    hex	filename
  29416	     56	      0	  29472	   7320	drivers/input/mouse/alps.o.new
  29432	     56	      0	  29488	   7330	drivers/input/mouse/alps.o.old

Also if this unlikely is _really_ useful, perhaps the
!IS_ERR immediately after could also use likely as the
test seems only done for an OOM condition.

> > > Cc: "Pali Rohár" <pali.rohar@gmail.com>
> > > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > Cc: linux-input@vger.kernel.org
> > > Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > ---
> > >  drivers/input/mouse/alps.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
> > > index 0a6f7ca883e7..791ef0f826c5 100644
> > > --- a/drivers/input/mouse/alps.c
> > > +++ b/drivers/input/mouse/alps.c
> > > @@ -1478,7 +1478,7 @@ static void alps_report_bare_ps2_packet(struct psmouse *psmouse,
> > >  		/* On V2 devices the DualPoint Stick reports bare packets */
> > >  		dev = priv->dev2;
> > >  		dev2 = psmouse->dev;
> > > -	} else if (unlikely(IS_ERR_OR_NULL(priv->dev3))) {
> > > +	} else if (IS_ERR_OR_NULL(priv->dev3)) {
> > >  		/* Register dev3 mouse if we received PS/2 packet first time */
> > >  		if (!IS_ERR(priv->dev3))
> > >  			psmouse_queue_work(psmouse, &priv->dev3_register_work,
