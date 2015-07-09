From: Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH] HID: rmi: Disable scanning if the device is not a wake
 source
Date: Thu, 9 Jul 2015 14:27:10 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1507091426570.10183@pobox.suse.cz>
References: <1436226511-13138-1-git-send-email-aduggan@synaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:57172 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753033AbbGIM1N (ORCPT
	<rfc822;groupwise-linux-input@vger.kernel.org:0:0>);
	Thu, 9 Jul 2015 08:27:13 -0400
In-Reply-To: <1436226511-13138-1-git-send-email-aduggan@synaptics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Gabriele Mazzotta <gabriele.mzt@gmail.com>

On Mon, 6 Jul 2015, Andrew Duggan wrote:

> Some touchpads are configured with firmware which continues to scan for
> fingers at a minimal scan rate even after receiving the HID power sleep
> command. This allows a finger touching the touchpad to genrate a wake
> event. This patch ensures that scanning is disabled if the touchpad is
> not a wake source and ensures scanning is enabled on resume.
> 
> Signed-off-by: Andrew Duggan <aduggan@synaptics.com>

Applied to for-4.3/rmi.

Thanks,

-- 
Jiri Kosina
SUSE Labs
