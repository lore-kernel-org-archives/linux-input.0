From: =?UTF-8?Q?Aljo=C5=A1a?= <aljosa@cromalternativemoney.org>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Mon, 03 Jul 2017 11:03:14 +0200
Message-ID: <6899ee35a1de7c29de351484c9a0e52f@cromalternativemoney.org>
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
 <ef1052e44792273269cd51f48e7f2c99@cromalternativemoney.org>
 <CAB4CAwcHN307TiU=TPcF6iaS-6a3yFpKMtRGOX6QextKqiYu0g@mail.gmail.com>
 <783da09eba0db262a9b57ccfef48a70e@cromalternativemoney.org>
 <CAAd53p71ZkfWzNt8mwUhrw8SMfinZUCYX7pSeCR4GV6CZvA=wg@mail.gmail.com>
Reply-To: aljosa@cromalternativemoney.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vmi82135.contabo.host ([79.143.182.173]:34516 "EHLO
        vmi82135.contabo.host" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753338AbdGCJDQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Jul 2017 05:03:16 -0400
In-Reply-To: <CAAd53p71ZkfWzNt8mwUhrw8SMfinZUCYX7pSeCR4GV6CZvA=wg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Chris Chiu <chiu@endlessm.com>, =?UTF-8?Q?=E5=BB=96=E5=B4=87=E6=A6=AE?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, =?UTF-8?Q?=E9=BB=83?= =?UTF-8?Q?=E4=B8=96=E9=B5=AC_=E7=B6=93=E7=90=86?= <phoenix@emc.com.tw>

Hello,
I have just installed the new Linux 4.12 kernel.
My ELAN touchpad is still completely dead.
Please find attached the complete dmesg output file here (comment #75):
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456


On 2017-06-20 12:06, Kai-Heng Feng wrote:
> On Tue, Jun 20, 2017 at 5:53 PM, Aljoša 
> <aljosa@cromalternativemoney.org> wrote:
>> Currently I'm using 4.11.0-5.10 kernel compiled by Kai-Heng Feng:
>> http://people.canonical.com/~khfeng/asus-hid/
> 
> FWIW,
> 
>> 1. verify the return value of irq_get_trigger_type()
> [    4.478815] i2c_hid i2c-ELAN1203:00: Trigger type: 0
> 
>> 2. Force the trigger type to IRQ_TYPE_EDGE_FALLING with
>> irqd_set_trigger_type() before request_threaded_irq()
>> 3. reboot with your own kernel to see if it works.
> 
> I also set the type to IRQ_TYPE_EDGE_FALLING. But looks like it didn't
> work for the user.
