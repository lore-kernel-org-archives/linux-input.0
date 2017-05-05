From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: Have wacom_tpc_irq guard against possible
 NULL dereference
Date: Fri, 5 May 2017 14:53:27 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705051452580.26873@cbobk.fhfr.pm>
References: <20170412203123.GA3915@mwanda> <20170425182956.15406-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49523 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752297AbdEEMx3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 May 2017 08:53:29 -0400
In-Reply-To: <20170425182956.15406-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 25 Apr 2017, Jason Gerecke wrote:

> The following Smatch complaint was generated in response to commit
> 2a6cdbd ("HID: wacom: Introduce new 'touch_input' device"):
> 
>     drivers/hid/wacom_wac.c:1586 wacom_tpc_irq()
>              error: we previously assumed 'wacom->touch_input' could be null (see line 1577)
> 
> The 'touch_input' and 'pen_input' variables point to the 'struct input_dev'
> used for relaying touch and pen events to userspace, respectively. If a
> device does not have a touch interface or pen interface, the associated
> input variable is NULL. The 'wacom_tpc_irq()' function is responsible for
> forwarding input reports to a more-specific IRQ handler function. An
> unknown report could theoretically be mistaken as e.g. a touch report
> on a device which does not have a touch interface. This can be prevented
> by only calling the pen/touch functions are called when the pen/touch
> pointers are valid.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to for-4.12/upstream-fixes branch with these tags:

    Fixes: 2a6cdbd ("HID: wacom: Introduce new 'touch_input' device")
    Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
    Reviewed-by: Ping Cheng <ping.cheng@wacom.com>
    Cc: stable@vger.kernel.org

-- 
Jiri Kosina
SUSE Labs

