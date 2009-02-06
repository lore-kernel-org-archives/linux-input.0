From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [patch 1/2] input: introduce a tougher i8042.reset
Date: Thu, 5 Feb 2009 16:35:13 -0800
Message-ID: <20090205163513.1a5d7308@infradead.org>
References: <20090204191540.2d6abd87@infradead.org>
	<20090204191631.21783c62@infradead.org>
	<20090205135229.e4d5efc3.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from casper.infradead.org ([85.118.1.10]:34500 "EHLO
	casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbZBFAe6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 5 Feb 2009 19:34:58 -0500
In-Reply-To: <20090205135229.e4d5efc3.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 5 Feb 2009 13:52:29 -0800
Andrew Morton <akpm@linux-foundation.org> wrote:

> On Wed, 4 Feb 2009 19:16:31 -0800
> Arjan van de Ven <arjan@infradead.org> wrote:
> 
> > Some touchpads don't reset right the first time (MSI Wind U-100 for
> > example). This patch will retry the reset up to 5 times.
> 
> Sigh, real life sucks.  I wonder what the windows driver does.

I have no idea; but this worked for me.
I bet the windows driver just retries as well.

> 
> > In addition, this patch also adds a module parameter to not treat
> > reset failures as fatal to the usage of the device. This prevents
> > a touchpad failure from also disabling the keyboard....
> > 
> 
> Is there any reason why we shouldn't just do this all the time?
> 
> IOW, is there any benefit in marking the 8042 as dead?

if it really is not there, then the kernel later will stall talking to
it.... for the "normal" headless server case.
At least I suppose. The input people need to jump in on this one.. I
didn't want to do a mass behavior change on something this fragile.



-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
