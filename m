From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid: Microsoft Win8 Wireless Radio Controls cleanup
Date: Mon, 22 May 2017 14:48:30 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705221448200.26873@cbobk.fhfr.pm>
References: <20170511171111.11839-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54707 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756387AbdEVMsc (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 22 May 2017 08:48:32 -0400
In-Reply-To: <20170511171111.11839-1-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Thu, 11 May 2017, Hans de Goede wrote:

> Use a better URL for the HUTRR40 Radio HID Usages documentation and
> use the HID_GD_WIRELESS_RADIO_CTLS define rather then hardcoding
> a check for 0x0001000c.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Applied to for-4.13/ite. Thanks,

-- 
Jiri Kosina
SUSE Labs

