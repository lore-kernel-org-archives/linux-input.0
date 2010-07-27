From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: Can I expect in-kernel decoding to work out of box?
Date: Wed, 28 Jul 2010 02:32:30 +0300
Message-ID: <1280273550.32216.4.camel@maxim-laptop>
References: <1280269990.21278.15.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:63056 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751439Ab0G0Xci (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jul 2010 19:32:38 -0400
Received: by bwz1 with SMTP id 1so3642633bwz.19
        for <linux-input@vger.kernel.org>; Tue, 27 Jul 2010 16:32:36 -0700 (PDT)
In-Reply-To: <1280269990.21278.15.camel@maxim-laptop>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jarod Wilson <jarod@wilsonet.com>
Cc: Jon Smirl <jonsmirl@gmail.com>, linux-input <linux-input@vger.kernel.org>, Mauro Carvalho Chehab <mchehab@redhat.com>

On Wed, 2010-07-28 at 01:33 +0300, Maxim Levitsky wrote: 
> Hi,
> 
> I ported my ene driver to in-kernel decoding.
> It isn't yet ready to be released, but in few days it will be.
> 
> Now, knowing about wonders of in-kernel decoding, I try to use it, but
> it just doesn't work.
> 
> Mind you that lircd works with this remote.
> (I attach my lircd.conf)
> 
> Here is the output of mode2 for a single keypress:

Just want to add that I tested it with many different modes of my
remotes, and all but one fail (one mode is detected as NEC).

Don't get me wrong.
Although I opposed to idea of in-kernel decoding, lately I began to
think that this isn't such a bad idea.
Especially if number of users for whom it will work out of box.

So, I am very disappointed.

Best regards,
Maxim Levitsky

