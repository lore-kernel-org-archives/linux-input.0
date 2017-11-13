From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Support for additional properties in touchscreen.h
Date: Mon, 13 Nov 2017 14:13:38 -0800
Message-ID: <CAKdAkRS5v8fcL7qzNQxCoos9TxxmTFSArXUcNDjTetVBFcwvAw@mail.gmail.com>
References: <00f3838a-455a-574b-5a7a-c494cd39e36a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:53515 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752421AbdKMWNk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 13 Nov 2017 17:13:40 -0500
Received: by mail-vk0-f49.google.com with SMTP id k195so11021517vke.10
        for <linux-input@vger.kernel.org>; Mon, 13 Nov 2017 14:13:40 -0800 (PST)
In-Reply-To: <00f3838a-455a-574b-5a7a-c494cd39e36a@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Gregor Riepl <onitake@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Hans de Goede <j.w.r.degoede@gmail.com>

Hi Gregor,

On Sat, Nov 11, 2017 at 6:34 AM, Gregor Riepl <onitake@gmail.com> wrote:
> Hi,
>
> I was discussing jitter problems with a Silead touchscreen user today.
> This is a general issue that should be solved on the hardware or firmware
> level, but as we don't have a way to modify either for Silead controllers, I
> was thinking that there might be a way to apply interpolation in the driver.
>
> input_set_abs_params has fuzz and flat parameters, perhaps these can be used
> for that purpose? Is there a better way to do interpolation?
>
> Would it make sense to add corresponding jitter_x and jitter_y parameters to
> include/linux/input/touchscreen.h ?

The fuzz (smoothing the output coordinates) is done in input core and
the touchscreen properties parsing code already handles
touchscreen-fuzz-x and touchscreen-fuzz-y parameters. The only thing
that is needed is to pass these parameters through DT or ACPI or
static properties, based on particular device.

Thanks.

-- 
Dmitry
