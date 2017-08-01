From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v4] HID: Remove the semaphore driver_lock
Date: Tue, 1 Aug 2017 13:17:27 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1708011317160.30597@cbobk.fhfr.pm>
References: <1497425391-7188-1-git-send-email-binoy.jayan@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44422 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751217AbdHALRa (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 1 Aug 2017 07:17:30 -0400
In-Reply-To: <1497425391-7188-1-git-send-email-binoy.jayan@linaro.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Binoy Jayan <binoy.jayan@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Rajendra <rnayak@codeaurora.org>, Mark Brown <broonie@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, David Herrmann <dh.herrmann@googlemail.com>, Andrew de los Reyes <adlr@chromium.org>

On Wed, 14 Jun 2017, Binoy Jayan wrote:

> The semaphore 'driver_lock' is used as a simple mutex, and
> also unnecessary as suggested by Arnd. Hence removing it, as
> the concurrency between the probe and remove is already
> handled in the driver core.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Binoy Jayan <binoy.jayan@linaro.org>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Reviewed-by: David Herrmann <dh.herrmann@gmail.com>
> ---
> 
> v3 --> v4:
> Changed title
> 
> v2 --> v3:
> Removed reference to driver_lock in comments
> 
> v1 --> v2:
> Removed driver_lock

Applied to hid.git#for-4.14/driver-lock-removal. Thanks,

-- 
Jiri Kosina
SUSE Labs

