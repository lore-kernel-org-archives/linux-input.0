From: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Subject: Re: ELAN0732 I2C Touchscreen Driver
Date: Tue, 21 Mar 2017 10:01:00 -0700
Message-ID: <20170321170100.GA32539@dtor-ws>
References: <CALLvBir2m6iuq1ntwZU+ZTahCeHXZQ5DNUb7nPe9jSUXL-AOLA@mail.gmail.com>
 <CAKdAkRTnqwyjGcQjmmHxAOkWSMnADtO5WnyyndkwqP9wo_FcWw@mail.gmail.com>
 <002101d2a206$d5212b70$7f638250$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36682 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933396AbdCURBF (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 21 Mar 2017 13:01:05 -0400
Received: by mail-pf0-f181.google.com with SMTP id o126so82372664pfb.3
        for <linux-input@vger.kernel.org>; Tue, 21 Mar 2017 10:01:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <002101d2a206$d5212b70$7f638250$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?utf-8?B?5YqJ5ZiJ6ae/?= <scott.liu@emc.com.tw>
Cc: 'M K' <m.kolesinski@gmail.com>, =?utf-8?B?J+W7luW0h+amric=?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, james.chen@emc.com.tw

On Tue, Mar 21, 2017 at 01:48:57PM +0800, 劉嘉駿 wrote:
> As far as I known, It is hidi2c device and not be supported by elants_i2c module.
> elants_i2c module is for chrome i2c device.
> 
> I supposed hidi2c driver can support this device but don't know why it doesn't work?

i2c-hid driver binds to ACPI0C50 or PNP0C50 devices. MK, could you
please post snippet of your DTSD with ELAN0732 device?

> 
> Thanks,
> Scott
> 
> -----Original Message-----
> From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
> Sent: Tuesday, March 21, 2017 12:45 PM
> To: M K; 廖崇榮
> Cc: linux-input@vger.kernel.org; ELAN 劉嘉駿
> Subject: Re: ELAN0732 I2C Touchscreen Driver
> 
> On Sun, Mar 19, 2017 at 11:26 PM, M K <m.kolesinski@gmail.com> wrote:
> > Is there a compatible driver for this device?  I've tried loading 
> > various modules with no success (elants_i2c, hid_multitouch, etc.).
> >
> > The device shows up under /sys/bus/i2c/devices/i2c-ELAN0732:00
> 
> You would need to add "ELAN0732" to elants_i2c_id table for elants_i2c to load and bind to the device.
> 
> >
> > However, xinput does not list it at all.
> >
> > This is an HP m6-ar004dx laptop (Envy x360) with touchscreen display, 
> > and AMD FX-9800P processor.
> >
> > Scott Liu suggested I try posting here.
> 
> Hmm, I'd expect Scott to know if elants_i2c could theoretically drive this device. KT, do you know by chance?
> 
> Thanks.
> 
> --
> Dmitry
> 

-- 
Dmitry
