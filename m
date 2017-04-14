From: Christian Gmeiner <christian.gmeiner@gmail.com>
Subject: Re: [PATCH v2] Input: ar1021-i2c - fix too long name in driver's
 device table
Date: Fri, 14 Apr 2017 07:38:58 +0200
Message-ID: <CAH9NwWdvc_D8f4S6aH1SkKCqgoit8KAqrDQLAonTbAk-Ovcbcw@mail.gmail.com>
References: <20170413233225.GA30465@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:35605 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbdDNFjU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 14 Apr 2017 01:39:20 -0400
In-Reply-To: <20170413233225.GA30465@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Wolfram Sang <wsa@the-dreams.de>, Jean Delvare <jdelvare@suse.com>, m.frohiky@gmail.com, LKML <linux-kernel@vger.kernel.org>

2017-04-14 1:32 GMT+02:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> The name field in structure i2c_device_id is 20 characters, and we expect
> it to be NULL-terminated, however we are trying to stuff it with 21 bytes
> and thus NULL-terminator is lost. This causes issues when one creates
> device with name "MICROCHIP_AR1021_I2C" as i2c core cuts off the last "C",
> and automatic module loading by alias does not work as result.
>
> The -I2C suffix in the device name is superfluous, we know what bus we are
> dealing with, so let's drop it. Also, no other driver uses capitals, and
> the manufacturer name is normally not included, except in very rare cases
> of incompatible name collisions.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=116211
> Fixes: dd4cae8bf166 ("Input: Add Microchip AR1021 i2c touchscreen")
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-By: Christian Gmeiner <christian.gmeiner@gmail.com>

greets
--
Christian Gmeiner, MSc

https://www.youtube.com/user/AloryOFFICIAL
https://soundcloud.com/christian-gmeiner
