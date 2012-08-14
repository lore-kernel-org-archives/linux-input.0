From: Oliver Neukum <oneukum@suse.de>
Subject: Re: USB interrupt times
Date: Tue, 14 Aug 2012 14:31:31 +0200
Message-ID: <1793852.Bo9a4VavnM@linux-lqwf.site>
References: <20120814103936.GA7105@flint.arm.linux.org.uk> <alpine.LNX.2.00.1208141250020.12490@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:33211 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292Ab2HNMci (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Aug 2012 08:32:38 -0400
In-Reply-To: <alpine.LNX.2.00.1208141250020.12490@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Russell King <rmk@arm.linux.org.uk>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Henrik Rydberg <rydberg@euromail.se>

On Tuesday 14 August 2012 12:54:00 Jiri Kosina wrote:
> Offloading the processing to workqueue might actually work and make sense, 
> but I will have to think a little bit more about all the consequences it'd 
> have throughout the rest of the code.

How would alt-sysrq be handled?

	Reagrds
		Oliver

