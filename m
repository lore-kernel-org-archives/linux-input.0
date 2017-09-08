From: Jiri Kosina <jikos@kernel.org>
Subject: Re: RH Bugzilla - Bug 1482649 - Logitech USB Unified Receiver+M570
 need 'waking' up by click after kernel update
Date: Fri, 8 Sep 2017 13:05:36 +0200 (CEST)
Message-ID: <nycvar.YFH.7.76.1709081304520.3285@jbgna.fhfr.qr>
References: <VI1PR0301MB2510E2E6B5ABB1243F7C202387940@VI1PR0301MB2510.eurprd03.prod.outlook.com> <nycvar.YFH.7.76.1709081129080.3285@jbgna.fhfr.qr> <VI1PR0301MB2510E6C0647741DF9046392D87950@VI1PR0301MB2510.eurprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:54793 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751654AbdIHLFh (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 8 Sep 2017 07:05:37 -0400
In-Reply-To: <VI1PR0301MB2510E6C0647741DF9046392D87950@VI1PR0301MB2510.eurprd03.prod.outlook.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mike Simms <micsim2007@outlook.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>

On Fri, 8 Sep 2017, Mike Simms wrote:

> Thanks for getting back to me,
> 
> 4.11.11-300.fc26.x86_64 and 4.12.9-300.fc26.x86_64
>  are showing identical settings - autosuspend definitely on for
> device /sys/bus/usb/devices/2-1.3/2-1.3:1.0/0003:046D:C52B.0001/power
> 
> it shows in the powertop UI as good for both kernels and
> 
> Folder contents are autosuspend_delay_ms (can't open), control (auto),
> runtime_active_time (0), runtime_status (unsupported),
> runtime_suspended_time (0)

Alright, that means that both kernels are allowed to autosuspend the 
device, but apparently only 4.12 actually does so. Could you please 
confirm that with usbmon traces?

Thanks,

-- 
Jiri Kosina
SUSE Labs

