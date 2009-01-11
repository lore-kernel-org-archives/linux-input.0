From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: Make MOUSE_PS2_LIFEBOOK depend on X86
Date: Sat, 10 Jan 2009 22:10:18 -0800
Message-ID: <20090110220954.ZZRA012@mailhub.coreip.homeip.net>
References: <20090109105229.37c2a09b@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:34792 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbZAKGLA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2009 01:11:00 -0500
Received: by an-out-0708.google.com with SMTP id d40so3317780and.1
        for <linux-input@vger.kernel.org>; Sat, 10 Jan 2009 22:10:57 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20090109105229.37c2a09b@hyperion.delvare>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-input@vger.kernel.org

On Fri, Jan 09, 2009 at 10:52:29AM +0100, Jean Delvare wrote:
> As far as I know, all Fujitsu-Siemens Lifebook systems are x86-based.
> So we might as well make MOUSE_PS2_LIFEBOOK depend on X86. This will
> avoid surprising things like:
> 
> arch/arm/configs/s3c2410_defconfig:CONFIG_MOUSE_PS2_LIFEBOOK=y
> 

Applied, thank you Jean.

-- 
Dmitry
