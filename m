From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: How to handle laptop with Elantech touchpad that chokes on
	current driver configuration values?
Date: Sun, 13 Sep 2009 21:39:46 -0700
Message-ID: <20090914043946.GC11854@core.coreip.homeip.net>
References: <20090911132530.GA2708@adopmeer.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f189.google.com ([209.85.216.189]:45263 "EHLO
	mail-px0-f189.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1749667AbZINEjr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Sep 2009 00:39:47 -0400
Content-Disposition: inline
In-Reply-To: <20090911132530.GA2708@adopmeer.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Arjan Opmeer <arjan@opmeer.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Arjan,

On Fri, Sep 11, 2009 at 03:25:30PM +0200, Arjan Opmeer wrote:
> 
> Recently I debugged a problem for a user where the Elantech touchpad of his
> laptop chokes on the configuration values that the current kernel driver is
> using. After sending a conflicting value the PS/2 controller freezes and
> doesn't accept any subsequent bytes.
> 
> The current configuration values for hardware version 2 (EeePC style) come
> from the touchpad driver in the original Xandros Linux distribution for the
> EeePC. And until now I haven't heard of problems with them. They look like
> this:
> 
>    etd->reg_10 = 0x54;
>    etd->reg_11 = 0x88;
>    etd->reg_21 = 0x60;
> 
> Some time ago I received the updated touchpad driver that is used in the
> Dell mini Ubuntu distribution. Here the values are changed to be the same as
> most of the Windows driver are using. Notice the difference in register 0x11
> and how they dropped configuring register 0x21:
> 
>    etd->reg_10 = 0x54;
>    etd->reg_11 = 0x8a;
> 
> However for the laptop of the user mentioned above the values of his Windows
> driver are like this:
> 
>    etd->reg_10 = 0x64;
>    etd->reg_11 = 0x8a;
> 
> Notice the different values for registers 0x10 and 0x11 in comparison with
> the current kernel driver. Also the registers _must_ be configured like
> this. Using the current kernel driver values for either one of the registers
> makes the touchpad freeze up.
> 
> Remember that there isn't any publicly available documentation for the
> hardware, so these configuration values are "black magic numbers" and the
> only source of them is snooping what Windows drivers do or the source of
> drivers in dedicated Linux distributions that happen to come my way.
> 
> In all cases this is about touchpads with a firmware version reply of 0x02,
> 0x00, 0x30. So even though the touchpad in this users laptops seems to be
> the same as in the EeePC it really requires different values to be
> configured.
> 
> My question now is what is a prudent way to go forward?
> 
> Is it OK that add a DMI check to the kernel driver that matches this users
> laptop and dynamically adjust the configuration values?
> 

I think adding some DMI rules to prevent the device lockup should be OK.

> And how about the common case? Do we keep the values in the driver as they
> are, or do we update them to the revised numbers as learned from the Ubuntu
> driver?
> 

I'd keep them as is at least for now, until we understand what exactly
the change.

-- 
Dmitry
