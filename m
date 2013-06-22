From: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v1 10/12] input: keypad_matrix: use usleep_range() for
 scan delay
Date: Sat, 22 Jun 2013 12:17:39 +0200
Message-ID: <20130622101739.GI24305@book.gsilab.sittig.org>
References: <1371838198-7327-1-git-send-email-gsi@denx.de>
 <1371838198-7327-11-git-send-email-gsi@denx.de>
 <51C4CCF3.20603@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:41258 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752534Ab3FVKRn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Jun 2013 06:17:43 -0400
Content-Disposition: inline
In-Reply-To: <51C4CCF3.20603@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Chao Xie <xiechao.mail@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Detlev Zundel <dzu@denx.de>, Sekhar Nori <nsekhar@ti.com>, Marek Vasut <marek.vasut@gmail.com>, Ralf Baechle <ralf@linux-mips.org>

On Fri, Jun 21, 2013 at 16:00 -0600, Stephen Warren wrote:
> 
> On 06/21/2013 12:09 PM, Gerhard Sittig wrote:
> > querying keyboards isn't a time critical task and does not depend on
> > exact timing in the microseconds order -- the timeouts and delays are
> > arbitrary choices or educated guesses at best anyway
> 
> > diff --git a/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt b/Documentation/devicetree/bindings/input/gpio-matrix-keypad.txt
> 
> > @@ -93,7 +93,10 @@ Optional Properties:
> >  			a column line and reading back its row status,
> >  			such that pin levels can settle after
> >  			propagating through the matrix and its
> > -			associated hardware components
> > +			associated hardware components, can be specified
> > +			with either one value giving the exact delay, or
> > +			with two values giving a delay range (allowing
> > +			for reduced timer management overhead)
> >  - col-switch-delay-ms:	columns switch interval in milliseconds instead
> >  			of using interrupts to detect key press changes,
> >  			enables polling mode when specified
> > @@ -146,7 +149,7 @@ Examples:
> >  	matrix_keypad {
> >  		compatible = "gpio-matrix-keypad";
> >  		debounce-delay-ms = <5>;
> > -		col-scan-delay-us = <1>;
> > +		col-scan-delay-us = <2 10>;
> 
> Is it really useful to change the binding this way?
> 
> The values in DT presumably represent the minimum delays that the HW
> will tolerate or that are useful. SW is always free to scan more slowly
> than that. As such, if you're simply modifying the driver to allow more
> flexibility in timing, then I don't think you have to modify the DT
> binding to allow for this?

Yes, this puts less burdon on the .dts author.  The "problem"
would be to come up (programmatically, without the user's spec)
with an appropriate upper bound.

One might choose "half the col switch delay" when available (in
the polling scenario).  Or "three times the lower bound".  Or an
arbitrary upper bound in the 100us order.  Or actually with the
minimum of all the above.  That should keep the absolute minimum
(user specified) in the loop, and scan the keys fast enough, yet
drastically reduce timer management overhead, and hide all of
this from the .dts author.

I will ponder this for a moment ...


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
