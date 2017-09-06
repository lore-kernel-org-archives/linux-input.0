From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: leds: Don't try to control the EKR's read-only
 LEDs
Date: Wed, 6 Sep 2017 10:48:06 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061048010.4077@jbgna.fhfr.qr>
References: <1503954939-23470-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53069 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750832AbdIFIsI (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 04:48:08 -0400
In-Reply-To: <1503954939-23470-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com, benjamin.tissoires@redhat.com, stable@vger.kernel.org, Aaron Armstrong Skomra <aaron.skomra@wacom.com>

On Mon, 28 Aug 2017, Aaron Armstrong Skomra wrote:

> Commit a50aac7193f1 introduces 'led.groups' and adds EKR support
> for these groups. However, unlike the other devices with LEDs,
> the EKR's LEDs are read-only and we shouldn't attempt to control
> them in wacom_led_control().
> 
> See bug: https://sourceforge.net/p/linuxwacom/bugs/342/
> 
> Fixes: a50aac7193f1 ("HID: wacom: leds: dynamically allocate LED groups")
> Cc: stable <stable@vger.kernel.org>     # 4.9
> Signed-off-by: Aaron Armstrong Skomra <aaron.skomra@wacom.com>

Applied to for-4.14/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

