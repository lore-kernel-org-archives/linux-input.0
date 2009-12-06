From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] What are the goals for the architecture of an in-kernel IR  system?
Date: 06 Dec 2009 12:59:00 +0100
Message-ID: <BENgzeZHqgB@lirc>
References: <20091206065512.GA14651@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:56041 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751663AbZLFMC0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 6 Dec 2009 07:02:26 -0500
In-Reply-To: <20091206065512.GA14651@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: awalls@radix.net, hermann-pitton@arcor.de, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, jonsmirl@gmail.com, khc@pm.waw.pl, kraxel@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com

Hi Dmitry,

on 05 Dec 09 at 22:55, Dmitry Torokhov wrote:
[...]
> I do not believe you are being realistic. Sometimes we just need to say
> that the device is a POS and is just not worth it. Remember, there is
> still "lirc hole" for the hard core people still using solder to produce
> something out of the spare electronic components that may be made to
> work (never mind that it causes the CPU constantly poll the device, not
> letting it sleep and wasting electricity as a result - just hypotetical
> example here).

The still seems to be is a persistent misconception that the home-brewn  
receivers need polling or cause heavy CPU load. No they don't. All of them  
are IRQ based.
It's the commercial solutions like gpio based IR that need polling.
For transmitters it's a different story, but you don't transmit 24h/7.

Christoph
