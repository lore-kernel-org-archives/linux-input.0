From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [Bug 15893] Alps: No edge-scrolling since 2.6.34-rc5
Date: Mon, 3 May 2010 19:27:31 -0400
Message-ID: <k2y40ec3ea41005031627sd356674di491a2c4f92d7ad92@mail.gmail.com>
References: <bug-15893-5697@https.bugzilla.kernel.org/>
	 <201005032116.o43LGcXi010308@demeter.kernel.org>
	 <20100503220606.GP29093@bicker>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:65344 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759865Ab0ECX1e (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 3 May 2010 19:27:34 -0400
Received: by pxi5 with SMTP id 5so508418pxi.19
        for <linux-input@vger.kernel.org>; Mon, 03 May 2010 16:27:33 -0700 (PDT)
In-Reply-To: <20100503220606.GP29093@bicker>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <error27@gmail.com>
Cc: linux-input@vger.kernel.org, f.zweig@yahoo.de, Dmitry Torokhov <dtor@mail.ru>

Hi Dan,

On Mon, May 3, 2010 at 6:06 PM, Dan Carpenter <error27@gmail.com> wrote:
> It looks like the "Acer Aspire One 532h" and the "HP Pavilion dm3"
> have the same signature but they behave differently.
>
> As a result commit 5e28d8eb68 "Input: ALPS - add signature for HP
> Pavilion dm3 laptops" fixes things for dm3 but breaks the Acer Aspire
> One 532h which was working (with a userspace driver maybe??).

There were issues with this change, so it was reverted in the input
tree. Specifically, it seems that these devices operate under a
different protocol that the Linux driver does not understand yet.

As for when it should propagate to Linus' tree, Dmitry should have a
better idea.

I'm sorry the change has caused you issues.

-- Chase
