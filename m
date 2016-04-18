From: Mark Laws <mdl@60hz.org>
Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
 Hyper-V VMs
Date: Tue, 19 Apr 2016 07:00:42 +0900
Message-ID: <CADemMPNu2KuQgwyzLjr+L5ngbLxbOTpM0sKF2TLeZBvpvJjZKQ@mail.gmail.com>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
	<cover.1460985538.git.mdl@60hz.org>
	<341e0bb72d58c1c7d72ad5352f4bb364d939c0a8.1460985538.git.mdl@60hz.org>
	<20160418165456.GG4298@mwanda>
	<CADemMPN5wPjDzrLnsWgBHKZt3JNN-tYeJ8B+waFVsizZJdi2tA@mail.gmail.com>
	<20160418203600.GH4298@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35259 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcDRWAs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 18:00:48 -0400
Received: by mail-ig0-f193.google.com with SMTP id fn8so102964igb.2
        for <linux-input@vger.kernel.org>; Mon, 18 Apr 2016 15:00:48 -0700 (PDT)
In-Reply-To: <20160418203600.GH4298@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: devel@linuxdriverproject.org, haiyangz@microsoft.com, linux-input@vger.kernel.org

On Tue, Apr 19, 2016 at 5:36 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> On Tue, Apr 19, 2016 at 02:24:47AM +0900, Mark Laws wrote:
>> Sorry, I don't understand--which part are you suggesting we remove?
>
> The call to i8042_controller_check() or move it to the probe function or
> something.  Why must we have the hardware to load the module?

We don't. That's the point of the patch. Do you mean that since our
intent is to load the module regardless of whether or not the hardware
is there, the check should be (re)moved simply to clarify the code?

Sorry for the stupid questions--I'm just trying to make sure I
understand you correctly!

Regards,
Mark Laws

-- 
|v\ /\ |\ |< |_ /\ \^| //
