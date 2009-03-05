From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 1/2] input: misc: add twl4030-pwrbutton driver
Date: Wed, 4 Mar 2009 17:38:07 -0800
Message-ID: <200903041738.07659.david-b@pacbell.net>
References: <1235762883-20870-1-git-send-email-me@felipebalbi.com> <20090304090026.GC7394@dtor-d630.eng.vmware.com> <20090304101231.GS4640@scadufax.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from n56.bullet.mail.sp1.yahoo.com ([98.136.44.52]:47303 "HELO
	n56.bullet.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750928AbZCEBiL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 4 Mar 2009 20:38:11 -0500
In-Reply-To: <20090304101231.GS4640@scadufax.research.nokia.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: felipe.balbi@nokia.com, ext Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Samuel Ortiz <sameo@openedhand.com>

On Wednesday 04 March 2009, Felipe Balbi wrote:
> 
> > Cool, I will keep it in my tree pending the threaded IRQ issue
> > resolution.
> 
> I guess the threaded IRQ issue will still take a while to be solved and
> this driver is working as is, so there's no big problem in pushing it
> and fixing the threaded irq on later patches. But I'd like to hear from
> Andrew, Dave and the others about that.

I'd say just push this driver with the other 2.6.30 stuff.
There's no point in holding it back.

The yet-to-be-merged threaded IRQ support won't break the
in-tree stuff.  And it's not exactly fully cooked, since
it doesn't yet handle a highly-relevant use-case ... :)

So the plan of record remains unchanged:  once mainline
has adequately functional threaded IRQ support, update
twl4030-family drivers to use it.  Meanwhile, use the
current stuff, which despite some aesthetic warts still
works just fine.

The positive note seems to be that the IRQ threading
patches have gotten refreshed.

- Dave


