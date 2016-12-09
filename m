From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 1/2] devicetree: i2c-hid: Add regulator support
Date: Fri, 9 Dec 2016 08:23:22 -0600
Message-ID: <CAL_JsqJVVmPf40rwj+3N4RerSbn4+Xr7v8EQA42YvQidMi20yA@mail.gmail.com>
References: <1480717140-14558-1-git-send-email-briannorris@chromium.org> <alpine.LNX.2.00.1612091317000.16984@cbobk.fhfr.pm>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:37530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932427AbcLIOX5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 9 Dec 2016 09:23:57 -0500
In-Reply-To: <alpine.LNX.2.00.1612091317000.16984@cbobk.fhfr.pm>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Brian Norris <briannorris@chromium.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Caesar Wang <wxt@rock-chips.com>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Doug Anderson <dianders@chromium.org>

On Fri, Dec 9, 2016 at 6:17 AM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 2 Dec 2016, Brian Norris wrote:
>
>> From: Caesar Wang <wxt@rock-chips.com>
>>
>> Document a "vdd-supply" and an initialization delay. Can be used for
>> powering on/off a HID.
>>
>> Signed-off-by: Caesar Wang <wxt@rock-chips.com>
>> Cc: Rob Herring <robh+dt@kernel.org>
>> Cc: Jiri Kosina <jikos@kernel.org>
>> Cc: linux-input@vger.kernel.org
>> Signed-off-by: Brian Norris <briannorris@chromium.org>
>> ---
>> v2:
>>  * add compatible property for wacom, per Rob's request
>>  * name the regulator property specifically (VDD)
>>
>> v3:
>>  * remove wacom property, per Benjamin's request
>>  * add delay property
>>
>> v4: no change
>
> Applied both patches to for-4.10/i2c-hid.

In case it wasn't clear: NAK

This is still under discussion[1].

Rob

[1] https://lkml.org/lkml/2016/12/8/362
