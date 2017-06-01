From: Chris Chiu <chiu@endlessm.com>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Thu, 1 Jun 2017 20:58:53 +0800
Message-ID: <CAB4CAwfbKUXsrZV+KNwL7xxsqhk0U_sEpZ37wU7UmJ+qoPh_YA@mail.gmail.com>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
 <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw> <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
 <003e01d2c54f$4f8acb30$eea06190$@emc.com.tw> <CAB4CAwdV0fUOARAZ13TY00s2kxVCw+QzOKd9k2P0m7fBPmhY0w@mail.gmail.com>
 <005601d2c554$64578df0$2d06a9d0$@emc.com.tw> <CAB4CAwfJ9t1JF_AcBYmnfHYMDEzujZd93cFXYFbuYMiYJFZ=Vw@mail.gmail.com>
 <CAAd53p6Y-wQceZ6x5EU+QR9-8MS-gshfwcUu7qCs_iuY3MR9oQ@mail.gmail.com>
 <CAB4CAwcJ4XvAqS-N0_2zaRQo5UXaLbVcyixGw+JCqtmeaNvzew@mail.gmail.com>
 <CAAd53p6eLrKCZqZi-p-Wo2E=ZNZZOfpGqkM+STNMo+R-Hr36RA@mail.gmail.com>
 <2e065dd76a3fff10b9dc3f55d85cdbd5@cromalternativemoney.org> <015801d2dad1$c271e5b0$4755b110$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-oi0-f41.google.com ([209.85.218.41]:33582 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdFAM6y (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Jun 2017 08:58:54 -0400
Received: by mail-oi0-f41.google.com with SMTP id w10so52632131oif.0
        for <linux-input@vger.kernel.org>; Thu, 01 Jun 2017 05:58:54 -0700 (PDT)
In-Reply-To: <015801d2dad1$c271e5b0$4755b110$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: aljosa@cromalternativemoney.org, Kai-Heng Feng <kai.heng.feng@canonical.com>, linux-input@vger.kernel.org, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>

Hi KT,
    Yes, I've hit the interrupt type setting issues in Acer laptops.
If the interrupt type setting is wrong in the BIOS, the touchpad will
stop working after a while (often ~10 seconds). The interrupt numbers
observed will be a lot more than expected when touchpad is still
working which cause i2c read lots of dummy data, then never increase
when the touchpad stop responding. I believe it's something very
similar. Please do "sudo cat
/sys/kernel/debug/hid/0018:04F3:3043.0007/events" before your touchpad
dead to see if there's still outputs even you never touch the
touchpad. If the data keeps coming, that means the interrupt type
setting should go wrong.

Chris

On Thu, Jun 1, 2017 at 8:22 PM, =E5=BB=96=E5=B4=87=E6=A6=AE <kt.liao@emc.co=
m.tw> wrote:
> Hi Chris,
>
> His Interrupt is fasteoi, I guess it's kind of level trigger.
>
> I remember that you debug for an Acer PTP which cause touchpad no functio=
n sometimes.
> And it works fine after interrupt modified to edge trigger.
>
> What's your comment?
>
> Thanks  KT
> -----Original Message-----
> From: Aljo=C5=A1a [mailto:aljosa@cromalternativemoney.org]
> Sent: Monday, May 29, 2017 7:04 PM
> To: Kai-Heng Feng
> Cc: Chris Chiu; =E5=BB=96=E5=B4=87=E6=A6=AE; linux-input@vger.kernel.org;=
 =E9=BB=83=E4=B8=96=E9=B5=AC =E7=B6=93=E7=90=86
> Subject: Re: ASUS G752VS Touchpad does not work
>
> Hello,just installed new kernel 4.12-rc3.
> ELAN touchpad is still completely dead on my ASUS G752VS.
> Complete dmesg output (comment #68) and complete output (comment #69) of =
~$ cat /proc/interrupts attached here:
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456
>
> ~$ dmesg
>
> [5.149761] i2c_hid i2c-ELAN1203:00: i2c-ELAN1203:00 supply vdd not found,=
 using dummy regulator [5.191090] hid-multitouch 0018:04F3:3043.0007: Ignor=
ing the extra HID_DG_INPUTMODE [5.191133] input: ELAN1203:00 04F3:3043 Touc=
hpad as
> /devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-ELAN1203:00/0=
018:04F3:3043.0007/input/input16
> [5.191230] hid-multitouch 0018:04F3:3043.0007: input,hidraw6: I2C HID
> v1.00 Mouse [ELAN1203:00 04F3:3043] on i2c-ELAN1203:00
>
> ~$ cat /proc/interrupts
>
> 16:          0          0          0          0          0          0
>        0          0  IR-IO-APIC   16-fasteoi   idma64.0, i2c_designware.0
> 17:        709       9839          0          0          0          0
>        0          0  IR-IO-APIC   17-fasteoi   idma64.1, i2c_designware.1
> 95:          1        552          0          0          0          0
>        0          0  IR-IO-APIC   95-fasteoi   ELAN1203:00
>
> ~$ xinput list
> =E2=8E=A1 Virtual core pointer id=3D2     [master pointer (3)]
> =E2=8E=9C =E2=86=B3 Virtual core XTEST pointer id=3D4     [slave pointer =
(2)]
> =E2=8E=9C =E2=86=B3 G-SPY USB Gaming Mouse id=3D11        [slave pointer =
(2)]
> =E2=8E=9C =E2=86=B3 Asus Keyboard id=3D14 [slave pointer (2)]
> =E2=8E=9C =E2=86=B3 Asus Keyboard id=3D15 [slave pointer (2)]
> =E2=8E=9C =E2=86=B3 ELAN1203:00 04F3:3043 Touchpad id=3D16        [slave =
pointer (2)]
> =E2=8E=A3 Virtual core keyboard id=3D3    [master keyboard (2)]
>      =E2=86=B3 Virtual core XTEST keyboard id=3D5 [slave keyboard (3)]
>      =E2=86=B3 Power Button id=3D6        [slave keyboard (3)]
>      =E2=86=B3 Asus Wireless Radio Control id=3D7 [slave keyboard (3)]
>      =E2=86=B3 Video Bus id=3D8   [slave keyboard (3)]
>      =E2=86=B3 Sleep Button id=3D9        [slave keyboard (3)]
>      =E2=86=B3 G-SPY USB Gaming Mouse id=3D10     [slave keyboard (3)]
>      =E2=86=B3 USB2.0 HD UVC WebCam id=3D12       [slave keyboard (3)]
>      =E2=86=B3 Asus Keyboard id=3D13      [slave keyboard (3)]
>      =E2=86=B3 Asus WMI hotkeys id=3D17   [slave keyboard (3)]
>      =E2=86=B3 AT Translated Set 2 keyboard id=3D18       [slave keyboard=
 (3)]
>      =E2=86=B3 G-SPY USB Gaming Mouse id=3D19     [slave keyboard (3)]
>      =E2=86=B3 Asus Keyboard id=3D20      [slave keyboard (3)]
>
>
>
> On 2017-05-08 08:49, Kai-Heng Feng wrote:
>> Hi aljosa,
>>
>> On Fri, May 5, 2017 at 9:05 PM, Chris Chiu <chiu@endlessm.com> wrote:
>>> I read the whole threads. It's normal there's no interrupt observed
>>> if using elan_i2c driver. It should use hid-multitouch.
>>>
>>> I would like to know if there's any interrupts observed when it load
>>> hid-multitouch driver instead of elan_i2c driver.
>>>
>>> Something noted here, on my G752VSK the input device shows as
>>> ELAN1200 not ELAN1203. Although I think it should make no difference,
>>> just to note that my machine maybe a little different from the bug repo=
rter's.
>>>
>>
>> Can you provide information Chris asked?
>> His G752 uses a slightly different touchpad so more information is
>> needed.
>>
>> Thanks!
>
