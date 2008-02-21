From: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] fbdev: Make deferred I/O work as advertized
Date: Thu, 21 Feb 2008 18:31:40 +0100
Message-ID: <878x1ecj2b.fsf@pike.pond.sub.org>
References: <871w76ejdg.fsf@pike.pond.sub.org>
	<87ve4id4rb.fsf@pike.pond.sub.org>
	<45a44e480802210830o1041e612sa532acde52e42748@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:37730 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750900AbYBURb7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 21 Feb 2008 12:31:59 -0500
In-Reply-To: <45a44e480802210830o1041e612sa532acde52e42748@mail.gmail.com> (Jaya Kumar's message of "Fri\, 22 Feb 2008 00\:30\:58 +0800")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org, xen-devel@lists.xensource.com, linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, akpm@linux-foundation.org

"Jaya Kumar" <jayakumar.lkml@gmail.com> writes:

> On Thu, Feb 21, 2008 at 5:43 PM, Markus Armbruster <armbru@redhat.com> wrote:
>>  Fix extracted from this linux-fbdev-devel message:
>
> Hi Markus,
>
> Yes, this was discussed back in November on linux-mm and hence my
> patch. I didn't push for it to be merged by itself because I don't
> think it makes sense to merge it separately from the full metronomefb
> patch. As far as I can tell, only hecubafb and metronomefb seem to be
> the consumers.
>
> Out of curiosity, are you using defio or planning to use it? I would
> love to hear back from people who are using it.
>
> Thanks,
> jaya

Converting to fb_defio made xen-fbfront quite a bit simpler and much
more maintainable.  Excellent match.

It took me a bit of time to find your fix, mostly because I assumed my
own code was broken, not fb_defio.  It's best not to make assumptions
about who uses your code; if it's any good, chances are somebody will
find a use you never imagined.
