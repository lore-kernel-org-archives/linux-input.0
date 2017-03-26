From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH v2] Docs: Input: initial uinput documentation
Date: Mon, 27 Mar 2017 09:08:50 +1000
Message-ID: <20170326230850.GB14405@jelly>
References: <20170324033502.17398-1-marcos.souza.org@gmail.com>
 <20170324151703.6b3dab37@lwn.net>
 <20170326164106.GB2267@xfiles.domain.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:27836 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751721AbdCZXJE (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 26 Mar 2017 19:09:04 -0400
Content-Disposition: inline
In-Reply-To: <20170326164106.GB2267@xfiles.domain.name>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com

On Sun, Mar 26, 2017 at 01:41:08PM -0300, Marcos Paulo de Souza wrote:
> Hi Jon,
> 
> On Fri, Mar 24, 2017 at 03:17:03PM -0600, Jonathan Corbet wrote:
> > On Fri, 24 Mar 2017 00:34:58 -0300
> > Marcos Paulo de Souza <marcos.souza.org@gmail.com> wrote:
> > 
> > > this is the second iteration of this patch. The first version can be checked
> > > here[1]. A special thanks to Peter Hutterer who dug the last patch and suggested
> > > a lot of changes , hopefully, all addressed in this version.
> > 
> > This seems like a good start.  Of course, I have a couple of comments...
> > 
> > 1) RST documentation is good, but it really needs to be hooked into the
> >    docs build with the rest.  In this case, it needs to go into the
> >    application developer's manual.  The only slight snag is ... well ...
> >    that manual doesn't quite exist yet.  Once this is ready, if it comes
> >    through me tree, I can follow it with a patch creating that manual and
> >    moving this section into it.
> 
> Sounds good. If you want, I can verify and add this new page as well.
> 
> > 
> > 2) We don't normally put in section numbers manually in RST documents,
> >    since Sphinx will do that for us.
> 
> Great, fixed here.
> 
> > 
> > 3) Section 3.0 covers the old interface.  I'm not sure we need that in 
> >    documentation in current kernels which, by definition, have the
> >    current interface.
> 
> Currently both interces can be used in mainline, but this can be nice to have for users
> who still run older kernels. But I can remove if you strongly disagree.

Given the kernel's policy for retiring interfaces, the old interface will be
available forever. But at this point you shouldn't be writing new software
against the old interface.

Cheers,
   Peter
