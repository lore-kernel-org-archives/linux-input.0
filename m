From: simon@mungewell.org
Subject: Re: Re: [PATCH] HID: sony: Add force feedback support for Dualshock3
 USB
Date: Sun, 17 Nov 2013 12:38:43 -0500
Message-ID: <35271d19bf566dcc8d07fdb07d3c5830.squirrel@mungewell.org>
References: <1384021557-24106-1-git-send-email-sven@narfation.org>
    <f26febe04a776d22c913ed3ade3a8d90.squirrel@mungewell.org>
    <1567991.TNa7UhjX8Q@sven-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:57573 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab3KQRiq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 17 Nov 2013 12:38:46 -0500
In-Reply-To: <1567991.TNa7UhjX8Q@sven-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sven Eckelmann <sven@narfation.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Colin Leitner <colin.leitner@gmail.com>


> So it is a bad choice to use hid_output_raw_report (which calls
> usb_control_msg) in a ff_memless control function. I will just send a
> revert
> patch in some minutes.

Rather than revert, can't we just replace the raw call with
'hid_hw_request()' to send the data?

This is what we have in hid-lg4ff:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/hid/hid-lg4ff.c?id=refs/tags/v3.12#n402

Simon

