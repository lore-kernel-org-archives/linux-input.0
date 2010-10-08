From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [RESEND] [PATCH] Input: add appleir USB driver
Date: Thu, 7 Oct 2010 20:39:40 -0400
Message-ID: <20101008003940.GF31804@redhat.com>
References: <1285844276.26405.26.camel@cookie.hadess.net>
 <201009300847.43090.dmitry.torokhov@gmail.com>
 <1285861890.26405.37.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:21231 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752200Ab0JHAju (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Oct 2010 20:39:50 -0400
Content-Disposition: inline
In-Reply-To: <1285861890.26405.37.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, Sep 30, 2010 at 04:51:30PM +0100, Bastien Nocera wrote:
> On Thu, 2010-09-30 at 08:47 -0700, Dmitry Torokhov wrote:
> > Bastien,
...
> >  I'll try
> > to get the driver in .37 but after that we should probably move it
> > over to the new IR infrastructure...
> 
> I'm not sure what that would bring us, nor do I have any experience in
> using the ir-core. From what I understood, it still needed fleshing out.

There are a few things that still need fleshing out, but nothing really
that should have any major impact on a potential port of this driver.

Off the top of my head, the main thing it would give you is the ability to
upload your own keymap for the receiver. Then someone wanting to use more
than 6 buttons or whatever it is might still be able to get the benefits
of in-kernel decoding with everything coming through the input layer,
rather than using lirc or the like.

-- 
Jarod Wilson
jarod@redhat.com

