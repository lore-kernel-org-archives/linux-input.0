From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] input: Fix autosuspend on bcm5974
Date: Tue, 13 Mar 2012 14:49:41 +0000
Message-ID: <20120313144941.GA13637@srcf.ucam.org>
References: <1331596278-2495-1-git-send-email-mjg@redhat.com>
 <20120313143958.GA2754@polaris.bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51294 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832Ab2CMOto (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Mar 2012 10:49:44 -0400
Content-Disposition: inline
In-Reply-To: <20120313143958.GA2754@polaris.bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.se>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Tue, Mar 13, 2012 at 03:39:58PM +0100, Henrik Rydberg wrote:

> With the previous version of this patch, the machine would not wake up
> on a normal tap. Is that what you refer to with the "small amount of
> additional latency"? By not enabled by default, you mean in the usb
> subsystem?

What do you mean by "normal tap"? By "not enabled by default" I mean the 
kernel doesn't enable autosuspend on input devices. Userspace would have 
to do that.

> Last time I checked, it seemed the first keystroke would sometimes
> disappear at boot. As far as I can see, this version modifies the
> needs_remote_wakeup variable to only be true while open, which might
> remove that particular problem.

I haven't seen any lost keystrokes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
