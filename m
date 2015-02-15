From: Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 2/2] input: rotary encoder: Add wake up support
Date: Sun, 15 Feb 2015 12:53:51 +0700
Message-ID: <20150215055351.GC2551@localhost>
References: <1423755638-9294-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423755638-9294-3-git-send-email-sylvain.rochet@finsecur.com>
 <20150213034317.GB1924@localhost>
 <20150213091207.GA17626@gradator.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:45959 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbbBOFv7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 15 Feb 2015 00:51:59 -0500
Received: by pdjz10 with SMTP id z10so28027922pdj.12
        for <linux-input@vger.kernel.org>; Sat, 14 Feb 2015 21:51:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20150213091207.GA17626@gradator.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sylvain Rochet <sylvain.rochet@finsecur.com>
Cc: Johan Hovold <jhovold@gmail.com>, linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

On Fri, Feb 13, 2015 at 10:12:08AM +0100, Sylvain Rochet wrote:
> Hello Johan,
> 
> On Fri, Feb 13, 2015 at 11:43:17AM +0800, Johan Hovold wrote:
> > On Thu, Feb 12, 2015 at 04:40:38PM +0100, Sylvain Rochet wrote:
> > > This patch adds wake up support for rotary encoders.
> > > 
> > > Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> > > Reviewed-by: Johan Hovold <johan@kernel.org>
> > > ---
> > >  Documentation/input/rotary-encoder.txt |  1 +
> > >  drivers/input/misc/rotary_encoder.c    | 37 ++++++++++++++++++++++++++++++++++
> > >  include/linux/rotary_encoder.h         |  1 +
> > >  3 files changed, 39 insertions(+)
> > > 
> > > diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
> > > index 92e68bc..ed158d3 100644
> > > --- a/Documentation/input/rotary-encoder.txt
> > > +++ b/Documentation/input/rotary-encoder.txt
> > > @@ -109,6 +109,7 @@ static struct rotary_encoder_platform_data my_rotary_encoder_info = {
> > >  	.inverted_a	= 0,
> > >  	.inverted_b	= 0,
> > >  	.half_period	= false,
> > > +	.wakeup_source	= false,
> > >  };
> > 
> > This should have been part of PATCH 1/2 as well.
> 
> Oops, this is not what I understand :(, should I resend ?

You can wait and see what the device-tree folks says about using
"wakeup-source" as property name first.

Johan
