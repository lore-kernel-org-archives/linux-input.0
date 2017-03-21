From: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: ELAN0732 I2C Touchscreen Driver
Date: Tue, 21 Mar 2017 13:55:12 +0800
Message-ID: <001201d2a207$b4e6c8a0$1eb459e0$@emc.com.tw>
References: <CALLvBir2m6iuq1ntwZU+ZTahCeHXZQ5DNUb7nPe9jSUXL-AOLA@mail.gmail.com> <CAKdAkRTnqwyjGcQjmmHxAOkWSMnADtO5WnyyndkwqP9wo_FcWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:22953 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751668AbdCUFx2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 01:53:28 -0400
In-Reply-To: <CAKdAkRTnqwyjGcQjmmHxAOkWSMnADtO5WnyyndkwqP9wo_FcWw@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'M K' <m.kolesinski@gmail.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?B?J0VMQU4g5YqJ5ZiJ6ae/Jw==?= <scott.liu@emc.com.tw>, "'Johnny.Chuang'" <johnny.chuang@emc.com.tw>

Add Johnny who handle ELAN touchscreen in loop.

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Tuesday, March 21, 2017 12:45 PM
To: M K; 廖崇榮
Cc: linux-input@vger.kernel.org; ELAN 劉嘉駿
Subject: Re: ELAN0732 I2C Touchscreen Driver

On Sun, Mar 19, 2017 at 11:26 PM, M K <m.kolesinski@gmail.com> wrote:
> Is there a compatible driver for this device?  I've tried loading 
> various modules with no success (elants_i2c, hid_multitouch, etc.).
>
> The device shows up under /sys/bus/i2c/devices/i2c-ELAN0732:00

You would need to add "ELAN0732" to elants_i2c_id table for elants_i2c to load and bind to the device.

>
> However, xinput does not list it at all.
>
> This is an HP m6-ar004dx laptop (Envy x360) with touchscreen display, 
> and AMD FX-9800P processor.
>
> Scott Liu suggested I try posting here.

Hmm, I'd expect Scott to know if elants_i2c could theoretically drive this device. KT, do you know by chance?
Hi Johnny,
	Could you help to check this TS issue
Thanks.

--
Dmitry

