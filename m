From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 0/4] HID: fix few non-DMA capable HID transfers
Date: Wed, 23 Nov 2016 17:44:13 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611231743450.29400@cbobk.fhfr.pm>
References: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39839 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935954AbcKWQoP (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 23 Nov 2016 11:44:15 -0500
In-Reply-To: <1479725322-30863-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 21 Nov 2016, Benjamin Tissoires wrote:

> While playing a little bit with the CP2112 (for hid-rmi I must confess), I
> realized that kernel v4.9 now enforces DMA capable buffers when calling
> hid_hw_raw_request(). Kernel v4.8 works fine (but gives a stacktrace the first
> time), but v4.9 doesn't.
> 
> So I gave a check of all the other drivers in the HID tree, and it looks like
> only 4 drivers are not properly allocating their buffers.
> 
> I'd say this is v4.9 material but I was not able to test magicmouse and lg.
> If this doesn't qualifies for 4.9-rc7, I think we should add the stable@ stamp,
> given that the chance this will break hid-rmi is huge (cp2112 is not so much an
> issue, given it's a devel board).

Thanks for fixing this up. Applied to for-4.9/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

