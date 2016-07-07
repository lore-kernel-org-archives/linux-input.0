From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH 1/2] HID: logitech-hidpp: add battery support for HID++
 2.0 devices
Date: Thu, 7 Jul 2016 11:34:58 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1607071134380.24757@cbobk.fhfr.pm>
References: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1467192482-2723-1-git-send-email-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Nestor Lopez Casado <nlopezcasad@logitech.com>
List-Id: linux-input@vger.kernel.org

On Wed, 29 Jun 2016, Peter Hutterer wrote:

> If the 0x1000 Unified Battery Level Status feature exists, expose the battery
> level.
> 
> The main drawback is that while a device is plugged in its battery level is 0.
> To avoid exposing that as 0% charge we make up a number based on the charging
> status.
> 
> Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Merged both patches to hid.git#for-4.8/logitech-hidpp-battery. Thanks,

-- 
Jiri Kosina
SUSE Labs
