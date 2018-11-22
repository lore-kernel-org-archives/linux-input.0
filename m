From: Kai Heng Feng <kai.heng.feng@canonical.com>
Subject: Elantech SMBus support regression
Date: Thu, 22 Nov 2018 12:21:55 +0800
Message-ID: <6E2F161C-046B-4D5F-B831-B1308A554C40@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 12.1 \(3445.101.1\))
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi Benjamin,

It appears the Elantech SMBus support breaks some users’ touchpad.

Please have a look at [1] [2], thanks!

[1] https://bugs.launchpad.net/bugs/1803600
[2] https://bugs.archlinux.org/task/59714

Kai-Heng
