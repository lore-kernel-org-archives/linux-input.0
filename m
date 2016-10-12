From: sergk sergk2mail <sergk.admin@gmail.com>
Subject: Re: Goodix touchscreen works intermittently, fails reading config info.
Date: Wed, 12 Oct 2016 19:48:41 +0000
Message-ID: <CA+V1LzocE8puhgypjZ4GFpjC=UOx=y9mDVLEEJcZq_SsLTekgg@mail.gmail.com>
References: <CAG=1usadh8HwmBxBUhvB5mHuvy6Yiqj7CR5Niqeya00TQFSrZQ@mail.gmail.com>
 <CAG=1usZt447=qz2_DHRpKa67tgMnuvArZ2_k4wTBHru8jm0i5w@mail.gmail.com> <1F3AC3675D538145B1661F571FE1805F2F33C657@irsmsx105.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f172.google.com ([209.85.220.172]:36082 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755295AbcJLTsm (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Oct 2016 15:48:42 -0400
Received: by mail-qk0-f172.google.com with SMTP id o68so97325159qkf.3
        for <linux-input@vger.kernel.org>; Wed, 12 Oct 2016 12:48:42 -0700 (PDT)
In-Reply-To: <1F3AC3675D538145B1661F571FE1805F2F33C657@irsmsx105.ger.corp.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Tirdea, Irina" <irina.tirdea@intel.com>
Cc: Brad Baker <bbaker6212@gmail.com>, bastien nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hello from ;-) Chuwi tablets warrior.
Actually have done all requested, .cfg, bin, working module, etc are
located : https://gitlab.com/SergK/chuwi_hi12/tree/master.

Many thanks and regards,
                             Serge Kolotylo.


On Wed, Sep 14, 2016 at 9:29 AM, Tirdea, Irina <irina.tirdea@intel.com> wrote:
>
>
>> -----Original Message-----
>> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Brad Baker
>> Sent: 13 September, 2016 6:05
>> To: Tirdea, Irina
>> Cc: bastien nocera; linux-input@vger.kernel.org
>> Subject: Re: Goodix touchscreen works intermittently, fails reading config info.
>>
>> Irina, a little more info on the symptoms. The user reports the
>> touchscreen works when restarting but fails when powering on.  He says
>> pretty much 100% of the time.  The log is the same...
>>
>
> Hi Brad,
>
> Thanks for all the information you provided. I have already replied on the
> Bugzilla thread with some patches that enable reset for the device.
>
> Regards,
> Irina
>
>
>> http://pastebin.com/25haaPQd
>> [   10.246074] goodix_backport: loading out-of-tree module taints kernel.
>> [   10.246172] goodix_backport: module verification failed: signature
>> and/or required key missing - tainting kernel
>> [   10.263788] Goodix-TS i2c-GDIX1001:00: ID 9111, version: 1060
>> [   10.270135] Goodix-TS i2c-GDIX1001:00: dev_info: cfg_len: 186,
>> x_max: 0, y_max: 0, touch_num: 0, trigger_type: 0
>> [   10.270141] Goodix-TS i2c-GDIX1001:00: Invalid config, using defaults
>> [   10.270258] Goodix-TS i2c-GDIX1001:00: dev_info: cfg_len: 186,
>> x_max: 2160, y_max: 2160, touch_num: 10, trigger_type: 0
>> [   10.270608] input: Goodix Capacitive TouchScreen as
>> /devices/pci0000:00/808622C1:05/i2c-13/i2c-GDIX1001:00/input/input6
>>
>
