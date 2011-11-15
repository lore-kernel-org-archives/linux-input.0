From: Sean Young <sean@mess.org>
Subject: Re: [PATCH] HID: Add support for pressure sensitive buttons
Date: Tue, 15 Nov 2011 20:18:37 +0000
Message-ID: <20111115201837.GA14365@pip.mess.org>
References: <1321304314-17424-1-git-send-email-sean@mess.org>
 <alpine.LNX.2.00.1111151523500.15187@pobox.suse.cz>
 <345d84857ccc04c9a413afeba8e2fe8e.squirrel@host171.canaca.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pip.mess.org ([212.110.186.137]:36060 "EHLO pip.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756526Ab1KOU1h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 15 Nov 2011 15:27:37 -0500
Content-Disposition: inline
In-Reply-To: <345d84857ccc04c9a413afeba8e2fe8e.squirrel@host171.canaca.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: Jiri Kosina <jkosina@suse.cz>, Jussi Kivilinna <jussi.kivilinna@mbnet.fi>, linux-input@vger.kernel.org

On Tue, Nov 15, 2011 at 12:10:54PM -0500, simon@mungewell.org wrote:
> 
> >> +	report->field[0]->value[2] = 1; /* if this field is 0, then pressure
> >> +		buttons won't be reported as digital button presses any more */
> 
> Hi all,
> I may have missed earlier conversations around this subject, but is this
> something we really want? I mean if a pressure sensitive button reports
> both digital and analogue values at the HID level, shouldn't we pass both
> onto userland.

Maybe I could have worded it better, but in this patch here both digital
and analog values _are_ being passed to userland.

Since the hardware supports disabling this, there could be a sysfs knob
for this but I could not think of use case for it. Please let me know if
it is useful.


Sean
