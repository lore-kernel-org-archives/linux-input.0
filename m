From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: lenovo: add support for Lenovo ThinkPad Keyboard
 Pro unit
Date: Mon, 4 May 2015 10:04:26 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1505041003140.3081@pobox.suse.cz>
References: <1430511765-28209-1-git-send-email-benjamin.tissoires@redhat.com> <5544807C.1080301@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:34239 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751365AbbEDIE2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 4 May 2015 04:04:28 -0400
In-Reply-To: <5544807C.1080301@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: John Reid <owlman.lists@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jonathan Oppenheim <lejono@gmail.com>, linux-input@vger.kernel.org

On Sat, 2 May 2015, John Reid wrote:

> Hi Benjamin, all,
> 
> Keyboard works just fine now, along with the Wacom digitiser. Thank you
> very much for you help linux-input folks :)

Are you OK with me adding

	Tested-by: John Reid <owlman.lists@gmail.com>

to the patch?

> Might I suggest that the macro is renamed from
> USB_DEVICE_ID_LENOVO_TPPRODOCK to something like
> USB_DEVICE_ID_LENOVO_TPHELIXPROKDB as this better reflects the product
> name in self documenting code? Technically this is a dockable keyboard
> specific to the Helix tablet, and there is also a separate "dock" available.

Ah, I wouldn't be overly careful about the macro names, they are really 
just for basic orientation ... there have even been people suggesting we 
just completely drop it, and use just numeric constants directly.

Thanks,

-- 
Jiri Kosina
SUSE Labs
