From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: HID bus
Date: Wed, 16 Apr 2008 22:30:54 +0200
Message-ID: <480661FE.1040807@gmail.com>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com> <1207341357-17792-8-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.155]:61872 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYDPUbF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 16:31:05 -0400
Received: by fg-out-1718.google.com with SMTP id l27so2551531fgb.17
        for <linux-input@vger.kernel.org>; Wed, 16 Apr 2008 13:31:03 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, marcel@holtmann.org, dmitry.torokhov@gmail.com, Jiri Slaby <jslaby@suse.cz>

On 04/16/2008 03:31 PM, Jiri Kosina wrote:
> Otherwise default kernel configuration might make the hardware that worked 
> properly in previous versions not to work with new kernel.

Actually I have one problem here. Autoloading. I don't have any idea how to 
solve it. To solve it backward compatible with older userspace (if I would 
change module-init-tools). I'm thinking only about a default-y option which 
inhibits these drivers as a module for some time until the change gfets 
propagated (and user decides he no longer needs it).

Modules are supposed to have MODULE_DEVICE_TABLE(hid, table) (which has another 
minor issue with different buses). This won't load any module, since depmod et 
al. don't know this device table so far.

Any ideas, please?

