From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Issues detecting i8042 AUX port
Date: Thu, 8 Oct 2009 23:17:31 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0910082315070.12171@twin.jikos.cz>
References: <4ACB533A.7080001@urbanec.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58721 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932583AbZJHVSJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 8 Oct 2009 17:18:09 -0400
In-Reply-To: <4ACB533A.7080001@urbanec.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Urbanec <vger.kernel.org.input@urbanec.net>
Cc: linux-input@vger.kernel.org

On Wed, 7 Oct 2009, Peter Urbanec wrote:

> I have come across an issue that appears to be either timing sensitive
> or possibly a race condition when it comes to detecting i8042 AUX port.
> 
> The full story is at http://bugs.gentoo.org/show_bug.cgi?id=287019
> including attachments that contain the results of dmesg output with
> i8042.debug turned on.
> 
> In a nutshell, I can run the same kernel on the same hardware and on
> some boots the AUX port will not be detected and on other boots it will
> come up fine. So far the only suspicion I have is that the
> initialisation of USB ports and/or SATA disks may cause some kind of
> delay that interferes with the i8042 detection of the AUX port.
> 
> It was suggested that I try adding my machine's DMI information to the
> noloop exception table. I do not believe that doing so makes much sense,
> since this is an intermittent problem, not an outright inability to
> raise the AUX IRQ.
> 
> Any ideas?

Does booting with 'i8042.noloop' improve the situation?

-- 
Jiri Kosina
SUSE Labs, Novell Inc.

