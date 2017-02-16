From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 1/2] devicetree: i2c-hid: Add regulator support
Date: Wed, 15 Feb 2017 20:12:58 -0600
Message-ID: <20170216021258.wo77aj56q7osfhph@rob-hp-laptop>
References: <20170210020357.10679-1-briannorris@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34175 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752980AbdBPCNA (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Feb 2017 21:13:00 -0500
Content-Disposition: inline
In-Reply-To: <20170210020357.10679-1-briannorris@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Brian Norris <briannorris@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Caesar Wang <wxt@rock-chips.com>, linux-rockchip@lists.infradead.org, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>

On Thu, Feb 09, 2017 at 06:03:56PM -0800, Brian Norris wrote:
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
> Sorry for the delay on resending this. I *think* I've addressed all the
> concerns from last time though?
> 
> v2:
>  * add compatible property for wacom, per Rob's request
>  * name the regulator property specifically (VDD)
> 
> v3:
>  * remove wacom property, per Benjamin's request
>  * add delay property
> 
> v4: no change
> 
> v5:
>  * change name to "post-power-on-delay-ms"
>  * reword to describe how the power sequencing properties require a
>    specific 'compatible' property
> ---
>  Documentation/devicetree/bindings/input/hid-over-i2c.txt | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Acked-by: Rob Herring <robh@kernel.org> 
