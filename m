From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH 1/1] HID: uclogic: Add support for UC-Logic TWHL850
Date: Mon, 14 May 2012 11:16:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1205141114070.15448@pobox.suse.cz>
References: <1336941190-11066-1-git-send-email-spbnick@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:43426 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754331Ab2ENJQd (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 May 2012 05:16:33 -0400
In-Reply-To: <1336941190-11066-1-git-send-email-spbnick@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nikolai Kondrashov <spbnick@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>

On Sun, 13 May 2012, Nikolai Kondrashov wrote:

> Add support for UC-Logic Wireless Tablet TWHL850.
> It is known to be sold as Genius MousePen M508W.
> 
> This tablet has a bug in the default (compatibility) mode which is used in this
> driver: frame button assignments are mixed up. This is to be fixed with a driver
> using proprietary protocol, which is to be fully reverse-engineered yet.
> 
> Signed-off-by: Nikolai Kondrashov <spbnick@gmail.com>
> ---
> 
> This is based on 3.4-rc7.
> 
> I'm a bit unsure about the IFACE_RDESC_FIXUP macro. Please tell if it's not
> acceptable and I'll rewrite that part in the required way.

Well, I actually think it causes the code to be less readable compared to 
having it fully expanded.

So I'd like to ask you to drop that strange macro and just put a fully 
expanded version there ... it's 10 lines more or so, but readable 
immediately without thinking.

Thanks,

-- 
Jiri Kosina
SUSE Labs
