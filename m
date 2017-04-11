From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/2] Support additional Xbox One pads
Date: Mon, 10 Apr 2017 20:47:19 -0700
Message-ID: <20170411034719.GE4346@dtor-ws>
References: <20170408212806.7790-1-aicommander@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34043 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbdDKDrW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 23:47:22 -0400
Content-Disposition: inline
In-Reply-To: <20170408212806.7790-1-aicommander@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Cameron Gutman <aicommander@gmail.com>
Cc: rojtberg@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 08, 2017 at 02:28:04PM -0700, Cameron Gutman wrote:
> This series adds support for several new or quirky Xbox One pads.
> With the existing code, these pads either don't send any input
> data at all, only have partial functionality, or just aren't yet
> recognized by the driver even though they would work just fine.
> 
> Patch 1 of this series may be considered a v2 for patches 1-3 of my
> previous series:
> 
>   https://lkml.org/lkml/2017/2/4/189
> 
> I'm now only sending the quirk packets to the specific gamepads that
> need them, per Dmitry's feedback on the last series.
> 
> Patch 2 is a trivial new device ID addition that I've tagged for
> stable. This one is not purely cosmetic because we won't currently
> bind to any Xbox One pads with Razer's VID without it. The Razer
> Wildcat doesn't depend on any quirk handling or newer xpad changes
> for full functionality, so it should work just fine when backported
> to stable kernels.
> 
> v2 changes:
> I've given the commit message for patch 1 some much needed TLC, as
> the old one was poorly worded and did not contain many details about
> the change.
> 
> Cameron Gutman (2):
>   Input: xpad - support some quirky Xbox One pads
>   Input: xpad - add support for Razer Wildcat gamepad
> 
>  drivers/input/joystick/xpad.c | 116 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 103 insertions(+), 13 deletions(-)

Applied, thank you.

-- 
Dmitry
