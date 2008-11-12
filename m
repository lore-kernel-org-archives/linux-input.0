From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Who broke cb8f488c33 patch? (was Re: [PATCH 1/1] USBHID: correct
 start/stop cycle)
Date: Wed, 12 Nov 2008 10:23:25 +0100
Message-ID: <491AA08D.9080401@gmail.com>
References: <1225579306-28524-1-git-send-email-jirislaby@gmail.com>	<200811022024.31528.vda.linux@googlemail.com>	<alpine.LNX.1.10.0811120021500.24889@jikos.suse.cz>	<200811120124.41222.vda.linux@googlemail.com>	<alpine.LNX.1.10.0811120126320.24889@jikos.suse.cz> <20081111165038.fb1f2f45.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:20829 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYKLJXb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 12 Nov 2008 04:23:31 -0500
Received: by ey-out-2122.google.com with SMTP id 6so124518eyi.37
        for <linux-input@vger.kernel.org>; Wed, 12 Nov 2008 01:23:30 -0800 (PST)
In-Reply-To: <20081111165038.fb1f2f45.akpm@linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Kosina <jkosina@suse.cz>, vda.linux@googlemail.com, hugh@veritas.com, torvalds@linux-foundation.org, deller@gmx.de, jer@gentoo.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 11/12/2008 01:50 AM, Andrew Morton wrote:
>>> let's fix it for good.
>>> Signed-off-by: Denys Vlasenko <vda.linux@googlemail.com>
>>> --- linux-2.6.28-rc4/mm/mmap.c	Mon Nov 10 01:36:15 2008
>>> +++ linux-2.6.28-rc4.fix/mm/mmap.c	Wed Nov 12 01:21:39 2008
>>> @@ -1704,7 +1704,7 @@
>>>  	vma = find_vma_prev(mm, addr, &prev);
>>>  	if (vma && (vma->vm_start <= addr))
>>>  		return vma;
>>> -	if (expand_stack(prev, addr))
>>> +	if (!prev || expand_stack(prev, addr))
>>>  		return NULL;
>>>  	if (prev->vm_flags & VM_LOCKED) {
>>>  		if (mlock_vma_pages_range(prev, addr, prev->vm_end) < 0)
> 
> It looks like this was caused by me fixing rejects.  That was the fancy
> include-lots-of-context-so-it-wont-apply patch.

Great, this one got fixed. Helge, did you proceed with bisecting which another
commit breaks parics while having this one applied?

Thanks.
