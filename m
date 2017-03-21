From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: ELAN0732 I2C Touchscreen Driver
Date: Mon, 20 Mar 2017 21:45:10 -0700
Message-ID: <CAKdAkRTnqwyjGcQjmmHxAOkWSMnADtO5WnyyndkwqP9wo_FcWw@mail.gmail.com>
References: <CALLvBir2m6iuq1ntwZU+ZTahCeHXZQ5DNUb7nPe9jSUXL-AOLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-vk0-f54.google.com ([209.85.213.54]:34770 "EHLO
        mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751742AbdCUEpM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 00:45:12 -0400
Received: by mail-vk0-f54.google.com with SMTP id z204so25976491vkd.1
        for <linux-input@vger.kernel.org>; Mon, 20 Mar 2017 21:45:11 -0700 (PDT)
In-Reply-To: <CALLvBir2m6iuq1ntwZU+ZTahCeHXZQ5DNUb7nPe9jSUXL-AOLA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: M K <m.kolesinski@gmail.com>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, =?UTF-8?B?RUxBTiDlionlmInpp78=?= <scott.liu@emc.com.tw>

On Sun, Mar 19, 2017 at 11:26 PM, M K <m.kolesinski@gmail.com> wrote:
> Is there a compatible driver for this device?  I've tried loading
> various modules with no success (elants_i2c, hid_multitouch, etc.).
>
> The device shows up under /sys/bus/i2c/devices/i2c-ELAN0732:00

You would need to add "ELAN0732" to elants_i2c_id table for elants_i2c
to load and bind to the device.

>
> However, xinput does not list it at all.
>
> This is an HP m6-ar004dx laptop (Envy x360) with touchscreen display,
> and AMD FX-9800P processor.
>
> Scott Liu suggested I try posting here.

Hmm, I'd expect Scott to know if elants_i2c could theoretically drive
this device. KT, do you know by chance?

Thanks.

-- 
Dmitry
