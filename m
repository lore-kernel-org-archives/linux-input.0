From: =?UTF-8?Q?Aljo=C5=A1a?= <aljosa@cromalternativemoney.org>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Tue, 23 May 2017 11:31:20 +0200
Message-ID: <3289dff90e6c66ac3630c04e74acc946@cromalternativemoney.org>
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
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vmi82135.contabo.host ([79.143.182.173]:41098 "EHLO
        vmi82135.contabo.host" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757555AbdEWJh4 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 23 May 2017 05:37:56 -0400
In-Reply-To: <CAAd53p6eLrKCZqZi-p-Wo2E=ZNZZOfpGqkM+STNMo+R-Hr36RA@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Chris Chiu <chiu@endlessm.com>, =?UTF-8?Q?=E5=BB=96=E5=B4=87=E6=A6=AE?= <kt.liao@emc.com.tw>, linux-input@vger.kernel.org, =?UTF-8?Q?=E9=BB=83?= =?UTF-8?Q?=E4=B8=96=E9=B5=AC_=E7=B6=93=E7=90=86?= <phoenix@emc.com.tw>

Just installed new kernel 4.12-rc2.
ELAN touchpad is still completely dead on my ASUS G752VS, now it's not 
even present in my system settings.
Dmesg output and other details attached here (comment #66):
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1653456


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
