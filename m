From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH 0/2] xen pvfb: Para-virtual framebuffer,	keyboard and
 pointer
Date: Thu, 21 Feb 2008 11:45:03 -0800
Message-ID: <47BDD4BF.3000808@goop.org>
References: <871w76ejdg.fsf@pike.pond.sub.org> <87hcg2cyti.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gw.goop.org ([64.81.55.164]:59388 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758891AbYBUTrW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Feb 2008 14:47:22 -0500
In-Reply-To: <87hcg2cyti.fsf@pike.pond.sub.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Armbruster <armbru@redhat.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, dmitry.torokhov@gmail.com, virtualization@lists.osdl.org, linux-input@vger.kernel.org, adaplas@pol.net, akpm@linux-foundation.org, jayakumar.lkml@gmail.com

Markus Armbruster wrote:
> Forgot to mention: This patch depends on
>
>     Subject: [PATCH] xen: Make xen-blkfront write its protocol ABI to xenstore
>     From: Markus Armbruster <>
>     Date: Thu, 06 Dec 2007 14:45:53 +0100
>
> http://lkml.org/lkml/2007/12/6/132
>
> Sorry!

Sorry, I haven't pushed this upstream yet, since there didn't seem to be 
any particular urgency.  What's the dependency?

    J
