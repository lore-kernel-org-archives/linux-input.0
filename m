From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] Elantech touchpad detection fix for laptops
Date: Thu, 8 Jan 2015 14:09:54 -0800
Message-ID: <20150108220954.GG23256@dtor-ws>
References: <CAEK4c-_Kirwxj_Rgqn1c7x4h0Mj0r8vhSYb5qQcJvo5TbXdb0Q@mail.gmail.com>
 <CAEK4c-8CsrBaf8gaH2B2kuoMTHrLpLMgGQPrXTZAX3W5At0uoA@mail.gmail.com>
 <20150107074433.GC5256@dtor-ws>
 <CAEK4c-_xcj2JrNEcnARSwWwNQxow+JO1F1hf_d1befApXKNegw@mail.gmail.com>
 <CAEK4c-_GTLu0jRLaX-na2-mou6qGX4A8p2rS7Q_QnM+DNKZWdg@mail.gmail.com>
 <20150108012306.GC8570@dtor-ws>
 <CAEK4c-_gBu4vb3_yb1kQLpvLU+p1789ivmgcVfVgJx-ZdnX7Bw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f172.google.com ([209.85.213.172]:61150 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754724AbbAHWJ6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 8 Jan 2015 17:09:58 -0500
Received: by mail-ig0-f172.google.com with SMTP id hl2so5119589igb.5
        for <linux-input@vger.kernel.org>; Thu, 08 Jan 2015 14:09:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAEK4c-_gBu4vb3_yb1kQLpvLU+p1789ivmgcVfVgJx-ZdnX7Bw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Srihari Vijayaraghavan <linux.bug.reporting@gmail.com>
Cc: linux-input@vger.kernel.org, Mateusz =?utf-8?Q?Jo=C5=84czyk?= <mat.jonczyk@o2.pl>, Zakariya Dehlawi <zdehlawi@gmail.com>, Guillaume Bouchard <guillaum.bouchard@gmail.com>

On Thu, Jan 08, 2015 at 04:02:27PM +1100, Srihari Vijayaraghavan wrote:
> On 8 January 2015 at 12:23, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > On Wed, Jan 07, 2015 at 08:11:36PM +1100, Srihari Vijayaraghavan wrote:
> >> On 7 January 2015 at 19:23, Srihari Vijayaraghavan
> >> <linux.bug.reporting@gmail.com> wrote:
> >> Here's a better version, removing Elantech ref from the table name.
> >
> > Applied after massaging messages some more. Thank you.
> 
> Thank you Dmitry. Much appreciated. You've made a lot of affected
> users very happy.

No, thank *you*.

> 
> May I request you to cc stable folks when merging upstream?

Yes, it is marked for stable so once Linus pulls from me next time magic
should happen and it will end up in the stable kernels too.

Thanks.

-- 
Dmitry
