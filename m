From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Patch to fix Volume keys on AMILO 1848+u (Kernel 2.6.32-rc5)
Date: Mon, 26 Oct 2009 09:31:16 -0700
Message-ID: <20091026163115.GA5636@core.coreip.homeip.net>
References: <AAD0C341-7536-4D53-86B4-C9ADCEB6A407@nextrem.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:38238 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752059AbZJZQbQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 26 Oct 2009 12:31:16 -0400
Received: by pzk26 with SMTP id 26so7510826pzk.4
        for <linux-input@vger.kernel.org>; Mon, 26 Oct 2009 09:31:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AAD0C341-7536-4D53-86B4-C9ADCEB6A407@nextrem.ch>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pascal Bach <pascal.bach@nextrem.ch>
Cc: linux-input@vger.kernel.org

Hi Pascal,

On Mon, Oct 26, 2009 at 11:35:04AM +0100, Pascal Bach wrote:
> The Fn+F7 and Fn+F8 Keys to change the Volume don't work as the don't  
> send a key release event.
>
> The patch I appended adds the Amilo 1848+u to the special handling list 
> of the atkbd.c driver.
>

Thank you for the patch, however since atkbd now allows controlling the
force release bitmap from userspace (via sysfs) I have stopped accepting
kernel quirks and instead ask people to rely on HAL/DeviceKit or some
other userspace solution.

Thanks.

-- 
Dmitry
