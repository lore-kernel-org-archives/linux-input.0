From: Mark Laws <mdl@60hz.org>
Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
 Hyper-V VMs
Date: Tue, 19 Apr 2016 19:46:09 +0900
Message-ID: <CADemMPMSYfdbt5U6mgj=kdbBQKP_nWrah3M5ZuyZZk6soWJGjg@mail.gmail.com>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
	<cover.1460985538.git.mdl@60hz.org>
	<341e0bb72d58c1c7d72ad5352f4bb364d939c0a8.1460985538.git.mdl@60hz.org>
	<20160418165456.GG4298@mwanda>
	<CADemMPN5wPjDzrLnsWgBHKZt3JNN-tYeJ8B+waFVsizZJdi2tA@mail.gmail.com>
	<20160418203600.GH4298@mwanda>
	<CADemMPNu2KuQgwyzLjr+L5ngbLxbOTpM0sKF2TLeZBvpvJjZKQ@mail.gmail.com>
	<20160419082235.GP4247@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f194.google.com ([209.85.213.194]:33700 "EHLO
	mail-ig0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752381AbcDSKqL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2016 06:46:11 -0400
Received: by mail-ig0-f194.google.com with SMTP id g8so1931087igr.0
        for <linux-input@vger.kernel.org>; Tue, 19 Apr 2016 03:46:10 -0700 (PDT)
In-Reply-To: <20160419082235.GP4247@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@linuxdriverproject.org, haiyangz@microsoft.com, linux-input@vger.kernel.org

On Tue, Apr 19, 2016 at 5:22 PM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> Yeah.  Just remove the call to i8042_controller_check().  Wouldn't
> everyone be happy with that situation?

No problem, I agree this is better--just wasn't sure what you meant initially.

> Your patch makes life slightly more complicated for people who want to
> use the original hardware if the load the module but the hardware isn't
> detected.

That is true, but apparently nobody can think of a better solution
(including me :)) and this bug has been open for two years. Having to
rmmod in the corner case where the module gets loaded but no i8042 is
present seems a small price to pay for having the keyboard work
regardless of CONFIG_I8042=y or m. Right now, any distribution with
CONFIG_I8042=m has a non-functional keyboard on Hyper-V Gen2 VMs,
which is probably frustrating for (e.g.) Arch Linux users who find
themselves unable to type and thus can't install their distribution.

Regards,
Mark Laws

-- 
|v\ /\ |\ |< |_ /\ \^| //
