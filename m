From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH] Input - mt: Fix input_mt_get_slot_by_key
Date: Tue, 03 Feb 2015 20:30:16 +0100
Message-ID: <54D121C8.80206@bitmath.org>
References: <1422982530-4906-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay2.public.one.com ([91.198.169.125]:54682 "EHLO
	mailrelay2.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756193AbbBCTaW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Feb 2015 14:30:22 -0500
In-Reply-To: <1422982530-4906-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Benjamin,

> Slot 0 is released correclty, but when we look for Contact ID 2, the slot
> 0 is then picked up again because it is marked as inactive (trackingID < 0).
> 
> This is wrong, and we should not reuse a slot in the same frame.
> The test should also check for input_mt_is_used().

Good catch! However...

> @@ -453,7 +456,7 @@ int input_mt_get_slot_by_key(struct input_dev *dev, int key)
>  			return s - mt->slots;
>  
>  	for (s = mt->slots; s != mt->slots + mt->num_slots; s++)
> -		if (!input_mt_is_active(s)) {
> +		if (!input_mt_is_active(s) && !input_mt_is_used(mt, s)) {
>  			s->key = key;
>  			return s - mt->slots;
>  		}
> 

Here, you are changing the preconditions of the function without explicit
reference to all its users. For one, it is now assumed that input_mt_is_used()
is up-to-date, which requires either input_mt_drop_unused() or
input_mt_sync_frame(), which does not seem to be true for all users of
input_mt_get_slot_by_key(). After a couple of iterations with
input_mt_report_slot_state() in those drivers, input_mt_is_used() will be true
for all slots, and the driver will stop working.

How about defering the deassignments until the end of the loop instead? That
would remove possible reuse.

Thanks,
Henrik

