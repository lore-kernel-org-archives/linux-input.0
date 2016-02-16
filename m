From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: fix hid_ignore_special_drivers module parameter
Date: Tue, 16 Feb 2016 11:05:45 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1602161104400.22700@cbobk.fhfr.pm>
References: <1455293437-12088-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:55534 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754412AbcBPKFr (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Feb 2016 05:05:47 -0500
In-Reply-To: <1455293437-12088-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 12 Feb 2016, Benjamin Tissoires wrote:

> hid_ignore_special_drivers works fine until hid_scan_report
> autodetects and reassign devices (for hid-multitouch,
> hid-microsoft and hid-rmi).
> 
> Simplify the handling of the parameter: if it is there, use
> hid-generic, no matter what, and if not, scan the device or
> rely on the hid_have_special_driver table.
> 
> This was detected while trying to disable hid-multitouch on
> a Surface Pro cover which prevented to use the keyboard.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> CC: stable@vger.kernel.org
> ---
> 
> Hi Jiri,
> 
> not sure if we should keep or not the stable@ tag. The issue was there for a
> long time, and nobody complained. It's up to you.

I've now applied it to for-4.5/upstream-fixes, but will wait if there is 
any other more important fix that'd trigger the push of this branch to 
Linus; otherwise it'll go in the merge window pile and will get backported 
to -stable later.

Thanks,

-- 
Jiri Kosina
SUSE Labs

