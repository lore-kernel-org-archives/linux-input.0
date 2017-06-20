From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] Revert "HID: magicmouse: Set multi-touch keybits for
 Magic Mouse"
Date: Tue, 20 Jun 2017 10:38:58 +0200 (CEST)
Message-ID: <alpine.LSU.2.20.1706201038460.30709@cbobk.fhfr.pm>
References: <20170615123550.20661-1-daniels@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:37236 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751082AbdFTIjB (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 04:39:01 -0400
In-Reply-To: <20170615123550.20661-1-daniels@collabora.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Stone <daniels@collabora.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Che-Liang Chiou <clchiou@chromium.org>, Thierry Escande <thierry.escande@collabora.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

On Thu, 15 Jun 2017, Daniel Stone wrote:

> Setting these bits causes libinput to fail to initialize the device;
> setting BTN_TOUCH and BTN_TOOL_FINGER causes it to treat the mouse as a
> touchpad, and it then refuses to continue when it discovers ABS_X is not
> set.
> 
> This breaks all known Wayland compositors, as well as Xorg when the
> libinput driver is being used.
> 
> This reverts commit f4b65b9563216b3e01a5cc844c3ba68901d9b195.

Queued for 4.12. Thanks,

-- 
Jiri Kosina
SUSE Labs

