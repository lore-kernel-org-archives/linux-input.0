From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: rmi: Set F01 interrupt enable register when not
 set
Date: Fri, 17 Jul 2015 11:31:47 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507171131170.1141@pobox.suse.cz>
References: <1437092040-25857-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:44349 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755463AbbGQJb5 (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Fri, 17 Jul 2015 05:31:57 -0400
In-Reply-To: <1437092040-25857-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, 16 Jul 2015, Andrew Duggan wrote:

> A firmware bug in some touchpads causes the F01 interrupt enable register
> to be cleared on reset. This register controls which RMI functions generate
> interrupts and when it is cleared, the touchpad stops reporting all data.
> This patch looks for the cleared F01 control register and writes the
> correct value based on interrupt mask computed while scanning the PDT.
> 
> Fixes:
> https://bugs.freedesktop.org/show_bug.cgi?id=91102
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to for-4.3/rmi.

-- 
Jiri Kosina
SUSE Labs
