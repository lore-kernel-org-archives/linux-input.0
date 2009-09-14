From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: bcm5974.c initialize raw_w, raw_x and raw_y
	before it get used
Date: Sun, 13 Sep 2009 21:37:14 -0700
Message-ID: <20090914043714.GB11854@core.coreip.homeip.net>
References: <1252775770.3687.7.camel@ht.satnam> <4AAC2DBE.9040303@bitmath.org> <1252830690.3440.5.camel@ht.satnam> <4AACD9E9.4000702@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f184.google.com ([209.85.222.184]:45371 "EHLO
	mail-pz0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbZINEhQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 00:37:16 -0400
Received: by pzk14 with SMTP id 14so2322380pzk.1
        for <linux-input@vger.kernel.org>; Sun, 13 Sep 2009 21:37:20 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4AACD9E9.4000702@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Jaswinder Singh Rajput <jaswinder@kernel.org>, linux-input@vger.kernel.org

On Sun, Sep 13, 2009 at 01:39:21PM +0200, Henrik Rydberg wrote:
> Jaswinder Singh Rajput wrote:
> > On Sun, 2009-09-13 at 01:24 +0200, Henrik Rydberg wrote:
> >> Jaswinder Singh Rajput wrote:
> >>> raw_w, raw_x and raw_y is used uninitialized for !raw_n
> >> Thanks for the heads up, but actually not, since !raw_n also implies
> >> !(ptest > PRESSURE_LOW).
> >>
> > 
> > Then can we move 'if (ptest > PRESSURE_LOW && origin)' stuff to 'if
> > (raw_n)'. If not then my patch is correct.
> 
> Yes, that's it, thanks. So this patch ought to solve the warning cleanly:
> 

Yes, I like this one much better, applied.

> >>
> >>
> >> I wonder how many cpu cycles in the world are spent making compilers happy.
> >>
> > 
> > It is not compiler mistake it is programming/logic mistakes. We should
> > be thankful to compiler to pointing mistakes made by us.
> 

Except in cases when the compiler is wrong...

> The uninitialized-variable warnings have certainly proved their value many times
> over. I was merely reflecting over the fact that the enclosing space of all such
> errors could be made smaller by deduction at compile time.
> 

-- 
Dmitry
