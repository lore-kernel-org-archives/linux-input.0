From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] Input: hgpk - support GlideSensor and PenTablet modes
Date: Sat, 6 Nov 2010 20:02:21 +0000
Message-ID: <AANLkTi=16q0V0v-oL5oi6PEMXf5KsKww=R4umo1S9Zhe@mail.gmail.com>
References: <20101006155026.5BB289D401B@zog.reactivated.net>
	<20101014155230.GB10421@core.coreip.homeip.net>
	<AANLkTi=fo9rTfVEdPB46qd=Compjma1XMOKSzqpUQiu3@mail.gmail.com>
	<20101029165955.GA26386@core.coreip.homeip.net>
	<AANLkTi=M8ozNf41bV_zErpjORgi4PohBRv0qVrzBUxZW@mail.gmail.com>
	<20101029224045.GA7968@core.coreip.homeip.net>
	<AANLkTimcSv1YoD0oYHmoAGxVo2kpU53VH=U+O7LWx1Wz@mail.gmail.com>
	<20101105193648.GA6039@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f46.google.com ([209.85.213.46]:41072 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210Ab0KFUCW (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Nov 2010 16:02:22 -0400
Received: by ywc21 with SMTP id 21so2751958ywc.19
        for <linux-input@vger.kernel.org>; Sat, 06 Nov 2010 13:02:22 -0700 (PDT)
In-Reply-To: <20101105193648.GA6039@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

On 5 November 2010 19:36, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> I tried merging the snippet that you mention in your last e-mail but I
> think that we should not manually set state to PSMOUSE_ACTIVATED, but
> rather mark the attribute as "protected" and rely on psmouse core to
> disable and re-enable the device.
>
> Does the patch below still work for you?

Yes, that works.

Thanks!
Daniel
