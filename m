From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Enable addition function keys
Date: Mon, 23 May 2011 23:22:56 -0700
Message-ID: <20110524062256.GA20829@core.coreip.homeip.net>
References: <000001cc1403$1e0ede10$5a2c9a30$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:50791 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819Ab1EXGXC (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 May 2011 02:23:02 -0400
Received: by pzk9 with SMTP id 9so2862162pzk.19
        for <linux-input@vger.kernel.org>; Mon, 23 May 2011 23:23:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <000001cc1403$1e0ede10$5a2c9a30$@com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Christen <davidchristen@gmail.com>
Cc: linux-input@vger.kernel.org

Hi David,

On Mon, May 16, 2011 at 09:54:49PM +0200, David Christen wrote:
> I have a custom made keyboard with 48 Function keys attached to an embedded
> PC running on a RISC CPU. With hid module in the kernel the regular part of
> the keyboard (i.e. all letters, num pad and Fxx keys up to F12) are working
> perfectly fine. However with the additional keys I don't get any events in
> /dev/input/event0. This is the same behavior as found on a regular Linux PC
> and also under Windows. Although the manufacturer of the keyboard confirmed
> that those keys do send proper HID codes (0x68 to 0x8b for F13 to F48).
> I don't have any experience in programming on the Kernel level. Could you
> maybe direct me in how to get the input events of those keys running?
> 

Even though the usage codes are not mapped you should be able to map
them yourself using EVIOCSKEYCODE ioctl. See udev sources for how to
adjust keymaps on input devices.

We have F1 through F24 keycode defines, but no F25-F48 (nor do I want to
add these since userspace would not really know what to do with these,
they are device-specific); you'll have to pick some standard ones that
match the functions you want to assign to your extended keys.

Hope this helps.

-- 
Dmitry
