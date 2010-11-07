From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: hgpk - support GlideSensor and PenTablet modes
Date: Sat, 6 Nov 2010 22:49:27 -0700
Message-ID: <20101107054927.GB3823@core.coreip.homeip.net>
References: <20101006155026.5BB289D401B@zog.reactivated.net>
 <20101014155230.GB10421@core.coreip.homeip.net>
 <AANLkTi=fo9rTfVEdPB46qd=Compjma1XMOKSzqpUQiu3@mail.gmail.com>
 <20101029165955.GA26386@core.coreip.homeip.net>
 <AANLkTi=M8ozNf41bV_zErpjORgi4PohBRv0qVrzBUxZW@mail.gmail.com>
 <20101029224045.GA7968@core.coreip.homeip.net>
 <AANLkTimcSv1YoD0oYHmoAGxVo2kpU53VH=U+O7LWx1Wz@mail.gmail.com>
 <20101105193648.GA6039@core.coreip.homeip.net>
 <AANLkTi=16q0V0v-oL5oi6PEMXf5KsKww=R4umo1S9Zhe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50318 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751012Ab0KGFtf (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 7 Nov 2010 01:49:35 -0400
Received: by iwn41 with SMTP id 41so2612292iwn.19
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 22:49:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=16q0V0v-oL5oi6PEMXf5KsKww=R4umo1S9Zhe@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

On Sat, Nov 06, 2010 at 08:02:21PM +0000, Daniel Drake wrote:
> On 5 November 2010 19:36, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > I tried merging the snippet that you mention in your last e-mail but I
> > think that we should not manually set state to PSMOUSE_ACTIVATED, but
> > rather mark the attribute as "protected" and rely on psmouse core to
> > disable and re-enable the device.
> >
> > Does the patch below still work for you?
> 
> Yes, that works.
> 

Great, thanks for testing. Please rebase the other patches that you have
against yours + this one and send them my way.

-- 
Dmitry
