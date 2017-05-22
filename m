From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2] HID: asus: Add support for T100 keyboard
Date: Mon, 22 May 2017 13:57:23 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705221357120.26873@cbobk.fhfr.pm>
References: <20170515073141.17136-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:46856 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1758217AbdEVL52 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 May 2017 07:57:28 -0400
In-Reply-To: <20170515073141.17136-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Mon, 15 May 2017, Hans de Goede wrote:

> The keyboard dock used with the Asus Transformer T100 series, uses
> the same vendor-defined 0xff31 usage-page as some other Asus
> keyboards. But with a small twist, it has a small descriptor bug which
> needs to be fixed up for things to work.
> 
> This commit adds the USB-ID for this keyboard to the hid-asus driver
> and makes asus_report_fixup fix the descriptor issue, fixing
> various special function keys on this keyboard not working.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-4.12/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

