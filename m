From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [patch] hid: only dump report traffic with debug level 2
Date: Sat, 22 Mar 2008 22:50:38 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0803222248360.5541@jikos.suse.cz>
References: <47E4200D.9080904@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from styx.suse.cz ([82.119.242.94]:47230 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752620AbYCVVun (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 22 Mar 2008 17:50:43 -0400
In-Reply-To: <47E4200D.9080904@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org

On Fri, 21 Mar 2008, Anssi Hannula wrote:

> Currently using debug=1 with hid module prints out all sent and received 
> reports to the kernel log, while in many cases we only want to see the 
> report descriptors and hid-input mappings that are printed when a device 
> is probed.

Hi Anssi,

thanks for your patch, I agree that making this more configurable makes 
sense.

But I would propose staying backwards compatible, i.e. debug=1 does the 
whole dump, debug=2 excludes the individual reports but still dumps the 
report descriptor and mappings etc. What do you think?

Thanks,

-- 
Jiri Kosina
SUSE Labs
