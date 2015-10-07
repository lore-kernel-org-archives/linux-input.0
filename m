From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: Input: joydev - validate axis/button maps before clobbering
 current ones
Date: Wed, 7 Oct 2015 10:51:53 +0200
Message-ID: <5614DD29.3030103@osg.samsung.com>
References: <20151006185155.GA8997@mwanda>
 <20151006225726.545f4ce5@heffalump.sk2.org> <20151007054658.GX7289@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from lists.s-osg.org ([54.187.51.154]:47599 "EHLO lists.s-osg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751160AbbJGIv5 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Oct 2015 04:51:57 -0400
In-Reply-To: <20151007054658.GX7289@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Stephen Kitt <steve@sk2.org>
Cc: linux-input@vger.kernel.org

Hello Dan,

On 10/07/2015 07:46 AM, Dan Carpenter wrote:
> Oh whoops, I sent this to the wrong person.  Javier, you introduced a
> bug with 5702222c9a7a ('Input: joydev - use memdup_user() to duplicate
> memory from user-space')
> 
> regards,
> dan carpenter
>

Yes, thanks for reporting it but I've already mentioned in this
thread that I posted a fix for it and is already in Dmitry tree:

https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?h=next&id=5b21e3c740b770fb2548a5a8ea66e544d114d0a8

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
