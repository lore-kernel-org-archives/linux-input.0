From: Sylvain Rochet <sylvain.rochet@finsecur.com>
Subject: Re: [PATCH v3 2/2] input: rotary encoder: Add wake up support
Date: Fri, 13 Feb 2015 10:12:08 +0100
Message-ID: <20150213091207.GA17626@gradator.net>
References: <1423755638-9294-1-git-send-email-sylvain.rochet@finsecur.com>
 <1423755638-9294-3-git-send-email-sylvain.rochet@finsecur.com>
 <20150213034317.GB1924@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx-guillaumet.finsecur.com ([91.217.234.131]:59321 "EHLO
	guillaumet.finsecur.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbBMJML (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Feb 2015 04:12:11 -0500
Content-Disposition: inline
In-Reply-To: <20150213034317.GB1924@localhost>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Johan Hovold <jhovold@gmail.com>
Cc: linux-input@vger.kernel.org, Daniel Mack <daniel@caiaq.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Hello Johan,

On Fri, Feb 13, 2015 at 11:43:17AM +0800, Johan Hovold wrote:
> On Thu, Feb 12, 2015 at 04:40:38PM +0100, Sylvain Rochet wrote:
> > This patch adds wake up support for rotary encoders.
> > 
> > Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>
> > Reviewed-by: Johan Hovold <johan@kernel.org>
> > ---
> >  Documentation/input/rotary-encoder.txt |  1 +
> >  drivers/input/misc/rotary_encoder.c    | 37 ++++++++++++++++++++++++++++++++++
> >  include/linux/rotary_encoder.h         |  1 +
> >  3 files changed, 39 insertions(+)
> > 
> > diff --git a/Documentation/input/rotary-encoder.txt b/Documentation/input/rotary-encoder.txt
> > index 92e68bc..ed158d3 100644
> > --- a/Documentation/input/rotary-encoder.txt
> > +++ b/Documentation/input/rotary-encoder.txt
> > @@ -109,6 +109,7 @@ static struct rotary_encoder_platform_data my_rotary_encoder_info = {
> >  	.inverted_a	= 0,
> >  	.inverted_b	= 0,
> >  	.half_period	= false,
> > +	.wakeup_source	= false,
> >  };
> 
> This should have been part of PATCH 1/2 as well.

Oops, this is not what I understand :(, should I resend ?

Sylvain
