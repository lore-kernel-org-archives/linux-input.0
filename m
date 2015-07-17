From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH 1/2] HID: wacom: Properly free inputs if 'wacom_allocate_inputs'
 fails
Date: Fri, 17 Jul 2015 11:27:59 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507171127090.1141@pobox.suse.cz>
References: <1436835825-15380-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:36155 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946AbbGQJ21 (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Fri, 17 Jul 2015 05:28:27 -0400
In-Reply-To: <1436835825-15380-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Mon, 13 Jul 2015, Jason Gerecke wrote:

> The 'wacom_allocate_inputs' function tries to allocate three input
> devices: one each for the pen, touch, and pad. The pointers that are
> returned by the 'wacom_allocate_input' calls are temporarily stored
> to local variables where they are checked to ensure they're non-null
> before storing them in the 'wacom_wac' structure. If an allocation
> fails,  the 'wacom_free_inputs' function is called to reclaim the
> memory. Unfortunately, 'wacom_free_inputs' is called prior to the
> pointers being copied, so it is not actually able to free anything.
> 
> This patch has the calls to 'wacom_allocate_input' store the pointer
> directly in the 'wacom_wac' structure where they can be freed. Also,
> it replaces the call to 'wacom_free_inputs' with the (more general)
> 'wacom_clean_inputs' and removes the no-longer-used function.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
> Jiri,
> 
> This patch should cleanly apply to either your 'for-4.3/wacom' or
> 'for-4.2/upstream-fixes' branch. It conflicts with 'for-4.3/upstream'
> where Markus' "Delete unnecessary checks" patch (67e123f) resides.
> I can provide a patch which applies cleanly to that branch instead
> if you would like. The conflict is due to his patch modifying the
> 'wacom_free_inputs' function; this patch removes the function
> entirely though so the conflict shouldn't be too difficult to resolve.

I resolved this and applied to for-4.3/wacom.

Thanks,

-- 
Jiri Kosina
SUSE Labs
