From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v2 1/2] HID: wacom: Properly report negative values from
 Intuos Pro 2 Bluetooth
Date: Wed, 6 Sep 2017 11:02:01 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709061101490.4077@jbgna.fhfr.qr>
References: <CANRwn3Qt4wr4dSi2=diw_5Yh2w67TpW6zxgUY+csZLzykgqGXA@mail.gmail.com> <20170830221326.15877-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54014 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752070AbdIFJCD (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 6 Sep 2017 05:02:03 -0400
In-Reply-To: <20170830221326.15877-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, stable@vger.kernel.org, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Wed, 30 Aug 2017, Jason Gerecke wrote:

> The wacom driver's IRQ handler for Bluetooth reports from the 2nd-gen
> Intuos Pro does not correctly process negative numbers. Values for
> tilt and rotation (which can go negative) are instead interpreted as
> unsigned and so jump to very large values when the data should be
> negative. This commit properly casts the data to ensure we report
> negative numbers when necessary.
> 
> Fixes: 4922cd2 ("HID: wacom: Support 2nd-gen Intuos Pro's Bluetooth classic interface")
> Cc: stable@vger.kernel.org # v4.11
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Both patches applied to for-4.14/upstream-fixes.

-- 
Jiri Kosina
SUSE Labs

