From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH v3 5/6] hid-multitouch: Switch to device groups
Date: Mon, 30 Apr 2012 18:42:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1204301837050.1856@pobox.suse.cz>
References: <1335175627-2270-1-git-send-email-rydberg@euromail.se> <1335175627-2270-6-git-send-email-rydberg@euromail.se> <CAN+gG=EWHi18kb1q2xQg8mfS9o6BHVLVdU+KYUcWdM4L3gJybA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:51382 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752797Ab2D3QmG (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 12:42:06 -0400
In-Reply-To: <CAN+gG=EWHi18kb1q2xQg8mfS9o6BHVLVdU+KYUcWdM4L3gJybA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <Benjamin_Tissoires@logitech.com>, Stephane Chatty <chatty@enac.fr>

On Mon, 30 Apr 2012, Benjamin Tissoires wrote:

> though I was not able to test it with the devices we have, I remarked
> a small regression in this patch: the detection of the serial protocol
> is not handled anymore. I was indeed relying on the fact that the
> parameter "id" in mt_probe was null to know that the device was not
> already in the list of known devices. I think that this small pitfall
> can be assessed in a separate commit later (after more testing) to
> keep the patch clear.
> 
> By looking at the whole code of the patch set, Acked-by: Benjamin
> Tissoires <benjamin.tissoires@gmail.com>
> 
> I'll tell you by the end of the week if anything goes wrong with our
> multitouch devices, but I don't see any reasons why it could fail.

Thanks for the review.

I will still wait for the mt_probe() serial protocol fix, as I'd like to 
be certain that what I push into for-next doesn't introduce any known 
regressions for which there is not a fix floating around yet.

One super-minor thing I have noticed when reviewing this patchset is that 
we have never put a upper bound on HID_DG_CONTACTMAX as presented by the 
device. In an extreme potential case of (likely broken) device this might 
result in memory corruption in mt_probe(), as the argument of kzalloc() 
when allocating the slots will overflow.

But this is not a regressions and has always been there, so something to 
fix separately.

-- 
Jiri Kosina
SUSE Labs
