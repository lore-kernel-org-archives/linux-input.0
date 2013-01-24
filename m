From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] goldfish: virtual input event driver
Date: Thu, 24 Jan 2013 09:04:57 -0800
Message-ID: <e9d16f77-1e92-48ee-ad51-d775c14e3318@email.android.com>
References: <20130123173840.996.9588.stgit@bob.linux.org.uk> <20130124041547.GB7112@core.coreip.homeip.net> <20130124171642.387d7e40@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:43060 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751617Ab3AXRFJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 24 Jan 2013 12:05:09 -0500
Received: by mail-pa0-f51.google.com with SMTP id fb11so5628616pad.24
        for <linux-input@vger.kernel.org>; Thu, 24 Jan 2013 09:05:09 -0800 (PST)
In-Reply-To: <20130124171642.387d7e40@bob.linux.org.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>
Cc: linux-input@vger.kernel.org

Alan Cox <alan@linux.intel.com> wrote:

>On Wed, 23 Jan 2013 20:15:47 -0800
>Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
>> Hi Alan,
>> 
>> On Wed, Jan 23, 2013 at 05:38:43PM +0000, Alan Cox wrote:
>> > From: Brian Swetland <swetland@google.com>
>> > 
>> > This device is a direct pipe from "hardware" to the input
>> > event subsystem, allowing us to avoid having to route
>> > "keypad" style events through an AT keyboard driver (gross!)
>> > 
>> > As with the other submissions this driver is cross architecture.
>> > 
>> > Signed-off-by: Mike A. Chan <mikechan@google.com>
>> > [Tided up to work on x86]
>> > Signed-off-by: Sheng Yang <sheng@linux.intel.com>
>> > Signed-off-by: Yunhong Jiang <yunhong.jiang@intel.com>
>> > Signed-off-by: Xiaohui Xin <xiaohui.xin@intel.com>
>> > Signed-off-by: Jun Nakajima <jun.nakajima@intel.com>
>> > Signed-off-by: Bruce Beare <bruce.j.beare@intel.com>
>> > [Ported to 3.4]
>> > Signed-off-by: Tom Keel <thomas.keel@intel.com>
>> > [Cleaned up for 3.7 and submission]
>> > Signed-off-by: Alan Cox <alan@linux.intel.com>
>> 
>> I do not have drivers/tty/goldfish.c so I dropped that change... I
>> also had a few more cleanups, the result is below.
>
>Looks good to me - I wasn't sure about the remove method so I copied
>the other keyboard drivers that still had one even though they used
>devm_ methods for the allocation.
>

Probably because some other resources are not devm managed and we need to preserve order. Or maybe just bugs...


Thanks.

-- 
Dmitry
