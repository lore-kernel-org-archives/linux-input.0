From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] xpad - Set buffer length for outgoing requests
Date: Tue, 15 Apr 2008 01:39:00 -0400
Message-ID: <20080415053900.GD24870@anvil.corenet.prv>
References: <74d457500804080405x50098dcfi6dfe965da2a962ef@mail.gmail.com> <20080411113140.ZZRA012@mailhub.coreip.homeip.net> <48005344.2010700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:5548 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753783AbYDOFjH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Apr 2008 01:39:07 -0400
Received: by an-out-0708.google.com with SMTP id d31so500468and.103
        for <linux-input@vger.kernel.org>; Mon, 14 Apr 2008 22:39:05 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <48005344.2010700@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: Michael Gruber <lists.mg@googlemail.com>, linux-input@vger.kernel.org

On Sat, Apr 12, 2008 at 09:14:28AM +0300, Anssi Hannula wrote:
> Dmitry Torokhov wrote:
> > Hi Michael,
> > 
> > On Tue, Apr 08, 2008 at 01:05:27PM +0200, Michael Gruber wrote:
> >> From: Michael Gruber <lists.mg@googlemail.com>
> >>
> >> The messages for led/rumble are exactly 3 and 8 bytes respectively.
> >> Hence set up the transfer_buffer_length accordingly.
> >>
> >> Signed-off-by: Michael Gruber <lists.mg@googlemail.com>
> >>
> > 
> > Thank you for the patch, it seems reasonable. Anssi, any objections?
> 
> Seems ok, though I'm not a urb expert.
> 
> Acked-by: Anssi Hannula <anssi.hannula@gmail.com>
> 

We do the similar manipulations in other drivers...

Applied, thank you Michael.

-- 
Dmitry
