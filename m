From: Michal Marek <mmarek@suse.cz>
Subject: Re: [PATCH -next] hid-example: fix some build issues
Date: Tue, 19 Apr 2011 11:13:29 +0200
Message-ID: <20110419091329.GB13661@sepie.suse.cz>
References: <201104142149.p3ELnnoF008424@imap1.linux-foundation.org>
 <20110418111251.8a922b6b.randy.dunlap@oracle.com>
 <alpine.LNX.2.00.1104191047090.12035@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53601 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753344Ab1DSJNc (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2011 05:13:32 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1104191047090.12035@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Alan Ott <alan@signal11.us>

On Tue, Apr 19, 2011 at 10:48:26AM +0200, Jiri Kosina wrote:
> 
> [ adding Michal Marek to CC ]
> 
> On Mon, 18 Apr 2011, Randy Dunlap wrote:
> 
> > From: Randy Dunlap <randy.dunlap@oracle.com>
> > 
> > samples/hid-example.o needs some Kconfig and Makefile additions
> > in order to build.  It should use <linux/*.h> headers from
> > the build tree, so use HEADERS_CHECK to require that those
> > header files be present.
> > 
> > Change the kconfig symbol from tristate to bool since
> > userspace cannot be built as loadable modules.
> > 
> > However, I don't understand why the userspace header files are
> > not present as reported in Andrew's build log, since it builds
> > OK on x86_64 without any of these changes.
> 
> Yes, I have no idea how the build failure Andrew is reporting happens. 
> Andrew -- what exact command are you using that leads to that failure?

I believe Andrew was trying to build samples/hidraw/hid-example.o
directly, which unfortunatelly does not work (kbuild limitation). For
reference, this is the reply I sent privately to Andrew:

| The samples/hidraw/ directory does not appear in the output, I I guess 
| samples/hidraw/hid-example already existed? Back to the original 
| problem, I can reproduce the bug with
| 
| $ make  samples/hidraw/hid-example.o
|    CHK     include/linux/version.h
|    CHK     include/generated/utsrelease.h
|    CALL    scripts/checksyscalls.sh
|    CC      samples/hidraw/hid-example.o
| samples/hidraw/hid-example.c:29:23: fatal error: sys/ioctl.h: No such 
| file or directory
| 
| Because for %.o there is a rule in the toplevel Makefile passes control 
| to scripts/Makefile.build, while you would need scripts/Makefile.host in 
| this case. I don't know how to fix this, when Makefile.build is told to 
| build foo.o, it builds it as kernel code, it doesn't inspect the 
| hostprogs-y variable to see if perhaps foo.o is in the foodchain of some 
| host program. However, 'make  samples/hidraw/' works fine for me. So 
| what command exactly did you use?

Michal
