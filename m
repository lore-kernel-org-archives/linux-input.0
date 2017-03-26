From: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Subject: Re: [PATCH v2] Docs: Input: initial uinput documentation
Date: Sun, 26 Mar 2017 13:41:08 -0300
Message-ID: <20170326164106.GB2267@xfiles.domain.name>
References: <20170324033502.17398-1-marcos.souza.org@gmail.com>
 <20170324151703.6b3dab37@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170324151703.6b3dab37@lwn.net>
Sender: linux-doc-owner@vger.kernel.org
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, peter.hutterer@who-t.net
List-Id: linux-input@vger.kernel.org

Hi Jon,

On Fri, Mar 24, 2017 at 03:17:03PM -0600, Jonathan Corbet wrote:
> On Fri, 24 Mar 2017 00:34:58 -0300
> Marcos Paulo de Souza <marcos.souza.org@gmail.com> wrote:
> 
> > this is the second iteration of this patch. The first version can be checked
> > here[1]. A special thanks to Peter Hutterer who dug the last patch and suggested
> > a lot of changes , hopefully, all addressed in this version.
> 
> This seems like a good start.  Of course, I have a couple of comments...
> 
> 1) RST documentation is good, but it really needs to be hooked into the
>    docs build with the rest.  In this case, it needs to go into the
>    application developer's manual.  The only slight snag is ... well ...
>    that manual doesn't quite exist yet.  Once this is ready, if it comes
>    through me tree, I can follow it with a patch creating that manual and
>    moving this section into it.

Sounds good. If you want, I can verify and add this new page as well.

> 
> 2) We don't normally put in section numbers manually in RST documents,
>    since Sphinx will do that for us.

Great, fixed here.

> 
> 3) Section 3.0 covers the old interface.  I'm not sure we need that in 
>    documentation in current kernels which, by definition, have the
>    current interface.

Currently both interces can be used in mainline, but this can be nice to have for users
who still run older kernels. But I can remove if you strongly disagree.

> 
> Thanks,
> 
> jon

Thanks for the revision!

-- 
Thanks,
	Marcos
