From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: i2c-hid: force the IRQ level trigger only when
 not set
Date: Mon, 28 Nov 2016 14:43:08 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1611281442550.29400@cbobk.fhfr.pm>
References: <1479738087-3123-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39308 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932777AbcK1NnK (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 28 Nov 2016 08:43:10 -0500
In-Reply-To: <1479738087-3123-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 21 Nov 2016, Benjamin Tissoires wrote:

> Instead of forcing the level trigger of the IRQ, we can count
> on ACPI or OF to set it up for us.
> 
> The first release of the HID over I2C specification mentioned
> that the level trigger needed to be active low. In the latest
> version of the specification, there is no such explicit mention,
> so it's better to not assume one.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> ---
> 
> changes in v2:
> - reword a little the commit message (and mention that the new spec
>   doesn't requires active low anymore)
> - add missing irq.h include as per kbuild bot raised
> 
> So after the kbuild bot warning and a search in my email folder, I realised
> that the commit message should be amended too. So here is a v2 :)

Applied to for-4.10/i2c-hid. Thanks,

-- 
Jiri Kosina
SUSE Labs

