From: Manuel Reimer <manuel.reimer@mailbox.org>
Subject: Re: uinput: How to use force feedback?
Date: Mon, 15 Feb 2016 21:05:30 +0100
Message-ID: <56C22F8A.8050603@mailbox.org>
References: <n7g4s1$i1l$1@ger.gmane.org>
 <CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
 <n92gka$1fj$1@ger.gmane.org> <n932dt$g8i$1@ger.gmane.org>
 <CADbOyBTJtuKOzrCDgstg7V6KenqQLXzi9ZS-9YHhvpHhZnpY+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:56737 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751785AbcBOULo (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Feb 2016 15:11:44 -0500
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id 61F0443A70
	for <linux-input@vger.kernel.org>; Mon, 15 Feb 2016 21:05:31 +0100 (CET)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id xwrQHsfxgSm6 for <linux-input@vger.kernel.org>;
	Mon, 15 Feb 2016 21:05:30 +0100 (CET)
In-Reply-To: <CADbOyBTJtuKOzrCDgstg7V6KenqQLXzi9ZS-9YHhvpHhZnpY+w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

On 02/10/2016 10:41 PM, Elias Vanderstuyft wrote:
> Which kernel version are you using?
> The first patch is already in version 4.4.

Currently 4.3.3. Self-built to have a small patch which makes PS4 
controller bluetooth binding possible (will be in kernel in version 4.5).

Rumble seems to be a problem with uinput in general. For example it is 
pretty easy to create "non-killable" processes if fftest is still 
running when the uinput daemon is killed. Not much fun to debug 
something like this, so I finally disabled my rumble support.

> Glad you got it working now,

Partially but not really solving my problem. Still working on it.

Manuel
