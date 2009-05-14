From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] TSC2007: private data for platform callbacks.
Date: Thu, 14 May 2009 12:37:31 +0200
Message-ID: <20090514103731.GA23814@roarinelk.homelinux.net>
References: <20090514100909.GA23626@roarinelk.homelinux.net> <5d5443650905140328v319e673o2f7b865e21619486@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754551AbZENKho@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5d5443650905140328v319e673o2f7b865e21619486@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Trilok Soni <soni.trilok@gmail.com>
Cc: Kwangwoo Lee <kwlee@mtekvision.com>, linux-kernel@vger.kernel.org, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Trilok,

On Thu, May 14, 2009 at 03:58:19PM +0530, Trilok Soni wrote:
> CCing linux-input mailing list, so not deleting any code from this
> e-mail while replying.
> 
> On Thu, May 14, 2009 at 3:39 PM, Manuel Lauss
> <mano@roarinelk.homelinux.net> wrote:
> > Add a private data field to the tsc2007 platform data and pass this
> > to the callbacks.
> 
> I hope that you have created this patch on top of two recently posted
> patches by Kwangwoo Lee
> to merge changes from Thierry.

No; it's against Linux's git. Will rediff.


 
> > - ? ? ? int ? ? ? ? ? ? ? ? ? ? (*get_pendown_state)(void);
> > - ? ? ? void ? ? ? ? ? ? ? ? ? ?(*clear_penirq)(void);
> > + ? ? ? struct tsc2007_platform_data *pd;
> > ?};
> >
> > +/* ask platform for pendown state */
> > +static inline int ts_get_pendown_state(struct tsc2007 *ts)
> > +{
> > + ? ? ? return ts->pd->get_pendown_state(ts->pd->priv);
> 
> So, we don't need check here, like this:
> 
> if (ts->pd->get_pendown_state)
>           ret =  ts->pd->get_pendown_state(ts->pd->priv);

The driver doesn't work right without that callback so the check
in here is kind of pointless. Better to check for it in the
probe function and refuse to probe if it isn't there.  All other
callbacks seem optional to me.

 
> > ? ? ? ?struct tsc2007 *ts;
> > - ? ? ? struct tsc2007_platform_data *pdata = pdata = client->dev.platform_data;
> > + ? ? ? struct tsc2007_platform_data *pdata = client->dev.platform_data;
> 
> This change shows that you need to rebase based on two patches
> submitted by Lee recently.

Ah, that shouldn't be in there in the first place.

Thanks!
	Manuel Lauss
