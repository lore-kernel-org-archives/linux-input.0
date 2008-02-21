From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 0/2] xen pvfb: Para-virtual framebuffer,	keyboard and pointer
Date: Thu, 21 Feb 2008 21:47:09 +0100
Message-ID: <871w76ca0i.fsf@pike.pond.sub.org>
References: <871w76ejdg.fsf@pike.pond.sub.org>
	<87hcg2cyti.fsf@pike.pond.sub.org> <47BDD4BF.3000808@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:45886 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765314AbYBUUt3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Feb 2008 15:49:29 -0500
In-Reply-To: <47BDD4BF.3000808@goop.org> (Jeremy Fitzhardinge's message of "Thu\, 21 Feb 2008 11\:45\:03 -0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org, jayakumar.lkml@gmail.com

Jeremy Fitzhardinge <jeremy@goop.org> writes:

> Markus Armbruster wrote:
>> Forgot to mention: This patch depends on
>>
>>     Subject: [PATCH] xen: Make xen-blkfront write its protocol ABI to xenstore
>>     From: Markus Armbruster <>
>>     Date: Thu, 06 Dec 2007 14:45:53 +0100
>>
>> http://lkml.org/lkml/2007/12/6/132
>>
>> Sorry!
>
> Sorry, I haven't pushed this upstream yet, since there didn't seem to
> be any particular urgency.  What's the dependency?
>
>    J

Here's the description again:

    Frontends are expected to write their protocol ABI to xenstore.  Since
    the protocol ABI defaults to the backend's native ABI, things work
    fine without that as long as the frontend's native ABI is identical to
    the backend's native ABI.  This is not the case for xen-blkfront
    running 32-on-64, because its ABI differs between 32 and 64 bit, and
    thus needs this fix.

I can break the dependency by putting the same bug that is now in
xen-blkfront into xen-fbfront and xen-kbdfront.
