From: "Jaya Kumar" <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH 2/3] fbdev: Make deferred I/O work as advertized
Date: Tue, 26 Feb 2008 09:11:45 -0500
Message-ID: <45a44e480802260611l5a8d0bc9k9cc967bc73b88fac@mail.gmail.com>
References: <87tzjx6vj3.fsf@pike.pond.sub.org>
	 <87k5kt6vd3.fsf@pike.pond.sub.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gv-out-0910.google.com ([216.239.58.190]:56017 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757418AbYBZOLt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Feb 2008 09:11:49 -0500
Received: by gv-out-0910.google.com with SMTP id s4so871644gve.37
        for <linux-input@vger.kernel.org>; Tue, 26 Feb 2008 06:11:47 -0800 (PST)
In-Reply-To: <87k5kt6vd3.fsf@pike.pond.sub.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Markus Armbruster <armbru@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, akpm@linux-foundation.org

On Mon, Feb 25, 2008 at 8:03 AM, Markus Armbruster <armbru@redhat.com> wrote:
>
>     Subject: [PATCH 1/1 2.6.24] fbdev: defio and Metronomefb
>     From: Jaya Kumar <jayakumar.lkml@gmail.com>
>     Date: 2008-02-18 13:41:26

Hi Markus,

Andrew pointed out that there may be race conditions associated with
this patch. [ http://marc.info/?l=linux-fbdev-devel&m=120376473020396&w=2
] So I would not encourage anyone to merge it. I'll try to figure
things out this weekend.

Thanks,
jaya
