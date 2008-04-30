From: Kevin Milburn <linux-user@kmilburn.me.uk>
Subject: Re: support for Logitech Wave
Date: Wed, 30 Apr 2008 11:41:08 +0100
Message-ID: <200804301141.08619.linux-user@kmilburn.me.uk>
References: <200804250012.19227.linux-user@kmilburn.me.uk> <200804281131.06389.linux-user@kmilburn.me.uk> <Pine.LNX.4.64.0804301119050.7756@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pih-relay08.plus.net ([212.159.14.134]:42470 "EHLO
	pih-relay08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756056AbYD3KlN (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Apr 2008 06:41:13 -0400
In-Reply-To: <Pine.LNX.4.64.0804301119050.7756@jikos.suse.cz>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

On Wednesday 30 April 2008 10:21:16 Jiri Kosina wrote:
> The keyboard probably has two separate interfaces, with some multimedia
> keys being reported on a different one. That's why you see them in evbug
> output, but not in evtest output, because they appear under different
> event device.

I''m sure I tried that before,  but from retesting today I guess I didn't....

You're right,   the missing keys reported by evbug are showing up in evtest 
when I connect to the second event interface,  a.k.a 
usb-Logitech_USB_Receiver-event-mouse.

so it is just the ones that evbug wasn't reporting that are missing...

Looks like I need to have some fun with getting xkbd and evdev in X working 
properly.....

TIA
Kev.
