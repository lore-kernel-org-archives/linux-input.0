From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Tue, 20 Jun 2017 18:06:04 +0800
Message-ID: <CAAd53p71ZkfWzNt8mwUhrw8SMfinZUCYX7pSeCR4GV6CZvA=wg@mail.gmail.com>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
 <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw> <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
 <003e01d2c54f$4f8acb30$eea06190$@emc.com.tw> <CAB4CAwdV0fUOARAZ13TY00s2kxVCw+QzOKd9k2P0m7fBPmhY0w@mail.gmail.com>
 <005601d2c554$64578df0$2d06a9d0$@emc.com.tw> <CAB4CAwfJ9t1JF_AcBYmnfHYMDEzujZd93cFXYFbuYMiYJFZ=Vw@mail.gmail.com>
 <CAAd53p6Y-wQceZ6x5EU+QR9-8MS-gshfwcUu7qCs_iuY3MR9oQ@mail.gmail.com>
 <CAB4CAwcJ4XvAqS-N0_2zaRQo5UXaLbVcyixGw+JCqtmeaNvzew@mail.gmail.com>
 <CAAd53p6eLrKCZqZi-p-Wo2E=ZNZZOfpGqkM+STNMo+R-Hr36RA@mail.gmail.com>
 <2e065dd76a3fff10b9dc3f55d85cdbd5@cromalternativemoney.org>
 <015801d2dad1$c271e5b0$4755b110$@emc.com.tw> <CAB4CAwfbKUXsrZV+KNwL7xxsqhk0U_sEpZ37wU7UmJ+qoPh_YA@mail.gmail.com>
 <d2ccfb83974545b2c38393e54da1242a@cromalternativemoney.org>
 <003901d2de68$92cf2620$b86d7260$@emc.com.tw> <CAB4CAwdxSwEz3PPQGw6QwfkszwL=cokgEcXYtQFAhXYmUgyBNQ@mail.gmail.com>
 <CAAd53p6fj+T2b+hRD-S9Xbx1mSStyJeJYYaOD5quhbqtmPrZ5g@mail.gmail.com>
 <ef1052e44792273269cd51f48e7f2c99@cromalternativemoney.org>
 <CAB4CAwcHN307TiU=TPcF6iaS-6a3yFpKMtRGOX6QextKqiYu0g@mail.gmail.com> <783da09eba0db262a9b57ccfef48a70e@cromalternativemoney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37062 "EHLO
        mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750925AbdFTKGH (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 06:06:07 -0400
Received: by mail-wm0-f54.google.com with SMTP id d73so15315061wma.0
        for <linux-input@vger.kernel.org>; Tue, 20 Jun 2017 03:06:06 -0700 (PDT)
In-Reply-To: <783da09eba0db262a9b57ccfef48a70e@cromalternativemoney.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: aljosa@cromalternativemoney.org
Cc: Chris Chiu <chiu@endlessm.com>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>

On Tue, Jun 20, 2017 at 5:53 PM, Aljo=C5=A1a <aljosa@cromalternativemoney.o=
rg> wrote:
> Currently I'm using 4.11.0-5.10 kernel compiled by Kai-Heng Feng:
> http://people.canonical.com/~khfeng/asus-hid/

FWIW,

> 1. verify the return value of irq_get_trigger_type()
[    4.478815] i2c_hid i2c-ELAN1203:00: Trigger type: 0

> 2. Force the trigger type to IRQ_TYPE_EDGE_FALLING with
> irqd_set_trigger_type() before request_threaded_irq()
> 3. reboot with your own kernel to see if it works.

I also set the type to IRQ_TYPE_EDGE_FALLING. But looks like it didn't
work for the user.
