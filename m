From: Daniel Drake <dsd@laptop.org>
Subject: Re: [PATCH] Input: hgpk - support GlideSensor and PenTablet modes
Date: Fri, 29 Oct 2010 21:11:43 +0100
Message-ID: <AANLkTi=M8ozNf41bV_zErpjORgi4PohBRv0qVrzBUxZW@mail.gmail.com>
References: <20101006155026.5BB289D401B@zog.reactivated.net>
	<20101014155230.GB10421@core.coreip.homeip.net>
	<AANLkTi=fo9rTfVEdPB46qd=Compjma1XMOKSzqpUQiu3@mail.gmail.com>
	<20101029165955.GA26386@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48875 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761844Ab0J2ULp (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Oct 2010 16:11:45 -0400
Received: by wyf28 with SMTP id 28so3513235wyf.19
        for <linux-input@vger.kernel.org>; Fri, 29 Oct 2010 13:11:44 -0700 (PDT)
In-Reply-To: <20101029165955.GA26386@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

On 29 October 2010 17:59, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Sorry for the delay, I did not quite like that we had to adjust the
> global mode option to switch the device to the new mode; we should be
> able to do it ourselves within the driver instead of punting the task
> off to serio_rescan(). Could you please tell me if the patch below (on
> top of yours) still works?

Thanks for battling through this.
It introduces some minor breakage.
Fixed by: http://dev.laptop.org/~dsd/20101029/hgpk-fixups.txt

Let me know what the next steps are

Daniel
