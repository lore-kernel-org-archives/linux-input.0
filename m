From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Revert "Input: trackpoint - add new trackpoint firmware
 ID"
Date: Thu, 4 Jan 2018 16:56:59 -0800
Message-ID: <20180105005659.j2x56opkq74wm7v2@dtor-ws>
References: <20171230152213.GA2099@marax.lan.yath.de>
 <dcfb84c8-4ad8-8276-5451-ee91fc84f742@canonical.com>
 <20171231082646.GC25965@kroah.com>
 <901a0a66-eb83-9dcd-658c-5b09eabcab88@canonical.com>
 <20180102070811.p7gfaq3vr55sdbd3@dtor-ws>
 <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pl0-f47.google.com ([209.85.160.47]:32986 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeAEA5C (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 Jan 2018 19:57:02 -0500
Received: by mail-pl0-f47.google.com with SMTP id 1so2106662plv.0
        for <linux-input@vger.kernel.org>; Thu, 04 Jan 2018 16:57:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <ac087ae7-54d4-d038-daa7-048c87368d17@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>, linux-input@vger.kernel.org

Hi Aaron,

On Tue, Jan 02, 2018 at 09:57:55PM +0800, Aaron Ma wrote:
> No, it is not a regression of this commit.
> 
> ThinkPad X1 Yoga 2nd:
>    trackpoint (ID: 01)
> 
> ThinkPad X1 Yoga 3rd:
>    trackpoint (ID: 03)
> 
> Both laptop's trackpoints have the same behavior.
> Writing "speed" of sysfs is failed.
> 
> Override the ID and force loading drivers/input/mouse/elantech.c,
> it causes too many failure and trackpoint stops work.

Right, because it does not support Elantech *touchpad* protocol, that is
not a surprise.

> 
> The ID of "2.4.18 READ SECONDARY ID (x"E1")" in TrackPoint specification
> does not indicate any other vendors but only trackpoint.

Exactly. If ID does not match, it is not an IBM trackpoint device.

> Elantech uses 0x03e9.
> ALPS uses 0x00e6/0x00e7/0x00ec.
> 
> Maybe the windows tool's is wrong like Linux driver before.

I am not sure what you mean by that.

Anyway, I played with my Carbons a bit, and it seems that the patch
should indeed be reverted. I believe that neither the Elantech nor ALPS
trackpoints support the IBM trackpoint protocol; none of the extended
features (sensitivity, inertia, etc) work when we register them as
TTPS/2 devices. They should continue to be registered as "Generic PS/2"
as that's that they support.

I understand that you want scroll mode working with trackpoints, but
forcing them to pretend that they are TTPS/2 devices is not the proper
way of doing that. Write udev rules that would set
ID_INPUT_POINTINGSTICK property on all input devices connected to a
pass-through serio ports on LENOVO devices, and you should be set (just
make sure you cover both PS/2 pass-through and RMI pass-through
options).

Thanks.

-- 
Dmitry
