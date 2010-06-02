From: Daniel Mack <daniel@caiaq.de>
Subject: Re: rotary encoder
Date: Wed, 2 Jun 2010 15:52:51 +0200
Message-ID: <20100602135251.GC2695@buzzloop.caiaq.de>
References: <7A46ED6446BE4CF7AAC51205F1B5A88B@tech>
 <20100602132031.GB2695@buzzloop.caiaq.de>
 <BA41AF5D757645AD94502E4B0A29158A@tech>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from buzzloop.caiaq.de ([212.112.241.133]:53058 "EHLO
	buzzloop.caiaq.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211Ab0FBNw4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Jun 2010 09:52:56 -0400
Content-Disposition: inline
In-Reply-To: <BA41AF5D757645AD94502E4B0A29158A@tech>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Vasil'ev <tech@digiton.ru>
Cc: linux-input@vger.kernel.org

(please don't drop any Cc'ed addresses)

On Wed, Jun 02, 2010 at 05:28:35PM +0400, Dmitriy Vasil'ev wrote:
> thank you for reply,
> 
> I am using custom variant of the Atmel's board at91sam9260-ek.
> Yes, I understand how I can attach your driver to my board.
> 
> But how I can use events in user space?
> 
> Do I must using /dev/input/evenX for processing encoder's events?

Yes, once the driver is successfully probed, you should see a message in
dmesg. Can you post your dmesg output? Depending on your platform_data,
you should then get relative or absolute axis information in the
/dev/input handle the driver allocated.

> How I can translate it to keyboard codes?

Up to you, or your userspace application :)

> Sorry for my stupid questions.

No problem. Just remember to keep the mailing list in the Cc, so others
can follow and respond as well.

Thanks,
Daniel

