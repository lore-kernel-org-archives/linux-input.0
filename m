From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: ASUS G752VS Touchpad does not work
Date: Thu, 4 May 2017 17:54:22 +0800
Message-ID: <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com>
 <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:37689 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751319AbdEDJyY (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 May 2017 05:54:24 -0400
Received: by mail-wm0-f46.google.com with SMTP id m123so9873625wma.0
        for <linux-input@vger.kernel.org>; Thu, 04 May 2017 02:54:23 -0700 (PDT)
In-Reply-To: <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Cc: linux-input@vger.kernel.org

Hi, KT Liao,

On Thu, May 4, 2017 at 5:47 PM, =E5=BB=96=E5=B4=87=E6=A6=AE <kt.liao@emc.co=
m.tw> wrote:
> Hi Kai-Heng
>
> -----Original Message-----
> From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com]
> Sent: Thursday, May 04, 2017 3:59 PM
> To: kt.liao@emc.com.tw; dusonlin@emc.com.tw
> Cc: linux-input@vger.kernel.org
> Subject: ASUS G752VS Touchpad does not work
>
> Hi KT Liao, Duson Lin,
>
> A user reported that the touchpad on ASUS G752VS does not work [1], it's =
an ELAN touchapd.
>
> I did the following change, the touchpad correctly loads elan-i2c instead=
 of hid-multitouch, but it's still not working.
>
> [KT] I check the touchpad of this model, it's MS precision touchpad.
> It must use "hid-multitouch", not "elan-i2c".

Well, the touchpad does not work under hid-multitouch, either. That's
why I tried to let it load elan-i2c instead.
What information do you need to investigate this issue?

Thanks.
