From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: PROBLEM: Kernel-Panic when using Apple-Magic-Trackpad
Date: Mon, 17 Feb 2014 17:10:05 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1402171709260.1192@pobox.suse.cz>
References: <52E96F57.30903@addiks.de> <alpine.LNX.2.00.1401301156090.31013@pobox.suse.cz> <52ED19F6.7020700@addiks.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43764 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750939AbaBQQKJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 17 Feb 2014 11:10:09 -0500
In-Reply-To: <52ED19F6.7020700@addiks.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gerrit Addiks <gerrit@addiks.de>
Cc: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>, "Gustavo F. Padovan" <gustavo@padovan.org>

On Sat, 1 Feb 2014, Gerrit Addiks wrote:

> Thank you for showing me that patch. After a couple days of testing it i can
> pretty clearly say that this patch fixes the kernel-panic for me. I hope the
> patch finds it's way into the public kernel repository as soon as possible.
> 
> I have compiled two kernels from the latest version (git: master), one patched
> and one unpatched: While the patched version worked flawlessly for days, the
> unpatched version got multiple times into kernel-panic after just seconds.

Thanks for testing. I am now waiting for the BT guys to pick it up. My 
plan is to push it for -rc4 myself if it doesn't go through bluetooth 
tree.

-- 
Jiri Kosina
SUSE Labs
