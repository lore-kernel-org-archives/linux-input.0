From: JJ Ding <jj_ding@emc.com.tw>
Subject: Re: elantech buttonpad devices
Date: Tue, 03 Apr 2012 09:23:50 +0800
Message-ID: <87aa2tvc9l.fsf@emc.com.tw>
References: <4F79F36C.8000503@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:4066 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751121Ab2DCBWL (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Apr 2012 21:22:11 -0400
In-Reply-To: <4F79F36C.8000503@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chase Douglas <chase.douglas@canonical.com>, linux-input <linux-input@vger.kernel.org>

Hi Chase, 

On Mon, 02 Apr 2012 11:43:56 -0700, Chase Douglas <chase.douglas@canonical.com> wrote:
> Hi JJ,
> 
> Now that we've added clickpad, or buttonpad, support in
> xf86-input-synaptics, ensuring all the buttonpad devices are marked as
> such by the linux drivers is important. Apparently, some Elantech
> trackpads are buttonpads. What would it take to add support for setting
> this input device property in the elantech driver?

Basically, only v4 hardware is buttonpad. I do have a few patches to add
the support for this, just haven't had the time to send them out yet.

I will tidy up my patches a bit and send them out for review ASAP.
Thank you for reminding me this.

Best regards,
-JJ

> Thanks!
> 
> -- Chase
