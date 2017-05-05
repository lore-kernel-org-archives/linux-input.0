From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: magicmouse: Set multi-touch keybits for Magic
 Mouse
Date: Fri, 5 May 2017 15:32:09 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1705051531550.26873@cbobk.fhfr.pm>
References: <1491552756-9933-1-git-send-email-thierry.escande@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53348 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752297AbdEENcL (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 5 May 2017 09:32:11 -0400
In-Reply-To: <1491552756-9933-1-git-send-email-thierry.escande@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Thierry Escande <thierry.escande@collabora.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 7 Apr 2017, Thierry Escande wrote:

> From: Che-Liang Chiou <clchiou@chromium.org>
> 
> The driver emits multi-touch events for Magic Trackpad as well as Magic
> Mouse, but it does not set keybits that are related to multi-touch event
> for Magic Mouse; so set these keybits.
> 
> The keybits that are not set cause trouble because user programs often
> probe these keybits for self-configuration and thus they cannot operate
> properly if the keybits are not set.
> 
> One of such troubles is that libevdev will not be able to emit correct
> touch count, causing gestures library failed to do fling stop.
> 
> Signed-off-by: Che-Liang Chiou <clchiou@chromium.org>
> Signed-off-by: Thierry Escande <thierry.escande@collabora.com>

Applied to for-4.12/upstream-fixes. Thanks,

-- 
Jiri Kosina
SUSE Labs

