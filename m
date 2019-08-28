From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Alps touchpad generates IRQ storm after S3
Date: Wed, 28 Aug 2019 14:22:18 +0800
Message-ID: <44F93018-5F13-4932-A5AC-9D288CDF68DD@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: masaki.ota@jp.alps.com
Cc: Mario Limonciello <mario.limonciello@dell.com>, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Masaki,

The Alps touchpad (044E:1220) on Dell Precision 7530 causes IRQ storm after  
system suspend (S3).
Commit "HID: i2c-hid: Don't reset device upon system resume” which solves  
the same issue for other vendors, cause the issue on Alps touchpad.
So I’d like to know the correct command Alps touchpad expects after system  
resume.

Also Cc Mario because this could relate to BIOS.

Kai-Heng
