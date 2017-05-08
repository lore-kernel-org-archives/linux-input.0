From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Mon, 8 May 2017 14:49:22 +0800
Message-ID: <CAAd53p6eLrKCZqZi-p-Wo2E=ZNZZOfpGqkM+STNMo+R-Hr36RA@mail.gmail.com>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
 <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw> <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
 <003e01d2c54f$4f8acb30$eea06190$@emc.com.tw> <CAB4CAwdV0fUOARAZ13TY00s2kxVCw+QzOKd9k2P0m7fBPmhY0w@mail.gmail.com>
 <005601d2c554$64578df0$2d06a9d0$@emc.com.tw> <CAB4CAwfJ9t1JF_AcBYmnfHYMDEzujZd93cFXYFbuYMiYJFZ=Vw@mail.gmail.com>
 <CAAd53p6Y-wQceZ6x5EU+QR9-8MS-gshfwcUu7qCs_iuY3MR9oQ@mail.gmail.com> <CAB4CAwcJ4XvAqS-N0_2zaRQo5UXaLbVcyixGw+JCqtmeaNvzew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:35772 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751948AbdEHGtY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 8 May 2017 02:49:24 -0400
Received: by mail-wm0-f53.google.com with SMTP id b84so43008009wmh.0
        for <linux-input@vger.kernel.org>; Sun, 07 May 2017 23:49:23 -0700 (PDT)
In-Reply-To: <CAB4CAwcJ4XvAqS-N0_2zaRQo5UXaLbVcyixGw+JCqtmeaNvzew@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: aljosa@cromalternativemoney.org
Cc: Chris Chiu <chiu@endlessm.com>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>

Hi aljosa,

On Fri, May 5, 2017 at 9:05 PM, Chris Chiu <chiu@endlessm.com> wrote:
> I read the whole threads. It's normal there's no interrupt observed if
> using elan_i2c driver. It should use hid-multitouch.
>
> I would like to know if there's any interrupts observed when it load
> hid-multitouch driver instead of elan_i2c driver.
>
> Something noted here, on my G752VSK the input device shows as ELAN1200
> not ELAN1203. Although I think it should make no difference, just to
> note that my machine maybe a little different from the bug reporter's.
>

Can you provide information Chris asked?
His G752 uses a slightly different touchpad so more information is needed.

Thanks!
