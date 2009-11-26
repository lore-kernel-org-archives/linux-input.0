From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] Input: i8042 - add Dell Vostro 1520 and 1720 to the
 reset list
Date: Thu, 26 Nov 2009 11:05:00 +0100
Message-ID: <20091126110500.735461ac@destiny.ordissimo>
References: <20091124151250.03e185d1@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ew0-f219.google.com ([209.85.219.219]:55295 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030AbZKZKGF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 05:06:05 -0500
In-Reply-To: <20091124151250.03e185d1@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Dmitry,

Sorry for the badly threaded reply, I wasn't subscribed to the list and
didn't ask explicitely to be Cc-ed.

>On Wed, 25 Nov 2009 12:17:37 -0800, Dmitry Torokhov wrote:
>Could youplease explain in more detail what the "bad state" is.
>And what exactly do you mean by "first boot"? Cold boot? The very
>first boot after assembling? Something else?

By bad state I mean that neither touchpad nor keyboard are working. They
are both unresponsive. You can fix this by adding i8042.reset on the
kernel command line, or removing the battery and waiting long enough.
By very first boot I mean when the laptops are received from Dell and
booted in Linux.

If you cold boot with a working non-Dell power supply (with same
electrical characteristics), you can reproduce the "first boot" bug as
much as you want, and laptops won't work unless you remove the battery
and wait long enough OR add i8042.reset on the cmdline.

Regards,

--
Anisse
