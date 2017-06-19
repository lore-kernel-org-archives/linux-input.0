From: =?UTF-8?Q?Aljo=C5=A1a?= <aljosa@cromalternativemoney.org>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Mon, 19 Jun 2017 20:38:19 +0200
Message-ID: <f7b66274c885ab4768cbc4ec02c464f0@cromalternativemoney.org>
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
 <CAAd53p6fj+T2b+hRD-S9Xbx1mSStyJeJYYaOD5quhbqtmPrZ5g@mail.gmail.com>
Reply-To: aljosa@cromalternativemoney.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vmi82135.contabo.host ([79.143.182.173]:48024 "EHLO
        vmi82135.contabo.host" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753877AbdFSSia (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 19 Jun 2017 14:38:30 -0400
In-Reply-To: <CAAd53p6fj+T2b+hRD-S9Xbx1mSStyJeJYYaOD5quhbqtmPrZ5g@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Chris Chiu <chiu@endlessm.com>, =?UTF-8?Q?=E5=BB=96=E5=B4=87=E6=A6=AE?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, =?UTF-8?Q?=E9=BB=83?= =?UTF-8?Q?=E4=B8=96=E9=B5=AC_=E7=B6=93=E7=90=86?= <phoenix@emc.com.tw>

Just installed new kernel 4.12-rc6, my ELAN touchpad is still completely 
dead

[5.265229] i2c_hid i2c-ELAN1203:00: i2c-ELAN1203:00 supply vdd not 
found, using dummy regulator
[5.305130] hid-multitouch 0018:04F3:3043.0007: Ignoring the extra 
HID_DG_INPUTMODE
[5.305175] input: ELAN1203:00 04F3:3043 Touchpad as 
/devices/pci0000:00/0000:00:15.1/i2c_designware.1/i2c-1/i2c-ELAN1203:00/0018:04F3:3043.0007/input/input16
[5.305245] hid-multitouch 0018:04F3:3043.0007: input,hidraw6: I2C HID 
v1.00 Mouse [ELAN1203:00 04F3:3043] on i2c-ELAN1203:00

Please find attached the dmesg output here (comment #73):

https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456



On 2017-06-08 10:55, Kai-Heng Feng wrote:
> On Wed, Jun 7, 2017 at 5:30 PM, Chris Chiu <chiu@endlessm.com> wrote:
>> Hi Aijosa,
>>     If you can build your own kernel, I'll suggest to add code in
>> i2c_hid_init_irq() in i2c-hid.c.
>> 1. verify the return value of irq_get_trigger_type()
>> 2. Force the trigger type to IRQ_TYPE_EDGE_FALLING with
>> irqd_set_trigger_type() before request_threaded_irq()
>> 3. reboot with your own kernel to see if it works.
> 
> Hi Aljosa,
> 
> I compiled a Linux kernel with above requirement, please try out:
> http://people.canonical.com/~khfeng/asus-hid/
