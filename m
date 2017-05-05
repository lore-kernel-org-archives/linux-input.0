From: Chris Chiu <chiu@endlessm.com>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Fri, 5 May 2017 21:05:11 +0800
Message-ID: <CAB4CAwcJ4XvAqS-N0_2zaRQo5UXaLbVcyixGw+JCqtmeaNvzew@mail.gmail.com>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
 <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw> <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
 <003e01d2c54f$4f8acb30$eea06190$@emc.com.tw> <CAB4CAwdV0fUOARAZ13TY00s2kxVCw+QzOKd9k2P0m7fBPmhY0w@mail.gmail.com>
 <005601d2c554$64578df0$2d06a9d0$@emc.com.tw> <CAB4CAwfJ9t1JF_AcBYmnfHYMDEzujZd93cFXYFbuYMiYJFZ=Vw@mail.gmail.com>
 <CAAd53p6Y-wQceZ6x5EU+QR9-8MS-gshfwcUu7qCs_iuY3MR9oQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:34912 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751437AbdEENFM (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 May 2017 09:05:12 -0400
Received: by mail-io0-f169.google.com with SMTP id f102so7431404ioi.2
        for <linux-input@vger.kernel.org>; Fri, 05 May 2017 06:05:12 -0700 (PDT)
In-Reply-To: <CAAd53p6Y-wQceZ6x5EU+QR9-8MS-gshfwcUu7qCs_iuY3MR9oQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>

I read the whole threads. It's normal there's no interrupt observed if
using elan_i2c driver. It should use hid-multitouch.

I would like to know if there's any interrupts observed when it load
hid-multitouch driver instead of elan_i2c driver.

Something noted here, on my G752VSK the input device shows as ELAN1200
not ELAN1203. Although I think it should make no difference, just to
note that my machine maybe a little different from the bug reporter's.

On Fri, May 5, 2017 at 3:42 PM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> Hi Chris,
>
> On Fri, May 5, 2017 at 2:41 PM, Chris Chiu <chiu@endlessm.com> wrote:
>> Hi KT,
>>     We user kernel version 4.8 when test the G752VSK but it should
>> work at 4.10 too. I'll verify that later. And yes, there's no ELAN
>> interrupt at all from the bug report. I would suggest to have the DSDT
>> for further analysis.
>
> These are already two ACPI dumps from users:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456/comments/30
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456/comments/32
>
> Thanks.
