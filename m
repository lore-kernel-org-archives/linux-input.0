From: Chris Chiu <chiu@endlessm.com>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Fri, 5 May 2017 14:41:00 +0800
Message-ID: <CAB4CAwfJ9t1JF_AcBYmnfHYMDEzujZd93cFXYFbuYMiYJFZ=Vw@mail.gmail.com>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
 <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw> <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
 <003e01d2c54f$4f8acb30$eea06190$@emc.com.tw> <CAB4CAwdV0fUOARAZ13TY00s2kxVCw+QzOKd9k2P0m7fBPmhY0w@mail.gmail.com>
 <005601d2c554$64578df0$2d06a9d0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:33798 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752590AbdEEGlB (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 5 May 2017 02:41:01 -0400
Received: by mail-io0-f173.google.com with SMTP id k91so52600498ioi.1
        for <linux-input@vger.kernel.org>; Thu, 04 May 2017 23:41:01 -0700 (PDT)
In-Reply-To: <005601d2c554$64578df0$2d06a9d0$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-input@vger.kernel.org, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>

Hi KT,
    We user kernel version 4.8 when test the G752VSK but it should
work at 4.10 too. I'll verify that later. And yes, there's no ELAN
interrupt at all from the bug report. I would suggest to have the DSDT
for further analysis.

Chris

On Fri, May 5, 2017 at 12:02 PM, =E5=BB=96=E5=B4=87=E6=A6=AE <kt.liao@emc.c=
om.tw> wrote:
> Hi Chris,
>
>
>
> Thanks, I remember this issue, it=E2=80=99s HID description issue for tou=
chpad=E2=80=99s
> physical button. And it fixed after Benjamin =E2=80=99s patch
>
> From below link, it seems the probe is ok, so I still guess interrupt may=
be
> the problem
>
> https://bugs.launchpad.net/bugs/1653456
>
>
>
> which kernel version do you use for it?,
>
>
>
> Thanks             KT
>
>
>
> From: Chris Chiu [mailto:chiu@endlessm.com]
> Sent: Friday, May 05, 2017 11:45 AM
> To: =E5=BB=96=E5=B4=87=E6=A6=AE
> Cc: Kai-Heng Feng; linux-input@vger.kernel.org; =E9=BB=83=E4=B8=96=E9=B5=
=AC =E7=B6=93=E7=90=86
>
>
> Subject: Re: ASUS G752VS Touchpad does not work
>
>
>
> Hi KT,
>
>    We only encounter Asus G752VSK: Default touchpad left key and right ar=
e
> reversed issue. The touchpad works under hid-multitouch except the
> left/right key reversed. I still have G752VS in hand, please let me know =
if
> you need any.
>
>
>
> Chris
>
>
>
> On Fri, May 5, 2017 at 11:25 AM, =E5=BB=96=E5=B4=87=E6=A6=AE <kt.liao@emc=
.com.tw> wrote:
>
> Add Endlessm's Chris in loop
>
> Hi Chris,
>
> Do you know ASUS G752VS's touchpad issue.
> It's MS PTP, I am not sure if it meet the same problem that interrupt pin
> configure issue?
>
> From your last Acer PTP experience, Your issue seems caused by inconsiste=
nt
> INT setting, right?
>
> Could you give some advice to Kai-Heng to check the issue
>
> Thanks  KT
>
>
>
> -----Original Message-----
> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Thursday, May 04, 2017 5:54 PM
> To: =E5=BB=96=E5=B4=87=E6=A6=AE
> Cc: linux-input@vger.kernel.org
> Subject: Re: ASUS G752VS Touchpad does not work
>
> Hi, KT Liao,
>
> On Thu, May 4, 2017 at 5:47 PM, =E5=BB=96=E5=B4=87=E6=A6=AE <kt.liao@emc.=
com.tw> wrote:
>> Hi Kai-Heng
>>
>> -----Original Message-----
>> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
>> Sent: Thursday, May 04, 2017 3:59 PM
>> To: kt.liao@emc.com.tw; dusonlin@emc.com.tw
>> Cc: linux-input@vger.kernel.org
>> Subject: ASUS G752VS Touchpad does not work
>>
>> Hi KT Liao, Duson Lin,
>>
>> A user reported that the touchpad on ASUS G752VS does not work [1], it's
>> an ELAN touchapd.
>>
>> I did the following change, the touchpad correctly loads elan-i2c instea=
d
>> of hid-multitouch, but it's still not working.
>>
>> [KT] I check the touchpad of this model, it's MS precision touchpad.
>> It must use "hid-multitouch", not "elan-i2c".
>
> Well, the touchpad does not work under hid-multitouch, either. That's why=
 I
> tried to let it load elan-i2c instead.
> What information do you need to investigate this issue?
>
> Thanks.
>
>
