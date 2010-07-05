From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH] hid-magicmouse: Correct parsing of large X and Y
 motions.
Date: Mon, 05 Jul 2010 16:51:58 -0400
Message-ID: <1278363118.10426.15.camel@cndougla>
References: <878w5qaspq.fsf@troilus.org>
	 <AANLkTim9R0ur7r2Y3r3bOMIRSM7JYVcZdGZ0QMaYvK4X@mail.gmail.com>
	 <1278360120.2425.97.camel@cndougla>  <87wrt9acu5.fsf@troilus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from adelie.canonical.com ([91.189.90.139]:58628 "EHLO
	adelie.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753056Ab0GEUwC (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Jul 2010 16:52:02 -0400
In-Reply-To: <87wrt9acu5.fsf@troilus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michael Poole <mdpoole@troilus.org>
Cc: Ping Cheng <pinglinux@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

On Mon, 2010-07-05 at 16:33 -0400, Michael Poole wrote:
> C99 says that the result of right-shifting a negative value is
> compiler-defined.  gcc documents that it ensures sign extension.  Other
> parts of hid-magicmouse.c use this idiom already.  The corresponding
> idiom in hid-core.c (see the snto32() function) would look something
> like this:
> 
>       x = ((data[3] & 0x0c) << 6) | data[1];
>       x |= (x & (1 << 9)) ? (-1 << 10) : 0;

snto32() seems like something we should be using in hid-magicmouse.c? On
further thought, it actually seems like something that should be a macro
in linux/kernel.h. I would think there could be utility for it in many
places of the kernel.

-- Chase

