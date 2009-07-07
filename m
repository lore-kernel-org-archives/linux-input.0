From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [regression] 2.6.30 leaking keys on console switch
Date: Tue, 7 Jul 2009 11:12:09 +0200
Message-ID: <20090707091209.GB10187@basil.fritz.box>
References: <87eiss7uhb.fsf@basil.nowhere.org> <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:54955 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752451AbZGGJMK (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jul 2009 05:12:10 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0907071048210.4994@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Andi Kleen <andi@firstfloor.org>, rjw@sisk.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>

> Are you seeing with a specific keyboard type(s), or is this a general 
> problem? 
> Could you confirm whether it is specific either 
> to PS2 or USB keyboards only, or it does happen for both?

I'm only seeing it with a USB keyboard, haven't seen it with PS/2
(but I rarely do console switches with PS/2, so might have missed it)

The USB keyboard is a rather ordinary logitech keyboard.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
