From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: HID bus
Date: Wed, 16 Apr 2008 16:45:51 -0400
Message-ID: <20080416164500.ZZRA012@mailhub.coreip.homeip.net>
References: <1207341357-17792-1-git-send-email-jirislaby@gmail.com> <1207341357-17792-8-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0804161529270.12972@jikos.suse.cz> <480661FE.1040807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:15772 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbYDPUqA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 16 Apr 2008 16:46:00 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1412021ywb.1
        for <linux-input@vger.kernel.org>; Wed, 16 Apr 2008 13:45:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <480661FE.1040807@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, marcel@holtmann.org, Jiri Slaby <jslaby@suse.cz>

On Wed, Apr 16, 2008 at 10:30:54PM +0200, Jiri Slaby wrote:
> On 04/16/2008 03:31 PM, Jiri Kosina wrote:
>> Otherwise default kernel configuration might make the hardware that worked 
>> properly in previous versions not to work with new kernel.
>
> Actually I have one problem here. Autoloading. I don't have any idea how to 
> solve it. To solve it backward compatible with older userspace (if I would 
> change module-init-tools). I'm thinking only about a default-y option which 
> inhibits these drivers as a module for some time until the change gfets 
> propagated (and user decides he no longer needs it).
>
> Modules are supposed to have MODULE_DEVICE_TABLE(hid, table) (which has 
> another minor issue with different buses). This won't load any module, 
> since depmod et al. don't know this device table so far.
>
> Any ideas, please?
>

When I added serio bus I had to send patches to Rusty for
module-init-tools... No way around it as far as I understand.

-- 
Dmitry
