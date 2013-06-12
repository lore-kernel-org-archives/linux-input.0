From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCH] HID: multitouch: prevent memleak with the allocated
 name
Date: Wed, 12 Jun 2013 11:15:21 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1306121114230.6750@pobox.suse.cz>
References: <1369817109-4277-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:54982 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753043Ab3FLJPX (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Jun 2013 05:15:23 -0400
In-Reply-To: <1369817109-4277-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Stephane Chatty <chatty@enac.fr>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 29 May 2013, Benjamin Tissoires wrote:

> mt_free_input_name() was never called during .remove():
> hid_hw_stop() removes the hid_input items in hdev->inputs, and so the
> list is therefore empty after the call. In the end, we never free the
> special names that has been allocated during .probe().
> 
> Restore the original name before freeing it to avoid acessing already
> freed pointer.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I have now applied this one and will send it to Linus for next -rc.

If we are going down the path of using devm API, as proposed by Andy, that 
will require much more throgough review of interaction with input 
subsystem, so definitely not a late -rc regression fix material.

Thanks,

-- 
Jiri Kosina
SUSE Labs
