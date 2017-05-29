From: =?UTF-8?Q?Aljo=C5=A1a?= <aljosa@cromalternativemoney.org>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Mon, 29 May 2017 13:04:09 +0200
Message-ID: <2e065dd76a3fff10b9dc3f55d85cdbd5@cromalternativemoney.org>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
 <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw>
 <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
 <003e01d2c54f$4f8acb30$eea06190$@emc.com.tw>
 <CAB4CAwdV0fUOARAZ13TY00s2kxVCw+QzOKd9k2P0m7fBPmhY0w@mail.gmail.com>
 <005601d2c554$64578df0$2d06a9d0$@emc.com.tw>
 <CAB4CAwfJ9t1JF_AcBYmnfHYMDEzujZd93cFXYFbuYMiYJFZ=Vw@mail.gmail.com>
 <CAAd53p6Y-wQceZ6x5EU+QR9-8MS-gshfwcUu7qCs_iuY3MR9oQ@mail.gmail.com>
 <CAB4CAwcJ4XvAqS-N0_2zaRQo5UXaLbVcyixGw+JCqtmeaNvzew@mail.gmail.com>
 <CAAd53p6eLrKCZqZi-p-Wo2E=ZNZZOfpGqkM+STNMo+R-Hr36RA@mail.gmail.com>
Reply-To: aljosa@cromalternativemoney.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vmi82135.contabo.host ([79.143.182.173]:38644 "EHLO
        vmi82135.contabo.host" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750902AbdE2LEM (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 29 May 2017 07:04:12 -0400
In-Reply-To: <CAAd53p6eLrKCZqZi-p-Wo2E=ZNZZOfpGqkM+STNMo+R-Hr36RA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Chris Chiu <chiu@endlessm.com>, =?UTF-8?Q?=E5=BB=96=E5=B4=87=E6=A6=AE?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, =?UTF-8?Q?=E9=BB=83?= =?UTF-8?Q?=E4=B8=96=E9=B5=AC_=E7=B6=93=E7=90=86?= <phoenix@emc.com.tw>

Hello,just installed new kernel 4.12-rc3.
ELAN touchpad is still completely dead on my ASUS G752VS.
Complete dmesg output (comment #68) and complete output (comment #69) of 
~$ cat /proc/interrupts attached here:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456

~$ dmesg

[5.149761] i2c_hid i2c-ELAN1203:00: i2c-ELAN1203:00 supply vdd not 
found, using dummy regulator
[5.191090] hid-multitouch 0018:04F3:3043.0007: Ignoring the extra 
HID_DG_INPUTMODE
[5.191133] input: ELAN1203:00 04F3:3043 Touchpad as 
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-ELAN1203:00/0018:04F3:3043.0007/input/input16
[5.191230] hid-multitouch 0018:04F3:3043.0007: input,hidraw6: I2C HID 
v1.00 Mouse [ELAN1203:00 04F3:3043] on i2c-ELAN1203:00

~$ cat /proc/interrupts

16:          0          0          0          0          0          0    
       0          0  IR-IO-APIC   16-fasteoi   idma64.0, i2c_designware.0
17:        709       9839          0          0          0          0    
       0          0  IR-IO-APIC   17-fasteoi   idma64.1, i2c_designware.1
95:          1        552          0          0          0          0    
       0          0  IR-IO-APIC   95-fasteoi   ELAN1203:00

~$ xinput list
⎡ Virtual core pointer id=2	[master pointer (3)]
⎜ ↳ Virtual core XTEST pointer id=4	[slave pointer (2)]
⎜ ↳ G-SPY USB Gaming Mouse id=11	[slave pointer (2)]
⎜ ↳ Asus Keyboard id=14	[slave pointer (2)]
⎜ ↳ Asus Keyboard id=15	[slave pointer (2)]
⎜ ↳ ELAN1203:00 04F3:3043 Touchpad id=16	[slave pointer (2)]
⎣ Virtual core keyboard id=3	[master keyboard (2)]
     ↳ Virtual core XTEST keyboard id=5	[slave keyboard (3)]
     ↳ Power Button id=6	[slave keyboard (3)]
     ↳ Asus Wireless Radio Control id=7	[slave keyboard (3)]
     ↳ Video Bus id=8	[slave keyboard (3)]
     ↳ Sleep Button id=9	[slave keyboard (3)]
     ↳ G-SPY USB Gaming Mouse id=10	[slave keyboard (3)]
     ↳ USB2.0 HD UVC WebCam id=12	[slave keyboard (3)]
     ↳ Asus Keyboard id=13	[slave keyboard (3)]
     ↳ Asus WMI hotkeys id=17	[slave keyboard (3)]
     ↳ AT Translated Set 2 keyboard id=18	[slave keyboard (3)]
     ↳ G-SPY USB Gaming Mouse id=19	[slave keyboard (3)]
     ↳ Asus Keyboard id=20	[slave keyboard (3)]



On 2017-05-08 08:49, Kai-Heng Feng wrote:
> Hi aljosa,
> 
> On Fri, May 5, 2017 at 9:05 PM, Chris Chiu <chiu@endlessm.com> wrote:
>> I read the whole threads. It's normal there's no interrupt observed if
>> using elan_i2c driver. It should use hid-multitouch.
>> 
>> I would like to know if there's any interrupts observed when it load
>> hid-multitouch driver instead of elan_i2c driver.
>> 
>> Something noted here, on my G752VSK the input device shows as ELAN1200
>> not ELAN1203. Although I think it should make no difference, just to
>> note that my machine maybe a little different from the bug reporter's.
>> 
> 
> Can you provide information Chris asked?
> His G752 uses a slightly different touchpad so more information is 
> needed.
> 
> Thanks!
