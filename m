From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: Lost events in older kernels
Date: Sun, 23 May 2010 10:44:25 +0200
Message-ID: <4BF8EAE9.3050504@euromail.se>
References: <4BF7825F.2030405@seas.upenn.edu> <20100522074249.GA25143@core.coreip.homeip.net> <4BF7A247.5090307@seas.upenn.edu> <4BF7B183.2050801@euromail.se> <20100522201256.GB30464@core.coreip.homeip.net> <4BF88EA2.3040402@seas.upenn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:46756 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752476Ab0EWIor (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 23 May 2010 04:44:47 -0400
In-Reply-To: <4BF88EA2.3040402@seas.upenn.edu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Rafi Rubin <rafi@seas.upenn.edu>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Mika Kuoppala <mika.kuoppala@nokia.com>

Rafi Rubin wrote:
[...]
> Um, turns out I missed input_init_abs_bypass(void) in my backport, and for some
> reason get a bit of corruption ;)
> 
> Sorry for the false alarm.

If your code executed without bypassing event filtering, it would only mean less
events were sent, which would not void the argument. If you have updated
numbers, it would be very interesting to see them.

Henrik

