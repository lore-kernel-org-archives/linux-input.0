From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Fix reporting of touch toggle (WACOM_HID_WD_MUTE_DEVICE)
 events
Date: Tue, 23 Jan 2018 15:42:58 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1801231542430.11852@cbobk.fhfr.pm>
References: <20171226225355.27785-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50860 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751814AbeAWOnA (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 Jan 2018 09:43:00 -0500
In-Reply-To: <20171226225355.27785-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <binjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Armstrong Skomra <skomra@gmail.com>, stable@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 26 Dec 2017, Jason Gerecke wrote:

> Touch toggle softkeys send a '1' while pressed and a '0' while released,
> requring the kernel to keep track of wether touch should be enabled or
> disabled. The code does not handle the state transitions properly,
> however. If the key is pressed repeatedly, the following four states
> of states are cycled through (assuming touch starts out enabled):
> 
> Press:   shared->is_touch_on => 0, SW_MUTE_DEVICE => 1
> Release: shared->is_touch_on => 0, SW_MUTE_DEVICE => 1
> Press:   shared->is_touch_on => 1, SW_MUTE_DEVICE => 0
> Release: shared->is_touch_on => 1, SW_MUTE_DEVICE => 1
> 
> The hardware always properly enables/disables touch when the key is
> pressed but applications that listen for SW_MUTE_DEVICE events to provide
> feedback about the state will only ever show touch as being enabled while
> the key is held, and only every-other time. This sequence occurs because
> the fallthrough WACOM_HID_WD_TOUCHONOFF case is always handled, and it
> uses the value of the *local* is_touch_on variable as the value to
> report to userspace. The local value is equal to the shared value when
> the button is pressed, but equal to zero when the button is released.
> 
> Reporting the shared value to userspace fixes this problem, but the
> fallthrough case needs to update the shared value in an incompatible
> way (which is why the local variable was introduced in the first place).
> To work around this, we just handle both cases in a single block of code
> and update the shared variable as appropriate.
> 
> Fixes: d793ff8187 ("HID: wacom: generic: support touch on/off softkey")
> Cc: <stable@vger.kernel.org> # v4.12+
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Reviewed-by: Aaron Skomra <aaron.skomra@wacom.com>
> Tested-by: Aaron Skomra <aaron.skomra@wacom.com>

Applied to for-4.16/wacom.

-- 
Jiri Kosina
SUSE Labs

