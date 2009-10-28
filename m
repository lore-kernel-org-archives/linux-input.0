From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC PATCH 1/1] Input: gpio-keys: export gpio key information
	through sysfs
Date: Tue, 27 Oct 2009 22:43:17 -0700
Message-ID: <20091028054317.GB2368@core.coreip.homeip.net>
References: <cover.1256298993.git.ext-mika.1.westerberg@nokia.com> <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:57780 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756744AbZJ1FnQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 28 Oct 2009 01:43:16 -0400
Received: by pwj9 with SMTP id 9so601236pwj.21
        for <linux-input@vger.kernel.org>; Tue, 27 Oct 2009 22:43:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <937a56e01181bef04c6661dc61032c1d08269cfa.1256298993.git.ext-mika.1.westerberg@nokia.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
Cc: linux-input@vger.kernel.org

Hi Mika,

On Fri, Oct 23, 2009 at 03:15:46PM +0300, Mika Westerberg wrote:
> From: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
> 
> In some embedded devices gpio lines are used as keys/buttons
> through input layer and gpio-keys.  It is, however, impossible
> to disable gpio lines separately from waking up the cpu.  For
> example when device is locked we don't want accidental camera
> button press to cause the device to wakeup just to notice that
> it should continue sleeping.
> 
> This patch exports gpio-keys through sysfs and allows userland
> to control whether single gpio line should wakeup the cpu or not.
> 
> Sysfs interface is accessible via:
> 
> 	/sys/class/input/gpio-keys/input/input0/gpio-key.N/
> 
> Following attributes are exported per gpio key:
> 
> 	/code    ... input event code (ro)
> 	/type    ... input event type (ro)
> 	/desc    ... description of the button (ro)
> 	/disable ... enable/disable gpio line (rw)
> 
> Userspace should be able to find out what key to disable/enable
> by investigating {code, type, desc} tuple.
> 

I think registering a full-blown device for every key is way too much,
given that most consumers of gpio-keys driver are embedded... Besides, I
don't think this should be driven from userspace. Board (platform) code
should know what GPIO make sense as wake up sources for the particular
device and should set up platform data accordingly.

-- 
Dmitry
