From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] hid-chicony: Add support for another ASUS Zen AiO
 keyboard
Date: Mon, 6 Mar 2017 14:13:34 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1703061413190.31814@cbobk.fhfr.pm>
References: <20170217134052.440-1-drake@endlessm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:58274 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753206AbdCFN0M (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 6 Mar 2017 08:26:12 -0500
In-Reply-To: <20170217134052.440-1-drake@endlessm.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <drake@endlessm.com>
Cc: benjamin.tissoires@redhat.com, linux-input@vger.kernel.org, linux@endlessm.com

On Fri, 17 Feb 2017, Daniel Drake wrote:

> Add support for media keys on the keyboard that comes with the
> Asus V221ID and ZN241IC All In One computers.
> 
> The keys to support here are WLAN, BRIGHTNESSDOWN and BRIGHTNESSUP.
> 
> This device is not visibly branded as Chicony, and the USB Vendor ID
> suggests that it is a JESS device. However this seems like the right place
> to put it: the usage codes are identical to the currently supported
> devices, and this driver already supports the ASUS AIO keyboard AK1D.
> 
> Signed-off-by: Daniel Drake <drake@endlessm.com>

Applied to for-4.11/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

