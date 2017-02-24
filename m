From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: sony: Fix input device leak when connecting a DS4
 twice using USB/BT
Date: Fri, 24 Feb 2017 08:02:03 +0100 (CET)
Message-ID: <alpine.LSU.2.20.1702240801260.24579@cbobk.fhfr.pm>
References: <20170223235613.5112-1-roderick@gaikai.com> <20170223235613.5112-2-roderick@gaikai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:36827 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751005AbdBXHNn (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Feb 2017 02:13:43 -0500
In-Reply-To: <20170223235613.5112-2-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Roderick Colenbrander <roderick@gaikai.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Simon Wood <simon@mungewell.org>, Frank Praznik <frank.praznik@gmail.com>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

On Thu, 23 Feb 2017, Roderick Colenbrander wrote:

> From: Roderick Colenbrander <roderick.colenbrander@sony.com>
> 
> When a user connects a DS4 twice using USB and BT, we reject the
> second device connection after the setup work. We then perform
> a cleanup, but during cleanup we are not removing the touchpad
> device. This leads to leakage of an input device, which we would
> never remove. It can likely result into a kernel oops as well
> when the touchpad evdev node is accessed and the underlaying HID
> device has been removed from the system.

Hi Roderick,

thanks for the fix. Could you please ammend and resend with:

- proper Signed-off-by: line
- ideally 'Fixes:' tag as well

Thanks,

-- 
Jiri Kosina
SUSE Labs

