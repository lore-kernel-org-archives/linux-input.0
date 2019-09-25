From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Alps touchpad generates IRQ storm after S3
Date: Wed, 25 Sep 2019 18:01:03 +0800
Message-ID: <82884F1B-A4CD-44EF-9245-1143277484A6@canonical.com>
References: <44F93018-5F13-4932-A5AC-9D288CDF68DD@canonical.com>
 <TYAPR01MB30223CB8A576C7809F6382C1ECA30@TYAPR01MB3022.jpnprd01.prod.outlook.com>
 <TYXPR01MB1470902D804A47EE72013006C8A30@TYXPR01MB1470.jpnprd01.prod.outlook.com>
 <A118551C-A0D9-485F-91F7-44A5BE228B99@canonical.com>
 <39b2e63e339447e8b09b2601abf3d1ba@AUSX13MPC101.AMER.DELL.COM>
 <BFBB1DB9-00B6-497E-80D1-5168CF16B889@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.13\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <BFBB1DB9-00B6-497E-80D1-5168CF16B889@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: Xiaojian Cao <xiaojian.cao@cn.alps.com>, masaki.ota@alpsalpine.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, naoki.saito@alpsalpine.com
List-Id: linux-input@vger.kernel.org

Hi Xiaojian,

> On Aug 28, 2019, at 22:43, Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> 
> Hi Mario,
> 
> at 21:25, <Mario.Limonciello@dell.com> <Mario.Limonciello@dell.com> wrote:
> 
>> KH,
>> 
>> Just make sure I understand details.
>> 
>>> Commit "HID: i2c-hid: Don't reset device upon system resume
>> 
>> If you revert this it's fixed on this system?
> 
> Yes. Once reset is used instead of  the issue is gone.

Do you figure out the correct command to use here?

Kai-Heng

> 
>> 
>> In that commit you had mentioned if this causes problems it might be worth
>> quirking just Raydium but commit afbb1169ed5b58cfca017e368b53e019cf285853
>> confirmed that it helped several other systems too.
>> 
>> If the conclusion from this investigation this is only fixable via touchpad FW update
>> it might be worth quirking this touchpad/touchpad FW/system combination.
> 
> Hopefully there’s a better solution from ALPS :)
> 
>> 
>>> Also Cc Mario because this could relate to BIOS.
>> 
>> Also I assume this is on current stable BIOS/EC release, right?
> 
> Yes. The BIOS version is 1.10.1.
> 
> The IRQ storm stops as soon as the touchpad gets touched.
> 
> Kai-Heng
> 
>> 
>> Thanks,
>> 
>>> -----Original Message-----
>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>> Sent: Wednesday, August 28, 2019 1:58 AM
>>> To: Xiaojian Cao
>>> Cc: Masaki Ota; Limonciello, Mario; open list:HID CORE LAYER; Linux Kernel
>>> Mailing List; Naoki Saito
>>> Subject: Re: Alps touchpad generates IRQ storm after S3
>>> 
>>> 
>>> [EXTERNAL EMAIL]
>>> 
>>> Hi Xiaojian,
>>> 
>>> at 14:51, Xiaojian Cao <xiaojian.cao@cn.alps.com> wrote:
>>> 
>>>> Hi Ota-san,
>>>> 
>>>> OK, we will look into it.
>>>> 
>>>> 
>>>> Hi Kai-Heng,
>>>> 
>>>> We will try to reproduce this issue first, could you please tell me the
>>>> target Ubuntu version?
>>> 
>>> It’s distro-agnostic, any distro with mainline Linux can reproduce the issue.
>>> 
>>> Kai-Heng
>>> 
>>>> Best regards,
>>>> Jason
>>>> 
>>>> -----Original Message-----
>>>> From: 太田 真喜 Masaki Ota <masaki.ota@alpsalpine.com>
>>>> Sent: Wednesday, August 28, 2019 2:35 PM
>>>> To: 曹 曉建 Xiaojian Cao <xiaojian.cao@cn.alps.com>; Kai-Heng Feng
>>>> <kai.heng.feng@canonical.com>
>>>> Cc: Mario Limonciello <mario.limonciello@dell.com>; open list:HID CORE
>>>> LAYER <linux-input@vger.kernel.org>; Linux Kernel Mailing List
>>>> <linux-kernel@vger.kernel.org>; 斉藤 直樹 Naoki Saito
>>>> <naoki.saito@alpsalpine.com>
>>>> Subject: RE: Alps touchpad generates IRQ storm after S3
>>>> 
>>>> Hi, Kai-Heng,
>>>> 
>>>> Sorry, I'm not in charge of Linux task now.
>>>> 
>>>> Hi, XiaoJian,
>>>> 
>>>> Please check the following mail.
>>>> If you have any question, please ask Kai-Heng.
>>>> 
>>>> Best Regards,
>>>> Masaki Ota
>>>> -----Original Message-----
>>>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>> Sent: Wednesday, August 28, 2019 3:22 PM
>>>> To: 太田 真喜 Masaki Ota <masaki.ota@alpsalpine.com>
>>>> Cc: Mario Limonciello <mario.limonciello@dell.com>; open list:HID CORE
>>>> LAYER <linux-input@vger.kernel.org>; Linux Kernel Mailing List
>>>> <linux-kernel@vger.kernel.org>
>>>> Subject: Alps touchpad generates IRQ storm after S3
>>>> 
>>>> Hi Masaki,
>>>> 
>>>> The Alps touchpad (044E:1220) on Dell Precision 7530 causes IRQ storm
>>>> after system suspend (S3).
>>>> Commit "HID: i2c-hid: Don't reset device upon system resume” which solves
>>>> the same issue for other vendors, cause the issue on Alps touchpad.
>>>> So I’d like to know the correct command Alps touchpad expects after
>>>> system resume.
>>>> 
>>>> Also Cc Mario because this could relate to BIOS.
>>>> 
>>>> Kai-Heng
> 
> 
