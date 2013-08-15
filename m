From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 28/29] drivers/input/{keyboard,serio}: simplify use of
 devm_ioremap_resource
Date: Thu, 15 Aug 2013 00:09:36 -0700
Message-ID: <20130815070936.GB15691@core.coreip.homeip.net>
References: <1376478213-24091-1-git-send-email-Julia.Lawall@lip6.fr>
 <CAOh2x=muvdm+tSR+ucUWLhb1vOvXB=_+vm_v9fHfa6mHUnhRRw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:54071 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765Ab3HOHJj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 15 Aug 2013 03:09:39 -0400
Content-Disposition: inline
In-Reply-To: <CAOh2x=muvdm+tSR+ucUWLhb1vOvXB=_+vm_v9fHfa6mHUnhRRw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, spear-devel <spear-devel@list.st.com>

On Wed, Aug 14, 2013 at 04:51:02PM +0530, Viresh Kumar wrote:
> On Wed, Aug 14, 2013 at 4:33 PM, Julia Lawall <Julia.Lawall@lip6.fr> wrote:
> > From: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > Remove unneeded error handling on the result of a call to
> > platform_get_resource when the value is passed to devm_ioremap_resource.
> >
> > Move the call to platform_get_resource adjacent to the call to
> > devm_ioremap_resource to make the connection between them more clear.
> >
> > A simplified version of the semantic patch that makes this change is as
> > follows: (http://coccinelle.lip6.fr/)
> >
> > // <smpl>
> > @@
> > expression pdev,res,n,e,e1;
> > expression ret != 0;
> > identifier l;
> > @@
> >
> > - res = platform_get_resource(pdev, IORESOURCE_MEM, n);
> >   ... when != res
> > - if (res == NULL) { ... \(goto l;\|return ret;\) }
> >   ... when != res
> > + res = platform_get_resource(pdev, IORESOURCE_MEM, n);
> >   e = devm_ioremap_resource(e1, res);
> > // </smpl>
> >
> > Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>
> >
> > ---
> 
> >  drivers/input/keyboard/spear-keyboard.c |    7 +------
> 
> For SPEAr:
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks, applied.

-- 
Dmitry
