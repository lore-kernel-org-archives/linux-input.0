From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v2 2/2] HID: hid-plantronics: Update Kconfig HID_PLANTRONICS
 default setting
Date: Mon, 25 May 2015 13:47:15 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505251345310.13817@pobox.suse.cz>
References: <1431736512-23161-1-git-send-email-terry.junge@plantronics.com> <1431736512-23161-2-git-send-email-terry.junge@plantronics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50885 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424AbbEYLrQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 25 May 2015 07:47:16 -0400
In-Reply-To: <1431736512-23161-2-git-send-email-terry.junge@plantronics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Terry Junge <terry.junge@plantronics.com>
Cc: linux-input@vger.kernel.org

On Fri, 15 May 2015, Terry Junge wrote:

> Althought the general rule of thumb is to not add any new default-to-on
> options for things that are not crucial core infrastructure of the kernel,
> the hid-plantronics driver prevents hid-input from mapping unknown
> Plantronics vendor unique usages to random mouse events.
> 
> The result of this default mapping of unknown usages is that unexpected
> mouse or touchpad events can occur or be blocked when buttons are pressed
> on some Plantronics devices. Having this driver available as a module
> will prevent this core mapping.

Still, can only happen on system with the particular device connected. 
Therefore it's expected that the kernel will have support for that device 
built-in.

We're not putting 'default y' in kernel for non-core drivers.

Thanks,

-- 
Jiri Kosina
SUSE Labs
