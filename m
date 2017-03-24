From: Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v2] Docs: Input: initial uinput documentation
Date: Fri, 24 Mar 2017 15:17:03 -0600
Message-ID: <20170324151703.6b3dab37@lwn.net>
References: <20170324033502.17398-1-marcos.souza.org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ms.lwn.net ([45.79.88.28]:58828 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966793AbdCXVRN (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Mar 2017 17:17:13 -0400
In-Reply-To: <20170324033502.17398-1-marcos.souza.org@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Cc: linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, benjamin.tissoires@redhat.com, peter.hutterer@who-t.net

On Fri, 24 Mar 2017 00:34:58 -0300
Marcos Paulo de Souza <marcos.souza.org@gmail.com> wrote:

> this is the second iteration of this patch. The first version can be checked
> here[1]. A special thanks to Peter Hutterer who dug the last patch and suggested
> a lot of changes , hopefully, all addressed in this version.

This seems like a good start.  Of course, I have a couple of comments...

1) RST documentation is good, but it really needs to be hooked into the
   docs build with the rest.  In this case, it needs to go into the
   application developer's manual.  The only slight snag is ... well ...
   that manual doesn't quite exist yet.  Once this is ready, if it comes
   through me tree, I can follow it with a patch creating that manual and
   moving this section into it.

2) We don't normally put in section numbers manually in RST documents,
   since Sphinx will do that for us.

3) Section 3.0 covers the old interface.  I'm not sure we need that in 
   documentation in current kernels which, by definition, have the
   current interface.

Thanks,

jon
