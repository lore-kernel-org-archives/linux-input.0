From: =?UTF-8?Q?Aljo=C5=A1a?= <aljosa@cromalternativemoney.org>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Thu, 06 Jul 2017 10:40:07 +0200
Message-ID: <f3b9860d7687532a3eb42d765289636d@cromalternativemoney.org>
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
 <2e065dd76a3fff10b9dc3f55d85cdbd5@cromalternativemoney.org>
 <015801d2dad1$c271e5b0$4755b110$@emc.com.tw>
 <CAB4CAwfbKUXsrZV+KNwL7xxsqhk0U_sEpZ37wU7UmJ+qoPh_YA@mail.gmail.com>
 <d2ccfb83974545b2c38393e54da1242a@cromalternativemoney.org>
 <003901d2de68$92cf2620$b86d7260$@emc.com.tw>
 <CAB4CAwdxSwEz3PPQGw6QwfkszwL=cokgEcXYtQFAhXYmUgyBNQ@mail.gmail.com>
 <CAAd53p6fj+ T2b+hRD-S9Xbx1mSStyJeJ YYaOD5quhbqtmPrZ5g@mail.gmail.com>
 <ef1052e44792273269cd51f48e7f2c99@cromalternativemoney.org>
 <CAB4CAwcHN307TiU=TPcF6iaS-6a3yFpKMtRGOX6QextKqiYu0g@mail.gmail.com>
 <783da09eba0db262a9b57ccfef48a70e@cromalternativemoney.org>
 <CAAd53p71ZkfWzNt8mwUhrw8SMfinZUCYX7pSeCR4GV6CZvA=wg@mail.gmail.com>
 <6899ee35a1de7c29de351484c9a0e52f@cromalternativemoney.org>
 <00a201d2f3e7$71e0ab70$55a20250$@emc.com.tw>
Reply-To: aljosa@cromalternativemoney.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vmi82135.contabo.host ([79.143.182.173]:36937 "EHLO
        vmi82135.contabo.host" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdGFIkJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 6 Jul 2017 04:40:09 -0400
In-Reply-To: <00a201d2f3e7$71e0ab70$55a20250$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?Q?=E5=BB=96=E5=B4=87=E6=A6=AE?= <kt.liao@emc.com.tw>
Cc: 'Kai-Heng Feng' <kai.heng.feng@canonical.com>, 'Chris Chiu' <chiu@endlessm.com>, linux-input@vger.kernel.org, =?UTF-8?Q?=27?= =?UTF-8?Q?=E9=BB=83=E4=B8=96=E9=B5=AC_=E7=B6=93=E7=90=86=27?= <phoenix@emc.com.tw>

06 July 2017,
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456
comment #76 by FZ (sirfz):

I installed Ubuntu 17.04 on mu new G752VS yesterday and the ELAN 
Touchpad was completely non-functional. Today, out of no where and 
without any reasonable explanation, it started working after a resume 
from sleep (opened lid). Right now it's fully functional, both buttons 
are working as well as tracking and multi-touch gestures (e.g. 
double-finger scrolling). All I did was install a few updates using the 
Software Updater today.

$ uname -a
Linux fzrog 4.10.0-26-generic #30-Ubuntu SMP Tue Jun 27 09:30:12 UTC 
2017 x86_64 x86_64 x86_64 GNU/Linux

$ xinput list
⎡ Virtual core pointer id=2	[master pointer (3)]
⎜ ↳ Virtual core XTEST pointer id=4	[slave pointer (2)]
⎜ ↳ Logitech MX Master id=10	[slave pointer (2)]
⎜ ↳ ASASTeK COMPUTER INC. ROG MacroKey id=16	[slave pointer (2)]
⎜ ↳ ELAN1203:00 04F3:301E Touchpad id=17	[slave pointer (2)]
⎜ ↳ Logitech M510 id=21	[slave pointer (2)]
⎜ ↳ Logitech K350 id=12	[slave pointer (2)]
⎜ ↳ ASASTeK COMPUTER INC. ROG MacroKey id=15	[slave pointer (2)]
⎣ Virtual core keyboard id=3	[master keyboard (2)]
     ↳ Virtual core XTEST keyboard id=5	[slave keyboard (3)]
     ↳ ASASTeK COMPUTER INC. ROG MacroKey id=14	[slave keyboard (3)]
     ↳ Sleep Button id=9	[slave keyboard (3)]
     ↳ Logitech MX Master id=11	[slave keyboard (3)]
     ↳ USB2.0 HD UVC WebCam id=13	[slave keyboard (3)]
     ↳ Power Button id=6	[slave keyboard (3)]
     ↳ AT Translated Set 2 keyboard id=19	[slave keyboard (3)]
     ↳ Asus WMI hotkeys id=18	[slave keyboard (3)]
     ↳ Video Bus id=8	[slave keyboard (3)]
     ↳ Asus Wireless Radio Control id=7	[slave keyboard (3)]
     ↳ Logitech K350 id=20	[slave keyboard (3)]
     ↳ ASASTeK COMPUTER INC. ROG MacroKey id=22	[slave keyboard (3)]



On 2017-07-03 12:30, 廖崇榮 wrote:
> Chris thinks touchpad works fine but display card issue in previous 
> mail.
> Could anyone help to check it?
> 
> -----Original Message-----
> From: Aljoša [mailto:aljosa@cromalternativemoney.org]
> Sent: Monday, July 03, 2017 5:03 PM
> To: Kai-Heng Feng
> Cc: Chris Chiu; 廖崇榮; linux-input@vger.kernel.org; 黃世鵬 經理
> Subject: Re: ASUS G752VS Touchpad does not work
> 
> Hello,
> I have just installed the new Linux 4.12 kernel.
> My ELAN touchpad is still completely dead.
> Please find attached the complete dmesg output file here (comment #75):
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456
> 
> 
> On 2017-06-20 12:06, Kai-Heng Feng wrote:
>> On Tue, Jun 20, 2017 at 5:53 PM, Aljoša
>> <aljosa@cromalternativemoney.org> wrote:
>>> Currently I'm using 4.11.0-5.10 kernel compiled by Kai-Heng Feng:
>>> http://people.canonical.com/~khfeng/asus-hid/
>> 
>> FWIW,
>> 
>>> 1. verify the return value of irq_get_trigger_type()
>> [    4.478815] i2c_hid i2c-ELAN1203:00: Trigger type: 0
>> 
>>> 2. Force the trigger type to IRQ_TYPE_EDGE_FALLING with
>>> irqd_set_trigger_type() before request_threaded_irq() 3. reboot with
>>> your own kernel to see if it works.
>> 
>> I also set the type to IRQ_TYPE_EDGE_FALLING. But looks like it didn't
>> work for the user.
