From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: HID regression: Quanta touchscreen, device ID: 0408:3008
Date: Mon, 23 Apr 2012 15:43:41 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204231542030.1856@pobox.suse.cz>
References: <CACVXFVPTMPGRcvgdBd9Z=rsPCUGdmyoejU208Wy=c3c38U-ZkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33308 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab2DWNnn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 23 Apr 2012 09:43:43 -0400
In-Reply-To: <CACVXFVPTMPGRcvgdBd9Z=rsPCUGdmyoejU208Wy=c3c38U-ZkQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@enac.fr>

On Mon, 23 Apr 2012, Ming Lei wrote:

> Hi,
> 
> Quanta touchscreen, device ID: 0408:3008, works well on 3.0, but
> double click doesn't work on 3.4-rc2, please refer to detailed report
> on the below link.
> 
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/913164/comments/15
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/913164/comments/32

Ming Lei,

those two links don't provide any detailed report whatsoever. Looking at 

	https://bugs.launchpad.net/ubuntu/+source/linux/+bug/913164

there seems to be quite some discussion, but covering multiple models from 
multiple vendors (and likely multiple different patches needed).

So if there are patches that need to be applied (likely device ID 
additions as far as I understand this monster launchpad bug entry), please 
point me directly to the respective patches or send me a little bit more 
details (VID/PID/protocol needed), and I'll queue the patches.

Thanks,

-- 
Jiri Kosina
SUSE Labs
