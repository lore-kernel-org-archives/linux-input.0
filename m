From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] Support for 3M multitouch panel
Date: Wed, 23 Dec 2009 01:33:03 +0100 (CET)
Message-ID: <alpine.LNX.2.00.0912230131530.3755@pobox.suse.cz>
References: <20091211101258.CD35D951F5@smtp.lii-enac-fr> <20091211124226.GD17995@ibawizard.net> <20091211141038.0CBD8951F5@smtp.lii-enac.fr> <20091211223622.GA3067@core.coreip.homeip.net> <694242AB-D4DC-470D-916D-9ADB2B798FBA@enac.fr>
 <20091222185628.GA28392@core.coreip.homeip.net> <20091222220417.EA008951F2@smtp.lii-enac.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:59663 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbZLWAdE (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Dec 2009 19:33:04 -0500
In-Reply-To: <20091222220417.EA008951F2@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: dmitry.torokhov@gmail.com, chatty@enac.fr, ynezz@true.cz, linux-input@vger.kernel.org

On Tue, 22 Dec 2009, Stephane Chatty wrote:

> Added support for 3M multitouch panels.

... I had to fix trivial build failure (3M vs. MMM inconsistency in 
defines).

> +config HID_3M_PCT
> +	tristate "3M PCT" if EMBEDDED
> +	depends on USB_HID
> +	default !EMBEDDED

Hmm, I wouldn't be so sure about this in this case ... the point behind 
'default !EMBEDDED' was that simple a straightforward quirks for HID 
devices (which are implemented as drivers on HID bus) wouldn't have to be 
enabled separately, if the device is otherwise more-or-less HID standard 
compliant.

But this driver is rather standalone driver, I guess we'd want to have it 
normally selectable.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
