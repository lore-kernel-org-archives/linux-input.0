From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: xpad - Rename buttons to avoid conflict with mouse input
Date: Wed, 16 Apr 2008 14:34:22 -0400
Message-ID: <20080416143149.ZZRA012@mailhub.coreip.homeip.net>
References: <74d457500804150313n3487e672r35261b9dd75b0303@mail.gmail.com> <48062E1D.40805@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.179]:65118 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbYDPSe3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 14:34:29 -0400
Received: by ik-out-1112.google.com with SMTP id c28so611799ika.5
        for <linux-input@vger.kernel.org>; Wed, 16 Apr 2008 11:34:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48062E1D.40805@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Michael Gruber <lists.mg@googlemail.com>, linux-input@vger.kernel.org

On Wed, Apr 16, 2008 at 07:49:33PM +0300, Anssi Hannula wrote:
> Michael Gruber wrote:
> > From: Michael Gruber <lists.mg@googlemail.com>
> > 
> > BTN_LEFT, BTN_RIGHT and BTN_BACK are listed as mouse buttons according to
> > input.h. Rename them to make sure they do not interfere with mouse input.
> > 
> > Signed-off-by: Michael Gruber <lists.mg@googlemail.com>
> > 
> > ---
> > 
> > When I set up the driver to use MAP_DPAD_TO_BUTTONS the controller starts
> > acting as mouse. Touching the d-pad issues left and right mouse click events
> > and the back button acts like one of my other mouse buttons.
> 
> Patch seems correct to me.
> 
> Acked-by: Anssi Hannula <anssi.hannula@gmail.com>
> 

The original author of d-pad mode did that so the pad withh work
with stepmania. If left/right/0/1 are the defaults used there
we might break existing setups... Do you know of other applications
using dance pads?


-- 
Dmitry
