From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: Fri, 27 Nov 2009 00:34:30 +0000
Message-ID: <200911270034.30957.arnd@arndb.de>
References: <200910200956.33391.jarod@redhat.com> <4B0EFC30.80208@redhat.com> <m38wdsstsv.fsf@intrepid.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:49319 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752892AbZK0Aec (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 19:34:32 -0500
In-Reply-To: <m38wdsstsv.fsf@intrepid.localdomain>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Mauro Carvalho Chehab <mchehab@redhat.com>, Jarod Wilson <jarod@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Mario Limonciello <superm1@ubuntu.com>, linux-input@vger.kernel.org, linux-media@vger.kernel.org, Janne Grunau <j@jannau.net>, Christoph Bartelmus <lirc@bartelmus.de>

On Friday 27 November 2009 00:19:44 Krzysztof Halasa wrote:
> Mauro Carvalho Chehab <mchehab@redhat.com> writes:
> 
> > Why do you want to replace everything into a single shot?
> 
> Why not? It seems simpler to me. We need to change this anyway.

ioctls with a variable argument length are a pain for 32 bit
emulation and stuff like strace. You either need to encode
the variable length into the ioctl cmd, making it variable
as well, or use a pointer in the data structure, which requires
conversion.

Ideally, ioctl arguments have a constant layout, no pointers
and are at most 64 bits long.

	Arnd <><
