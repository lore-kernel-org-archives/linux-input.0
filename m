From: "Guan Xuetao" <guanxuetao@mprc.pku.edu.cn>
Subject: RE: [PATCH] i8042 driver for unicore32 architecture
Date: Tue, 18 Jan 2011 12:45:06 +0800
Message-ID: <012501cbb6ca$7a48ee00$6edaca00$@mprc.pku.edu.cn>
References: <005b01cbb594$6398d9e0$2aca8da0$@mprc.pku.edu.cn> <20110117173932.GB15404@core.coreip.homeip.net> <00fd01cbb6c0$327510e0$975f32a0$@mprc.pku.edu.cn> <20110118041111.GA23678@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mprc.pku.edu.cn ([162.105.203.9]:41609 "EHLO mprc.pku.edu.cn"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab1AREpJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Jan 2011 23:45:09 -0500
In-Reply-To: <20110118041111.GA23678@core.coreip.homeip.net>
Content-Language: zh-cn
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com]
> Sent: Tuesday, January 18, 2011 12:11 PM
> To: Guan Xuetao
> Cc: linux-input@vger.kernel.org
> Subject: Re: [PATCH] i8042 driver for unicore32 architecture
> 
> On Tue, Jan 18, 2011 at 11:31:30AM +0800, Guan Xuetao wrote:
> > > > diff --git a/drivers/staging/puv3/i8042-ucio.h b/drivers/staging/puv3/i8042-ucio.h
> > > > new file mode 100644
> > > > index 0000000..c3221df
> > > > --- /dev/null
> > > > +++ b/drivers/staging/puv3/i8042-ucio.h
> > > > @@ -0,0 +1,89 @@
> > > > +/*
> > > > + * linux/drivers/staging/puv3/i8042-ucio.h
> > >
> > > Please do not put filenames in the comments.
> > That's ok.
> > But why?
> 
> Because:
> 
> 1. It does not convey any additional information - your editor is sure
> capable of displaying the filename associated with a buffer, and
> 
> 2. It is one more thing that needs updating if you decide to move/rename
> the file.
I see.

> 
> > > > +
> > > > +static inline int i8042_platform_init(void)
> > > > +{
> > > > +/*
> > > > + * On some platforms touching the i8042 data register region can do really
> > > > + * bad things. Because of this the region is always reserved on such boxes.
> > > > + */
> > >
> > > The comment is in wrong place and is not applicable to your arch I
> > > think.
> > Ok, removed. Request_region and release_region are also removed.
> 
> So are the regions reserved elsewhere? Might be a good idea to note this
> fact.
Not reserved. I think it unnecessary, since in unicore32,  user application can't acess
io space directly.

> 
> Thanks.
> 
> --
> Dmitry
Thanks

Guan Xuetao

