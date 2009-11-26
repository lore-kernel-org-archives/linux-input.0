From: lirc@bartelmus.de (Christoph Bartelmus)
Subject: Re: [RFC] Should we create a raw input interface for IR's ? - Was: Re: [PATCH 1/3 v2] lirc core device driver infrastructure
Date: 26 Nov 2009 08:28:00 +0100
Message-ID: <BDcbfiXJjFB@christoph>
References: <4B0DBC2D.1010603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:58704 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759227AbZKZIDa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Nov 2009 03:03:30 -0500
In-Reply-To: <4B0DBC2D.1010603@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: kraxel@redhat.com
Cc: awalls@radix.net, dheitmueller@kernellabs.com, dmitry.torokhov@gmail.com, j@jannau.net, jarod@redhat.com, jarod@wilsonet.com, khc@pm.waw.pl, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, mchehab@redhat.com, superm1@ubuntu.com

Hi Gerd,

on 26 Nov 09 at 00:22, Gerd Hoffmann wrote:
[...]
>> To sum it up: I don't think this information will be useful at all for
>> lircd or anyone else.
[...]
> I know that lircd does matching instead of decoding, which allows to
> handle unknown encodings.  Thats why I think there will always be cases
> which only lircd will be able to handle (using raw samples).
>
> That doesn't make attempts to actually decode the IR samples a useless
> exercise though ;)

Well, in my opinion it is kind of useless. I don't see any use case or any  
demand for passing this kind of information to userspace, at least in the  
LIRC context.
If there's no demand, why bother?

Christoph
