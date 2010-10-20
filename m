From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] Input: hgpk - support GlideSensor and PenTablet modes
Date: Wed, 20 Oct 2010 16:53:32 +0100
Message-ID: <AANLkTi=fo9rTfVEdPB46qd=Compjma1XMOKSzqpUQiu3@mail.gmail.com>
References: <20101006155026.5BB289D401B@zog.reactivated.net>
	<20101014155230.GB10421@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56232 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab0JTPxd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Oct 2010 11:53:33 -0400
Received: by mail-iw0-f174.google.com with SMTP id 7so2427262iwn.19
        for <linux-input@vger.kernel.org>; Wed, 20 Oct 2010 08:53:32 -0700 (PDT)
In-Reply-To: <20101014155230.GB10421@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

Hi Dmitry,

On 14 October 2010 16:52, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> I think we can do better than that and re-create the device for users
> ourselves. See drivers/input/mouse/psmouse_base.c::psmouse_attr_set_proto()
>
> I would also look into adding a module parameter so that users could
> specify desired mode on bootup.

Thanks for your feedback -- all good points and ideas.

I've addressed it all in the latest patch
https://patchwork.kernel.org/patch/254381/

Hoping you can take a look at it soon :)

Thanks,
Daniel
