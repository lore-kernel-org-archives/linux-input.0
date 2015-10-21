From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 2/2] HID: wacom: Expect 'touch_max' touches if
 HID_DG_CONTACTCOUNT not present
Date: Wed, 21 Oct 2015 13:14:23 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510211311430.21100@pobox.suse.cz>
References: <1444262062-19247-1-git-send-email-killertofu@gmail.com> <1444262062-19247-2-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45874 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753964AbbJULOY (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 07:14:24 -0400
In-Reply-To: <1444262062-19247-2-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, expiredpopsicle@gmail.com, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 7 Oct 2015, Jason Gerecke wrote:

> When introduced in commit 1b5d514, the check 'if (hid_data->cc_index >= 0)'
> in 'wacom_wac_finger_pre_report' was intended to switch where the driver
> got the expected number of contacts from: HID_DG_CONTACTCOUNT if the usage
> was present, or 'touch_max' otherwise. Unfortunately, an oversight worthy
> of a brown paper bag (specifically, that 'cc_index' could never be negative)
> meant that the latter 'else' clause would never be entered.
> 
> The patch prior to this one introduced a way for 'cc_index' to be negative,
> but only if HID_DG_CONTACTCOUNT is present in some report _other_ than the
> one being processed. To ensure the 'else' clause is also entered for devices
> which don't have HID_DG_CONTACTCOUNT on _any_ report, we add the additional
> constraint that 'cc_report' be non-zero (which is true only if the usage is
> present in some report).
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> ---
> Jiri,
> 
> Could you please queue this patch and the prior for 4.3? They fix issues
> with the implementation of my "Ignore contacts in excess of declared
> contact count" patch which was pulled in as part of the 4.3 merge window.

Alright, I've applied this to for-4.3/upstream-fixes, but it's now very 
late in the cycle, so I am not 100% sure this patch will make it into 4.3. 
Hence I've added -stable annotation to it so that it's picked by first 
4.3-stable afterwards in such case.

-- 
Jiri Kosina
SUSE Labs

