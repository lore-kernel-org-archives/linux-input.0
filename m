From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] devicetree: i2c-hid: Add regulator support
Date: Fri, 9 Dec 2016 13:17:28 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1612091317000.16984@cbobk.fhfr.pm>
References: <1480717140-14558-1-git-send-email-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1480717140-14558-1-git-send-email-briannorris@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, Rob Herring <robh+dt@kernel.org>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>
List-Id: linux-input@vger.kernel.org

On Fri, 2 Dec 2016, Brian Norris wrote:

> From: Caesar Wang <wxt@rock-chips.com>
> 
> Document a "vdd-supply" and an initialization delay. Can be used for
> powering on/off a HID.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
> v2:
>  * add compatible property for wacom, per Rob's request
>  * name the regulator property specifically (VDD)
> 
> v3:
>  * remove wacom property, per Benjamin's request
>  * add delay property
> 
> v4: no change

Applied both patches to for-4.10/i2c-hid.

Thanks,

-- 
Jiri Kosina
SUSE Labs
