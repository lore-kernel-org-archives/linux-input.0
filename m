From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/3] input / sysrq fixes for use with kdb
Date: Sun, 10 Oct 2010 14:19:44 -0700
Message-ID: <20101010211944.GB27553@core.coreip.homeip.net>
References: <1286483748-1171-1-git-send-email-jason.wessel@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1286483748-1171-1-git-send-email-jason.wessel@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jason Wessel <jason.wessel@windriver.com>
Cc: kgdb-bugreport@lists.sourceforge.net, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

On Thu, Oct 07, 2010 at 03:35:45PM -0500, Jason Wessel wrote:
> The goal of this patch set is to help eliminate the problems of
> resuming from the kernel debugger and having "stuck keys".
> 
> I am completely open to moving the code chunks around if it makes more
> sense to put the function in the input.c.
> 
> I had posted the first patch in the series before and never received
> an ack or acceptance into the linux-input merge queue.
> 

Jason,

I am aware of the problem however I am not quite happy with the proposed
solution yet. Let me mull it over for a bit and I will get back to you.

Thanks.

-- 
Dmitry
