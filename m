From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: hgpk - support GlideSensor and PenTablet modes
Date: Fri, 29 Oct 2010 15:40:45 -0700
Message-ID: <20101029224045.GA7968@core.coreip.homeip.net>
References: <20101006155026.5BB289D401B@zog.reactivated.net>
 <20101014155230.GB10421@core.coreip.homeip.net>
 <AANLkTi=fo9rTfVEdPB46qd=Compjma1XMOKSzqpUQiu3@mail.gmail.com>
 <20101029165955.GA26386@core.coreip.homeip.net>
 <AANLkTi=M8ozNf41bV_zErpjORgi4PohBRv0qVrzBUxZW@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:39406 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757157Ab0J2Wkz (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 29 Oct 2010 18:40:55 -0400
Received: by yxk8 with SMTP id 8so1968793yxk.19
        for <linux-input@vger.kernel.org>; Fri, 29 Oct 2010 15:40:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTi=M8ozNf41bV_zErpjORgi4PohBRv0qVrzBUxZW@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, pgf@laptop.org

On Fri, Oct 29, 2010 at 09:11:43PM +0100, Daniel Drake wrote:
> On 29 October 2010 17:59, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > Sorry for the delay, I did not quite like that we had to adjust the
> > global mode option to switch the device to the new mode; we should be
> > able to do it ourselves within the driver instead of punting the task
> > off to serio_rescan(). Could you please tell me if the patch below (on
> > top of yours) still works?
> 
> Thanks for battling through this.
> It introduces some minor breakage.
> Fixed by: http://dev.laptop.org/~dsd/20101029/hgpk-fixups.txt
> 
> Let me know what the next steps are
> 

Thanks Daniel, I'll fold it all together and try to get it into -rc1.

-- 
Dmitry
