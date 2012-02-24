From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: disable touchpad?
Date: Fri, 24 Feb 2012 13:31:16 -0800
Message-ID: <1396991.aDtuZKT2u4@dtor-d630.eng.vmware.com>
References: <4F47ED34.1070406@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:61544 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755810Ab2BXVba (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 24 Feb 2012 16:31:30 -0500
Received: by pbcun15 with SMTP id un15so3080636pbc.19
        for <linux-input@vger.kernel.org>; Fri, 24 Feb 2012 13:31:30 -0800 (PST)
In-Reply-To: <4F47ED34.1070406@xenotime.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: linux-input@vger.kernel.org

Hi Randy,

On Friday, February 24, 2012 12:04:04 PM Randy Dunlap wrote:
> Hi,
> 
> (a) Laptop touchpads can be a nuisance.  Is there a convenient way to
> disable them?
> 

I'd start here: https://help.ubuntu.com/community/SynapticsTouchpad

> (b) My Toshiba Portege laptop has a touchpad on/off button.  Is that
> supported?

Kernel probably emits one of KEY_TOUCHPAD_* for it; whether it is handled
in userspace I do not know.

-- 
Dmitry
