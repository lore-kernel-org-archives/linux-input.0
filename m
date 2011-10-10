From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH V2] input: Fix USB autosuspend on bcm5974
Date: Mon, 10 Oct 2011 15:16:35 +0100
Message-ID: <20111010141635.GA17889@srcf.ucam.org>
References: <1318254086-22752-1-git-send-email-mjg@redhat.com>
 <201110101606.37878.oneukum@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55929 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754104Ab1JJOQi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Oct 2011 10:16:38 -0400
Content-Disposition: inline
In-Reply-To: <201110101606.37878.oneukum@suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: linux-input@vger.kernel.org, rydberg@euromail.se, dtor@mail.ru

On Mon, Oct 10, 2011 at 04:06:37PM +0200, Oliver Neukum wrote:

> This is odd, because the hardware shouldn't generate remote wakeups unless you
> request them, like this (usbhid)

I thought needs_remote_wakeup was a hint to the kernel that remote 
wakeup ability was required for the hardware to autosuspend? In theory I 
guess it should be set, but in practice all the hardware supported by 
this driver generates them so it'd be a noop. No objection to adding it 
in the name of correctness (or if some future version is broken, I 
guess...), though.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
