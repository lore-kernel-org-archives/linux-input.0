From: Brad Baker <bbaker6212@gmail.com>
Subject: Re: Goodix touchscreen works intermittently, fails reading config info.
Date: Wed, 12 Oct 2016 17:37:06 -0300
Message-ID: <CAG=1usYgr=iTfVR=0DoEzH6vEyAU3dGUv3x_8=fSfpJ4-iVVEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35435 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934179AbcJLVIo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Oct 2016 17:08:44 -0400
Received: by mail-qk0-f174.google.com with SMTP id z190so55810300qkc.2
        for <linux-input@vger.kernel.org>; Wed, 12 Oct 2016 14:08:44 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>
Cc: "Tirdea, Irina" <irina.tirdea@intel.com>, bastien nocera <hadess@hadess.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Irina, I just saw this after updating the Bug 156511 with Serg's info.
He says he just used the following single patch to generate the Chuwi
Hi12 firmware file and get it working using
ubuntu-16.10-beta2-desktop-amd64.iso:
https://github.com/itirdea/linux/commit/13008b8535120c4a35f0bc8951895455cd706290.patch

On Wed, Oct 12, 2016 at 4:48 PM, sergk sergk2mail <sergk.admin@gmail.com> wrote:
> Hello from ;-) Chuwi tablets warrior.
> Actually have done all requested, .cfg, bin, working module, etc are
> located : https://gitlab.com/SergK/chuwi_hi12/tree/master.
>
> Many thanks and regards,
>                              Serge Kolotylo.
>
>
> On Wed, Sep 14, 2016 at 9:29 AM, Tirdea, Irina <irina.tirdea@intel.com> wrote:
>>
>>
>>> -----Original Message-----
>>> From: linux-input-owner@vger.kernel.org [mailto:linux-input-owner@vger.kernel.org] On Behalf Of Brad Baker
>>> Sent: 13 September, 2016 6:05
>>> To: Tirdea, Irina
>>> Cc: bastien nocera; linux-input@vger.kernel.org
>>> Subject: Re: Goodix touchscreen works intermittently, fails reading config info.
>>>
>>> Irina, a little more info on the symptoms. The user reports the
>>> touchscreen works when restarting but fails when powering on.  He says
>>> pretty much 100% of the time.  The log is the same...
>>>
>>
>> Hi Brad,
>>
>> Thanks for all the information you provided. I have already replied on the
>> Bugzilla thread with some patches that enable reset for the device.
>>
>> Regards,
>> Irina
>>
>>
>>> http://pastebin.com/25haaPQd
>>> [   10.246074] goodix_backport: loading out-of-tree module taints kernel.
>>> [   10.246172] goodix_backport: module verification failed: signature
>>> and/or required key missing - tainting kernel
>>> [   10.263788] Goodix-TS i2c-GDIX1001:00: ID 9111, version: 1060
>>> [   10.270135] Goodix-TS i2c-GDIX1001:00: dev_info: cfg_len: 186,
>>> x_max: 0, y_max: 0, touch_num: 0, trigger_type: 0
>>> [   10.270141] Goodix-TS i2c-GDIX1001:00: Invalid config, using defaults
>>> [   10.270258] Goodix-TS i2c-GDIX1001:00: dev_info: cfg_len: 186,
>>> x_max: 2160, y_max: 2160, touch_num: 10, trigger_type: 0
>>> [   10.270608] input: Goodix Capacitive TouchScreen as
>>> /devices/pci0000:00/808622C1:05/i2c-13/i2c-GDIX1001:00/input/input6
>>>
>>
