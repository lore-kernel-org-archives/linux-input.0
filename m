From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: [PATCHv2] HID: sony: Send FF commands in non-atomic context
Date: Tue, 19 Nov 2013 09:38:21 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1311190938020.6919@pobox.suse.cz>
References: <1384682880-5960-1-git-send-email-sven@narfation.org> <1384717101-7027-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42585 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141Ab3KSIiZ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Nov 2013 03:38:25 -0500
In-Reply-To: <1384717101-7027-1-git-send-email-sven@narfation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-input@vger.kernel.org, simon@mungewell.org

On Sun, 17 Nov 2013, Sven Eckelmann wrote:

> The ff_memless has a timer running which gets run in an atomic context and
> calls the play_effect callback. The callback function for sony uses the
> hid_output_raw_report (overwritten by sixaxis_usb_output_raw_report) function
> to handle differences in the control message format. It is not safe for an
> atomic context because it may sleep later in usb_start_wait_urb.
> 
> This "scheduling while atomic" can cause the system to lock up. A workaround is
> to make the force feedback state update using work_queues and use the
> play_effect function only to enqueue the work item.
> 
> Reported-by: Simon Wood <simon@mungewell.org>
> Reported-by: David Herrmann <dh.herrmann@gmail.com>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> ---
> This patch can replace
>  'Revert "HID: sony: Add force feedback support for Dualshock3 USB"'
> 
> It doesn't contain the command changes from <2014555.nmU692BQMt@sven-desktop>.
> It would be nice when Simon Wood could test it again with his Intec Wired
> controller. When it doesn't work:
> 
>  * Try to change to usb_interrupt_msg instead of sc->hdev->hid_output_raw_report
>  * Send a interrupt message using buf[10] = 0x02
>    (only when buf[3] != 0 || buf[5] != 0) followed by a message with
>    buf[10] = 0x1e (always)

Now applied for 3.13. Thanks.

-- 
Jiri Kosina
SUSE Labs
