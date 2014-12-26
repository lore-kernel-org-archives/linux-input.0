From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Question : drivers/input ] Fixing Event Filter Mechanism in
 input subsystem
Date: Fri, 26 Dec 2014 15:46:58 -0800
Message-ID: <20141226234658.GC1071@dtor-ws>
References: <CA+HOOsgL_fY=Wc+ciDAuk485d=uTn=YTgVGVDJ5Qk3UsqQ8zVA@mail.gmail.com>
 <20141222172622.GA18556@dtor-ws>
 <CA+HOOsgDm-ZGycDwdzw3SvbscUefp7xcD-ikFSF2heouHMhS4g@mail.gmail.com>
 <20141224182511.GA21956@dtor-glaptop>
 <CA+HOOsg+U6yS4sAsgD_vZ-OGkTuzdKf2Qmg8hcyXkyFbY3WJPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:44835 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808AbaLZXrD (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 26 Dec 2014 18:47:03 -0500
Received: by mail-ie0-f174.google.com with SMTP id at20so10130651iec.19
        for <linux-input@vger.kernel.org>; Fri, 26 Dec 2014 15:47:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CA+HOOsg+U6yS4sAsgD_vZ-OGkTuzdKf2Qmg8hcyXkyFbY3WJPQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anshul Garg <aksgarg1989@gmail.com>
Cc: linux-input@vger.kernel.org, "anshul.g@samsung.com" <anshul.g@samsung.com>

Hi Anshul,

On Thu, Dec 25, 2014 at 11:11:06AM +0530, Anshul Garg wrote:
> Dear Mr Dmitry ,
> 
> Thanks a lot for the clarification.
> 
> I was in assumption that one handler can support both ->filter() and
> ->event[s]()
> Callback.So that's why i have prepared the patch to first do the
> filter then pass
> the events.
> 
> Can you please tell me why current implementation doesn't expect handler can
> have both callbacks?

Because it was something I saw no need for: filter already has all the
events so it can process them. If you really want to process events
again once all filters have run, you can register additional handler.

> 
> I think input core should be generic to allow any type of handlers which can
> support both filter and events callbacks.
> 
> Please help to answer above query as my patch is based on this pre-assumption
> that one handler can support both callbacks .
> 
> If we really need to have support of such handlers in input core then
> only my patch
> is good.

I think I would need a user for this feature before changing the code to
allow it.

Thanks.

-- 
Dmitry
