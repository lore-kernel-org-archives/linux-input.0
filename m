From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: ALPS v4 Semi-mt Support
Date: Tue, 17 Apr 2012 10:22:36 -0500
Message-ID: <20120417152236.GD14091@thinkpad-t410>
References: <1364401.K99JIOKFyb@vaio>
 <1492453.bjpWEAk9kj@vaio>
 <20120416212407.GE3959@thinkpad-t410>
 <1708752.SgOWjWFNqk@vaio>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45203 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661Ab2DQPWj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 Apr 2012 11:22:39 -0400
Content-Disposition: inline
In-Reply-To: <1708752.SgOWjWFNqk@vaio>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: George Pantalos <gpantalos@gmail.com>
Cc: linux-input@vger.kernel.org

On Tue, Apr 17, 2012 at 03:52:34AM +0300, George Pantalos wrote:
> On Monday 16 of April 2012 16:24:07 Seth Forshee wrote:
> > If the latency really is noticible when you stash the ST points, here's
> > what I'd suggest trying instead. Stash away the last set of MT data you
> > saw and repeat it with each of the next two ST coordinates. I suspect
> > that will probably work well enough, and will allow every ST point to
> > still be reported. And it should significantly simplify the code as
> > well.
> 
> I tried your suggestion and I have to say that it works great. 
> Thank you, Seth.
> I hope my execution is ok. 

The implementation looks good to me. If you're confident that the
interpretation of the sync is correct, submit the patch according to the
guidelines in Documentation/SubmittingPatches and I'll be happy to give
my ack.

Seth

