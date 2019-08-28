From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: Alps touchpad generates IRQ storm after S3
Date: Wed, 28 Aug 2019 14:58:12 +0800
Message-ID: <A118551C-A0D9-485F-91F7-44A5BE228B99@canonical.com>
References: <44F93018-5F13-4932-A5AC-9D288CDF68DD@canonical.com>
 <TYAPR01MB30223CB8A576C7809F6382C1ECA30@TYAPR01MB3022.jpnprd01.prod.outlook.com>
 <TYXPR01MB1470902D804A47EE72013006C8A30@TYXPR01MB1470.jpnprd01.prod.outlook.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TYXPR01MB1470902D804A47EE72013006C8A30@TYXPR01MB1470.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiaojian Cao <xiaojian.cao@cn.alps.com>
Cc: Masaki Ota <masaki.ota@alpsalpine.com>, Mario Limonciello <mario.limonciello@dell.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Naoki Saito <naoki.saito@alpsalpine.com>
List-Id: linux-input@vger.kernel.org

Hi Xiaojian,

at 14:51, Xiaojian Cao <xiaojian.cao@cn.alps.com> wrote:

> Hi Ota-san,
>
> OK, we will look into it.
>
>
> Hi Kai-Heng,
>
> We will try to reproduce this issue first, could you please tell me the  
> target Ubuntu version?

It’s distro-agnostic, any distro with mainline Linux can reproduce the issue.

Kai-Heng

>
> Best regards,
> Jason
>
> -----Original Message-----
> From: 太田 真喜 Masaki Ota <masaki.ota@alpsalpine.com>
> Sent: Wednesday, August 28, 2019 2:35 PM
> To: 曹 曉建 Xiaojian Cao <xiaojian.cao@cn.alps.com>; Kai-Heng Feng  
> <kai.heng.feng@canonical.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>; open list:HID CORE  
> LAYER <linux-input@vger.kernel.org>; Linux Kernel Mailing List  
> <linux-kernel@vger.kernel.org>; 斉藤 直樹 Naoki Saito  
> <naoki.saito@alpsalpine.com>
> Subject: RE: Alps touchpad generates IRQ storm after S3
>
> Hi, Kai-Heng,
>
> Sorry, I'm not in charge of Linux task now.
>
> Hi, XiaoJian,
>
> Please check the following mail.
> If you have any question, please ask Kai-Heng.
>
> Best Regards,
> Masaki Ota
> -----Original Message-----
> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Sent: Wednesday, August 28, 2019 3:22 PM
> To: 太田 真喜 Masaki Ota <masaki.ota@alpsalpine.com>
> Cc: Mario Limonciello <mario.limonciello@dell.com>; open list:HID CORE  
> LAYER <linux-input@vger.kernel.org>; Linux Kernel Mailing List  
> <linux-kernel@vger.kernel.org>
> Subject: Alps touchpad generates IRQ storm after S3
>
> Hi Masaki,
>
> The Alps touchpad (044E:1220) on Dell Precision 7530 causes IRQ storm  
> after system suspend (S3).
> Commit "HID: i2c-hid: Don't reset device upon system resume” which solves  
> the same issue for other vendors, cause the issue on Alps touchpad.
> So I’d like to know the correct command Alps touchpad expects after  
> system resume.
>
> Also Cc Mario because this could relate to BIOS.
>
> Kai-Heng
