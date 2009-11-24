From: Matthieu CASTET <castet.matthieu@free.fr>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Tue, 24 Nov 2009 23:23:57 +0000 (UTC)
Message-ID: <loom.20091125T002338-652@post.gmane.org>
References: <200910200956.33391.jarod@redhat.com> <200910200958.50574.jarod@redhat.com> <4B0A765F.7010204@redhat.com> <4B0A81BF.4090203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lo.gmane.org ([80.91.229.12]:59608 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752347AbZK1SAC (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Nov 2009 13:00:02 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NERaY-0000pP-6m
	for linux-input@vger.kernel.org; Sat, 28 Nov 2009 19:00:06 +0100
Received: from cac94-1-81-57-151-96.fbx.proxad.net ([81.57.151.96])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2009 19:00:06 +0100
Received: from castet.matthieu by cac94-1-81-57-151-96.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-input@vger.kernel.org>; Sat, 28 Nov 2009 19:00:06 +0100
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

>
Hi,

this remind me
http://thread.gmane.org/gmane.linux.drivers.video-input-infrastructure/584/focus=585
thread.




Mauro Carvalho Chehab <mchehab <at> redhat.com> writes:


> So, the basic question that should be decided is: should we create a new
> userspace API for raw IR pulse/space or it would be better to standardize it
> to always use the existing input layer?
>
To me the old ttpci approach was great :
- the kernel does the IR pulse translation to input layer. In the current kernel
there code duplication, it is done in many driver (with different way) [1].
A new subdriver should take as input the decoded remote address, data and toggle
and output a key in input layer
- userspace need to configure IR pulse type (RC5, ...), remote address, keymap.
But the kernel can have some default config for the hardware. Keymap are stored
in userspace.



Matthieu

[1] for example there not way to specify remote remote address to use.
"ir->addr" hardcoded in bttv, saa7134. em28xx doesn't use the decoded
rc_address, ...

