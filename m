From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Intel ISH doesn't generate IRQ
Date: Wed, 6 Mar 2019 16:02:19 +0800
Message-ID: <C416C03D-EFD6-4C03-B04B-9E9FEA57F493@canonical.com>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Content-Type: text/plain;
        charset=utf-8;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: hong.liu@intel.com, hongyan.song@intel.com, "open list:HID CORE LAYER" <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Hi,

This is an old issue filed at [1].

Few days ago I noticed there’s a new commit 74fbc7d371d9 ("HID:  
intel-ish-hid: add MSI interrupt support”) that may solve the problem.
Unfortunately it the device in question doesn’t support MSI and MSI-X, so  
the commit doesn’t make any difference.

Please let me know what additional information I can provide.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=200775

Kai-Heng
