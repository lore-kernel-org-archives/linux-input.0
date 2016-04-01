From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: multitouch: Synchronize MT frame on reset_resume
Date: Fri, 1 Apr 2016 11:35:37 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1604011135030.16158@cbobk.fhfr.pm>
References: <1459282241-25154-1-git-send-email-gabriele.mzt@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43592 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752899AbcDAJfk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Apr 2016 05:35:40 -0400
In-Reply-To: <1459282241-25154-1-git-send-email-gabriele.mzt@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, bleung@chromium.org

On Tue, 29 Mar 2016, Gabriele Mazzotta wrote:

> input_mt_get_slot_by_key() requires input_mt_sync_frame() to be called
> at each frame. Do it when releasing the touches, or else we won't get
> a proper slot number after mt_reset_resume().
> 
> Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>

Queued for 4.6. Thanks,

-- 
Jiri Kosina
SUSE Labs

