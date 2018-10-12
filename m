From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [git pull] Input updates for v4.19-rc7
Date: Fri, 12 Oct 2018 13:02:46 -0700
Message-ID: <20181012200246.GB35430@dtor-ws>
References: <20181011235736.GA68543@dtor-ws>
 <20181012105152.GB19643@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012105152.GB19643@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Fri, Oct 12, 2018 at 12:51:52PM +0200, Greg KH wrote:
> On Thu, Oct 11, 2018 at 04:57:36PM -0700, Dmitry Torokhov wrote:
> > Hi Greg,
> > 
> > Please pull from:
> > 
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> > 
> > to receive updates for the input subsystem:
> > 
> > - we added a few scheduling points into various input interfaces to
> >   ensure that large writes will not cause RCU stalls
> > 
> > - fixed configuring PS/2 keyboards as wakeup devices on newer platforms
> 
> That feels like a really "late" contribution, I hope it goes well :)

Yeah, that is true, but I'd be marking it for 4.19 stable anyway as we
do want newer devices to wake up on keyboard activity, so there was no
reason not to send it now. If we have to revert we'd be reverting
everywhere anyways.

FWIW Daniel posted the patch a while ago, we just have been working out
kinks in handling builds with different config options.

Thanks.

-- 
Dmitry
