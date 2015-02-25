From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH 3/3] HID: rmi: disable palm detect gesture when present
Date: Wed, 25 Feb 2015 10:09:23 +0100
Message-ID: <18750379.9qMEg0zBWE@xps13>
References: <1424828210-18972-1-git-send-email-aduggan@synaptics.com> <1424828210-18972-3-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-we0-f175.google.com ([74.125.82.175]:35592 "EHLO
	mail-we0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbBYJJg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Feb 2015 04:09:36 -0500
In-Reply-To: <1424828210-18972-3-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Tuesday 24 February 2015 17:36:50 Andrew Duggan wrote:
> A touchpad may have firmware based palm detection code enabled which
> suppresses 2D data from being reported when the firmware believes a palm is
> on the touchpad. This functionality is meant to be used in mouse mode without
> a driver. When a driver is present, the driver can do a better job of
> determining if a contact is a palm. If this gesture is enabled on a touchpad
> operating in rmi mode then the firmware will not properly clear the palm detect
> interrupt, causing the touchpad to interrupt indefinately. This patch disables
> the palm detect gesture when the touchpad is operating in rmi mode.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>
> ---
> Hi Gabriele,
> 
> Can you test this patch on your system to confirm that it fixes your issue?
> I was able to test the  other two patches so I can confirm that the write
> fuction works. But, I don't have a touchpad with the palm detect gesture
> enabled so it would be good to double check that I have the right address and
> mask.
> 
> Andrew

I tested it and confirm that it's working. Thanks.

Gabriele
