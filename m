From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH input-wacom] HID: wacom: Bluetooth IRQ for Intuos Pro
 should handle prox/range
Date: Tue, 14 Feb 2017 15:03:17 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702141503040.24579@cbobk.fhfr.pm>
References: <1486772047-7903-1-git-send-email-skomra@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40567 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753258AbdBNODW (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 14 Feb 2017 09:03:22 -0500
In-Reply-To: <1486772047-7903-1-git-send-email-skomra@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Armstrong Skomra <skomra@gmail.com>
Cc: linux-input@vger.kernel.org, pinglinux@gmail.com, killertofu@gmail.com, Jason Gerecke <jason.gerecke@wacom.com>

On Fri, 10 Feb 2017, Aaron Armstrong Skomra wrote:

> From: Jason Gerecke <killertofu@gmail.com>
> 
> The prox/range bits included in the Bluetooth reports from the Intuos Pro
> were being ignored, leading to two issues. Firstly, the pen would never
> announce a BTN_TOOL_PEN event with value 0, leaving userspace to believe
> the pen was always active. Secondly, the driver would continue to send
> events for data while the packet's "prox" bit was clear. This can lead
> to sudden incorrect pointer jumps if the pen is slowly moved away from
> the tablet surface.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

Applied to hid.git#for-4.11/wacom

-- 
Jiri Kosina
SUSE Labs

