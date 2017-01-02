From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] usbhid: Add quirk for Mayflash/Dragonrise DolphinBar.
Date: Mon, 2 Jan 2017 13:21:35 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1701021321240.28985@cbobk.fhfr.pm>
References: <20161220210813.GA25699@arch-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:42372 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751651AbdABMVh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 2 Jan 2017 07:21:37 -0500
In-Reply-To: <20161220210813.GA25699@arch-desktop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Marcel Hasler <mahasler@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Tue, 20 Dec 2016, Marcel Hasler wrote:

> The DolphinBar by Mayflash (identified as Dragonrise) needs HID_QUIRK_MULTI_INPUT to split it up into
> four input devices. Without this quirk the adapter is falsely recognized as a tablet. See also bug
> 115841 (https://bugzilla.kernel.org/show_bug.cgi?id=115841).

Applied to for-4.10/upstream-fixes

-- 
Jiri Kosina
SUSE Labs

