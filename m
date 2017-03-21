From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: clamp input to logical range if no null state
Date: Tue, 21 Mar 2017 14:54:41 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703211454240.31814@cbobk.fhfr.pm>
References: <20170314132913.9730-1-tk@the-tk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:33793 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757380AbdCUNy5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 09:54:57 -0400
In-Reply-To: <20170314132913.9730-1-tk@the-tk.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tomasz Kramkowski <tk@the-tk.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 14 Mar 2017, Tomasz Kramkowski wrote:

> This patch fixes an issue in drivers/hid/hid-input.c where values
> outside of the logical range are not clamped when "null state" bit of
> the input control is not set.
> 
> This was discussed on the lists [1] and this change stems from the fact
> due to the ambiguity of the HID specification it might be appropriate to
> follow Microsoft's own interpretation of the specification. As noted in
> Microsoft's documentation [2] in the section titled "Required HID usages
> for digitizers" it is noted that values reported outside the logical
> range "will be considered as invalid data and the value will be changed
> to the nearest boundary value (logical min/max)."
> 
> This patch fixes an issue where the (1292:4745) Innomedia INNEX
> GENESIS/ATARI reports out of range values for its X and Y axis of the
> DPad which, due to the null state bit being unset, are forwarded to
> userspace as is. Now these values will get clamped to the logical range
> before being forwarded to userspace. This device was also used to test
> this patch.
> 
> This patch expands on commit 3f3752705dbd ("HID: reject input outside
> logical range only if null state is set").
> 
> Signed-off-by: Tomasz Kramkowski <tk@the-tk.com>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

I've added the forgotten references and applied to 
for-4.12/hid-core-null-state-handling. Thanks,

-- 
Jiri Kosina
SUSE Labs

