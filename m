From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: don't apply generic settings to old
 devices
Date: Fri, 3 Feb 2017 14:44:06 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702031443520.4763@cbobk.fhfr.pm>
References: <1485819649-8057-1-git-send-email-pingc@wacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:59341 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753280AbdBCNoI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 3 Feb 2017 08:44:08 -0500
In-Reply-To: <1485819649-8057-1-git-send-email-pingc@wacom.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, killertofu@gmail.com, Ping Cheng <pingc@wacom.com>, Ping Cheng <ping.cheng@wacom.com>

On Mon, 30 Jan 2017, Ping Cheng wrote:

> Non-generic devices have numbered_buttons set for both pen and
> touch interfaces by default. The actual number of buttons on the
> interface is normally manually decided later, which is different
> from what those HID generic devices are processed, where number
> of buttons are directly retrieved from HID descriptors.
> 
> This patch adds the missed HID_GENERIC check and moves the statement
> to wacom_setup_pad_input_capabilities since it's not a quirk anymore.

Applied to for-4.11/wacom.

-- 
Jiri Kosina
SUSE Labs

