From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [input:next 1310/1311] drivers/input/misc/sparcspkr.c:256:35:
 error: macro "MODULE_DEVICE_TABLE" requires 2 arguments, but only 1 given
Date: Fri, 4 Sep 2015 09:39:25 -0700
Message-ID: <CAKdAkRS9veyMZfQScmiMdeXFq8JtUMaEEBEcVAXse9+OAr--Aw@mail.gmail.com>
References: <201509041453.twfpuyh9%fengguang.wu@intel.com>
	<20150904112551.GA31065@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176]:35114 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbbIDQjZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2015 12:39:25 -0400
Received: by obuk4 with SMTP id k4so21235526obu.2
        for <linux-input@vger.kernel.org>; Fri, 04 Sep 2015 09:39:25 -0700 (PDT)
In-Reply-To: <20150904112551.GA31065@goodgumbo.baconseed.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: "kbuild-all@01.org" <kbuild-all@01.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Javier Martinez Canillas <javier@osg.samsung.com>

Hi Luis,

On Fri, Sep 4, 2015 at 4:25 AM, Luis de Bethencourt
<luis@debethencourt.com> wrote:
> Hi Dmitry,
>
> I got this error email and confirmed that I missed the 'of' in my patch. I was
> about to send a v3 with this fixed. But I just noticed it is already fixed in
> your branch.
>
> https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?h=next&id=26492f195eed08b95ad5acdfbe625062ad7d86c6
>
> I am assuming you did this. Thank you!
>
> I just wanted to confirm that there isn't anything else related to this you
> would like me to do.

No I think we are good now.

Thanks.

-- 
Dmitry
