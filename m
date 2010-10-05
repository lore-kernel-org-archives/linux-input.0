From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 0/2] HID: hidraw, fix two NULL pointer dereferences
Date: Tue, 05 Oct 2010 23:12:00 +0200
Message-ID: <4CAB94A0.8040402@gmail.com>
References: <alpine.LNX.2.00.1010041548580.29535@pobox.suse.cz> <1286292017-6746-1-git-send-email-ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41899 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756526Ab0JEVME (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 5 Oct 2010 17:12:04 -0400
In-Reply-To: <1286292017-6746-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Alan Ott <alan@signal11.us>, Oliver Neukum <oliver@neukum.name>, linux-kernel@vger.kernel.org, stable@kernel.org

On 10/05/2010 05:20 PM, Antonio Ospite wrote:
> here are some fixes to hidraw.
> 
> Patches are against 2.6.36-rc6, but they should be ported to other
> maintained stable kernels as well.
> 
> Antonio Ospite (2):
>   HID: hidraw, fix a NULL pointer dereference in hidraw_ioctl
>   HID: hidraw, fix a NULL pointer dereference in hidraw_write

Hi, please fix also the window in hidraw_release.

thanks,
-- 
js
