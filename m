From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] Input: colibri-vf50-ts: fix implicit declaration
Date: Wed, 10 Feb 2016 15:34:16 +0530
Message-ID: <20160210100416.GA8872@sudip-pc>
References: <1455097547-31053-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAMuHMdVViFX+0Wi_LBFsjFStEZnX1XNG-n8tj6qug3mSioySag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdVViFX+0Wi_LBFsjFStEZnX1XNG-n8tj6qug3mSioySag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: kernel-testers-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Sanchayan Maity <maitysanchayan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, kernel-testers-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

On Wed, Feb 10, 2016 at 10:54:45AM +0100, Geert Uytterhoeven wrote:
> On Wed, Feb 10, 2016 at 10:45 AM, Sudip Mukherjee
> <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > The build of m32r allmodconfig fails with the error:
> > drivers/input/touchscreen/colibri-vf50-ts.c:302:10: error: implicit
> >         declaration of function 'of_property_read_u32'
> >
> > of_property_read_u32() is defined in linux/of.h which was not included.
> >
> > Fixes: 1261d013daea ("Input: Allow compile test of Goodix and Colibri VF50 if !GPIOLIB")
> 
> Actually I had sent the exact same patch to add this missing include,
> to apply before 1261d013daea, but it seems Dmitry only applied the
> second one.
> 
> http://permalink.gmane.org/gmane.linux.kernel.gpio/14086

apart from m32r it also affects tilegx, s390, m68k allmodconfig.
I hope Dmitry applies any one from your or mine patch today.

regards
sudip
