From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: Input: joydev - validate axis/button maps before clobbering
 current ones
Date: Wed, 7 Oct 2015 08:46:58 +0300
Message-ID: <20151007054658.GX7289@mwanda>
References: <20151006185155.GA8997@mwanda>
 <20151006225726.545f4ce5@heffalump.sk2.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:23076 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750725AbbJGFtm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Oct 2015 01:49:42 -0400
Content-Disposition: inline
In-Reply-To: <20151006225726.545f4ce5@heffalump.sk2.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Kitt <steve@sk2.org>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-input@vger.kernel.org

Oh whoops, I sent this to the wrong person.  Javier, you introduced a
bug with 5702222c9a7a ('Input: joydev - use memdup_user() to duplicate
memory from user-space')

regards,
dan carpenter

On Tue, Oct 06, 2015 at 10:57:26PM +0200, Stephen Kitt wrote:
> Hello Dan,
> 
> On Tue, 6 Oct 2015 21:51:55 +0300, Dan Carpenter <dan.carpenter@oracle.com>
> wrote:
> > The patch 999b874f4aa3: "Input: joydev - validate axis/button maps
> > before clobbering current ones" from Aug 25, 2009, leads to the
> > following static checker warning:
> > 
> > 	drivers/input/joydev.c:466 joydev_handle_JSIOCSAXMAP()
> > 	error: 'abspam' dereferencing possible ERR_PTR()
> > 
> > drivers/input/joydev.c
> >    437  static int joydev_handle_JSIOCSAXMAP(struct joydev *joydev,
> >    438                                       void __user *argp, size_t len)
> >    439  {
> >    440          __u8 *abspam;
> >    441          int i;
> >    442          int retval = 0;
> >    443  
> >    444          len = min(len, sizeof(joydev->abspam));
> >    445  
> >    446          /* Validate the map. */
> >    447          abspam = memdup_user(argp, len);
> >    448          if (IS_ERR(abspam)) {
> >    449                  retval = PTR_ERR(abspam);
> >    450                  goto out;
> > 
> > out labels are error prone.  It's safer to return directly.
> > 
> > https://plus.google.com/106378716002406849458/posts/dnanfhQ4mHQ
> > 
> > joydev_handle_JSIOCSBTNMAP() has the same issue.
> 
> Perhaps I'm missing something here, but that's not the code I wrote, nor is
> it the code that's currently in the kernel. What I have in my copy of the
> kernel tree is
> 
>         /* Validate the map. */
>         abspam = kmalloc(len, GFP_KERNEL);
>         if (!abspam)
>                 return -ENOMEM;
> 
> which does as you recommend. If you look up the commit you're referring to
> you'll see that's also the code as I wrote it back in 2009; I'm not sure
> where your IS_ERR() and PTR_ERR() stuff is coming from.
> 
> Regards,
> 
> Stephen


