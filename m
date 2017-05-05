From: =?UTF-8?B?5buW5bSH5qau?= <kt.liao@emc.com.tw>
Subject: RE: ASUS G752VS Touchpad does not work
Date: Fri, 5 May 2017 11:25:57 +0800
Message-ID: <003e01d2c54f$4f8acb30$eea06190$@emc.com.tw>
References: <CAAd53p57p7nj2AEoUK-wrEETZEsQweVAmhXMGqEM6JbZtbXAZQ@mail.gmail.com> <005e01d2c4bb$6961c7f0$3c2557d0$@emc.com.tw> <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:29464 "EHLO
        emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754740AbdEEDZ2 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 4 May 2017 23:25:28 -0400
In-Reply-To: <CAAd53p6VNhX=10vgP9A=0YhmFChc-DMt1P2L3UgmpggwATYAjg@mail.gmail.com>
Content-Language: zh-tw
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: 'Kai-Heng Feng' <kai.heng.feng@canonical.com>, 'Chris Chiu' <chiu@endlessm.com>
Cc: linux-input@vger.kernel.org, =?UTF-8?B?6buD5LiW6bWsIOe2k+eQhg==?= <phoenix@emc.com.tw>

Add Endlessm's Chris in loop

Hi Chris,

Do you know ASUS G752VS's touchpad issue.
It's MS PTP, I am not sure if it meet the same problem that interrupt pin configure issue?

>From your last Acer PTP experience, Your issue seems caused by inconsistent INT setting, right?

Could you give some advice to Kai-Heng to check the issue

Thanks  KT



-----Original Message-----
From: Kai-Heng Feng [mailto:kai.heng.feng@canonical.com] 
Sent: Thursday, May 04, 2017 5:54 PM
To: 廖崇榮
Cc: linux-input@vger.kernel.org
Subject: Re: ASUS G752VS Touchpad does not work

Hi, KT Liao,

On Thu, May 4, 2017 at 5:47 PM, 廖崇榮 <kt.liao@emc.com.tw> wrote:
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
> A user reported that the touchpad on ASUS G752VS does not work [1], it's an ELAN touchapd.
>
> I did the following change, the touchpad correctly loads elan-i2c instead of hid-multitouch, but it's still not working.
>
> [KT] I check the touchpad of this model, it's MS precision touchpad.
> It must use "hid-multitouch", not "elan-i2c".

Well, the touchpad does not work under hid-multitouch, either. That's why I tried to let it load elan-i2c instead.
What information do you need to investigate this issue?

Thanks.

