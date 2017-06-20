From: Chris Chiu <chiu@endlessm.com>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Tue, 20 Jun 2017 12:07:43 +0800
Message-ID: <CAB4CAwcHN307TiU=TPcF6iaS-6a3yFpKMtRGOX6QextKqiYu0g@mail.gmail.com>
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
 <CAAd53p6fj+T2b+hRD-S9Xbx1mSStyJeJYYaOD5quhbqtmPrZ5g@mail.gmail.com> <ef1052e44792273269cd51f48e7f2c99@cromalternativemoney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:33325 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750711AbdFTEHo (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 20 Jun 2017 00:07:44 -0400
Received: by mail-oi0-f49.google.com with SMTP id p66so32635965oia.0
        for <linux-input@vger.kernel.org>; Mon, 19 Jun 2017 21:07:44 -0700 (PDT)
In-Reply-To: <ef1052e44792273269cd51f48e7f2c99@cromalternativemoney.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: aljosa@cromalternativemoney.org
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>

Hi Aljosa,
    From the 10_cat_sys_kernel_debug_hid_0018_04F3_3043_0007_events,
your touchpad seems to work fine. You can verify with the "evtest" or
"xev" to see if the events printed based on your touchpad move. So I
think it could be the display driver issue. Please give me the
information of the NVIDIA display in you G752VSK. Thanks.

Chris

On Thu, Jun 8, 2017 at 7:48 PM, Aljo=C5=A1a <aljosa@cromalternativemoney.or=
g> wrote:
> I just installed your kernel, thank you very much. ELAN touchpad still
> doesn't work.
> Please find attached:
>
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> dmesg_109.txt
>
> 7_cat_proc_interrupts.txt
> (without touching the touchpad)
>
> 8_cat_proc_interrupts.txt
> (with touching the touchpad and pressing its buttons)
>
> 9_cat_sys_kernel_debug_hid_0018_04F3_3043_0007_events
> (without touching the touchpad, not sure if I succeeded to execute the
> command within 10 seconds after power up)
>
> 10_cat_sys_kernel_debug_hid_0018_04F3_3043_0007_events
> (with touching the touchpad and pressing its buttons, not sure if I
> succeeded to execute the command within 10 seconds after power up)
>
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> If it can anyhow help you, here's Windows driver (ASUS Precision Touchpad=
;
> V11.0.10.02; 2016/06/14)
> http://dlcdnet.asus.com/pub/ASUS/nb/DriversForWin10/TouchPad/Touchpad_ASU=
S_Win10_64_VER1101002.zip?_ga=3D2.172356131.1012542656.1496921505-212089559=
0.1496921505
>
> PS: if you want, one of these days we can meet each other via Skype, I ca=
n
> easily install TeamViewer so you can experiment in my notebook whatever y=
ou
> want without losing time and patience...
>
> "My touchpad (ELAN1203:00 04F3:3043) doesn't work on my asus G752VS lapto=
p
> on debian stretch; at the last update of xserver-xorg-input-libinput and
> libinput10 my touchpad is put suddenly to work but after a reboot no long=
er
> works..."
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D855317
>
>
>
> On 2017-06-08 10:55, Kai-Heng Feng wrote:
>>
>> On Wed, Jun 7, 2017 at 5:30 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>>
>>> Hi Aijosa,
>>>     If you can build your own kernel, I'll suggest to add code in
>>> i2c_hid_init_irq() in i2c-hid.c.
>>> 1. verify the return value of irq_get_trigger_type()
>>> 2. Force the trigger type to IRQ_TYPE_EDGE_FALLING with
>>> irqd_set_trigger_type() before request_threaded_irq()
>>> 3. reboot with your own kernel to see if it works.
>>
>>
>> Hi Aljosa,
>>
>> I compiled a Linux kernel with above requirement, please try out:
>> http://people.canonical.com/~khfeng/asus-hid/
