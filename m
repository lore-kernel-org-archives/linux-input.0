From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Tue, 5 Oct 2010 10:41:06 -0700
Message-ID: <20101005174106.GA21399@core.coreip.homeip.net>
References: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:49490 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab0JERlP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 13:41:15 -0400
Received: by pxi10 with SMTP id 10so1712976pxi.19
        for <linux-input@vger.kernel.org>; Tue, 05 Oct 2010 10:41:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar R IYER <sundar.iyer@stericsson.com>
Cc: Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.osdl.org

Hi Sundar,

On Tue, Oct 05, 2010 at 06:54:42PM +0200, Sundar R IYER wrote:
> Hi Dmitry,
> 
> Meego folks have a requirement for dynamic sysfs switches
> for input drivers. I saw a patch from Samu (Nokia) for the same but which
> lost its way out.  Here is a small modified patch set for the SKE
> driver *only* which completes this requirement and hence a question for
> you. (The idea is only a sysfs implemention; its not yet synced in with the
> mainline code)
> 
> Would you be okay to accept a stand-alone patch like the below for all the
> input drivers that we would be pushing in or do you have some comments
> or improvements suggested to be folded in the original patch set from Nokia,
> so that it can get through into the generic tree?

I am not the biggest fan of such solution and I would prefer having this
facility on a more generic level, maybe tied in with a special for of PM
(something like user-controlled)?  Then most of the devices would simply
reuse existing suspend/resume hooks without the need to add more and
more pretty much duplicate code.

Thanks.

-- 
Dmitry
