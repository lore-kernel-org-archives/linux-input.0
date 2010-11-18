From: Bastien Nocera <hadess@hadess.net>
Subject: Re: [RESEND] [PATCH] Input: add appleir USB driver
Date: Thu, 18 Nov 2010 04:18:03 +0000
Message-ID: <1290053884.1435.10.camel@novo.hadess.net>
References: <1285844276.26405.26.camel@cookie.hadess.net>
	 <201009300847.43090.dmitry.torokhov@gmail.com>
	 <1285861890.26405.37.camel@cookie.hadess.net>
	 <20101008003940.GF31804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay2-v.mail.gandi.net ([217.70.178.76]:56857 "EHLO
	relay2-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752713Ab0KRESI (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 17 Nov 2010 23:18:08 -0500
In-Reply-To: <20101008003940.GF31804@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, linux-kernel <linux-kernel@vger.kernel.org>

On Thu, 2010-10-07 at 20:39 -0400, Jarod Wilson wrote:
> On Thu, Sep 30, 2010 at 04:51:30PM +0100, Bastien Nocera wrote:
> > On Thu, 2010-09-30 at 08:47 -0700, Dmitry Torokhov wrote:
> > > Bastien,
> ...
> > >  I'll try
> > > to get the driver in .37 but after that we should probably move it
> > > over to the new IR infrastructure...
> > 
> > I'm not sure what that would bring us, nor do I have any experience in
> > using the ir-core. From what I understood, it still needed fleshing out.
> 
> There are a few things that still need fleshing out, but nothing really
> that should have any major impact on a potential port of this driver.
> 
> Off the top of my head, the main thing it would give you is the ability to
> upload your own keymap for the receiver.

You could already change the keymap...

>  Then someone wanting to use more
> than 6 buttons

But only for the 6 buttons supported.

>  or whatever it is might still be able to get the benefits
> of in-kernel decoding with everything coming through the input layer,
> rather than using lirc or the like.

I see very little benefits myself (I mean, unless you're adamant that
you want to use a remote that's not intended for that computer, but we
already have lirc user-space driver for doing that), and it would remove
metadata from the events, so we couldn't do "remote filtering" (each
remote has a semi-random UID, which gets passed in with the events).

When the appleir patch was finally accepted (which means I need to get
off my arse and do the changes Oliver mentioned), working on UID
filtering is next on my list of TODOs.

Cheers

