From: Mark Laws <mdl@60hz.org>
Subject: Re: [PATCH] Input: i8042 - Fix console keyboard support on Gen2
 Hyper-V VMs
Date: Tue, 19 Apr 2016 02:24:47 +0900
Message-ID: <CADemMPN5wPjDzrLnsWgBHKZt3JNN-tYeJ8B+waFVsizZJdi2tA@mail.gmail.com>
References: <1407814240-4275-1-git-send-email-decui@microsoft.com>
	<cover.1460985538.git.mdl@60hz.org>
	<341e0bb72d58c1c7d72ad5352f4bb364d939c0a8.1460985538.git.mdl@60hz.org>
	<20160418165456.GG4298@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f195.google.com ([209.85.223.195]:35523 "EHLO
	mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751915AbcDRRYs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Apr 2016 13:24:48 -0400
Received: by mail-io0-f195.google.com with SMTP id u185so24206784iod.2
        for <linux-input@vger.kernel.org>; Mon, 18 Apr 2016 10:24:48 -0700 (PDT)
In-Reply-To: <20160418165456.GG4298@mwanda>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, devel@linuxdriverproject.org, linux-input@vger.kernel.org

On Tue, Apr 19, 2016 at 1:54 AM, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> So if the user inserts the module without a keyboard then in the
> original code they would just put a keyboard in and try again.  Now they
> have to do an extra rmmod.  What about if we just removed the test for
> if the keyboard is present?

Sorry, I don't understand--which part are you suggesting we remove?

> Don't obfuscate the literal.  Just "return 0;".  Also if it's goto out
> just change that to "return 0;" because it's simpler for the reader.

Will fix.

Regards,
Mark Laws

-- 
|v\ /\ |\ |< |_ /\ \^| //
