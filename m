From: Jiri Kosina <jikos@kernel.org>
Subject: Re: Quanta touchscreen 0408:3003 does not work with hid-multitouch
Date: Thu, 21 Jan 2016 14:11:15 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1601211410550.21446@cbobk.fhfr.pm>
References: <CACcJrhR8iv0FKRrH7V2nbefZBLfhmr_Kn9ctg4O4bhzd_3oFnA@mail.gmail.com> <20151219174154.GC27255@dtor-ws> <20160104091034.GA20222@mail.corp.redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44017 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759071AbcAUNLT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Jan 2016 08:11:19 -0500
In-Reply-To: <20160104091034.GA20222@mail.corp.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Jim lovell <jimlovell777@gmail.com>, Jiri Kosina <jikos@jikos.cz>

On Mon, 4 Jan 2016, Benjamin Tissoires wrote:

> dmesg shows a lot of:
> [ 1374.890348] hid-multitouch 0003:0408:3003.0007: usb_submit_urb(ctrl) failed: -1
> [ 1384.916388] hid-multitouch 0003:0408:3003.0007: usb_submit_urb(ctrl) failed: -1
> [ 1384.916432] hid-multitouch 0003:0408:3003.0007: timeout initializing reports
> 
> Add the quirk and make the touchscreen happy.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.5/upstream-fixes, thanks.

-- 
Jiri Kosina
SUSE Labs

