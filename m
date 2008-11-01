From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] USBHID: correct start/stop cycle
Date: Sun, 02 Nov 2008 00:07:20 +0100
Message-ID: <490CE128.3020007@gmail.com>
References: <1225579306-28524-1-git-send-email-jirislaby@gmail.com> <alpine.LNX.1.10.0811020000360.29633@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:7521 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396AbYKAXH0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Nov 2008 19:07:26 -0400
In-Reply-To: <alpine.LNX.1.10.0811020000360.29633@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jeroen Roovers <jer@gentoo.org>, Helge Deller <deller@gmx.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/02/2008 12:02 AM, Jiri Kosina wrote:
> On Sat, 1 Nov 2008, Jiri Slaby wrote:
> 
>> `stop' left out usbhid->urb* pointers and so the next `start' thought
>> it needs to allocate nothing and used the memory pointers previously
>> pointed to. This led to memory corruption and device malfunction.
[...]
> could you please verify whether this patch fixes the corruption you were 
> experiencing?

btw. this is not expected to fix that, but if it does, the better ;).

This fixes
echo DEVICE > /sys/bus/hid/drivers/DRIVER/unbind
echo DEVICE > /sys/bus/hid/drivers/DRIVER/bind
failures.

But maybe parisc does something differently than x86 in bus handling so that it
triggers...
