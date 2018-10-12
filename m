From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [git pull] Input updates for v4.19-rc7
Date: Fri, 12 Oct 2018 12:51:52 +0200
Message-ID: <20181012105152.GB19643@kroah.com>
References: <20181011235736.GA68543@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181011235736.GA68543@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 11, 2018 at 04:57:36PM -0700, Dmitry Torokhov wrote:
> Hi Greg,
> 
> Please pull from:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
> 
> to receive updates for the input subsystem:
> 
> - we added a few scheduling points into various input interfaces to
>   ensure that large writes will not cause RCU stalls
> 
> - fixed configuring PS/2 keyboards as wakeup devices on newer platforms

That feels like a really "late" contribution, I hope it goes well :)

Now merged, thanks.

greg k-h
