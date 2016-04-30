From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: How to properly extend uinput API
Date: Sat, 30 Apr 2016 11:36:24 +0200
Message-ID: <51caa374-1fdc-bcc0-3aac-20292a77571b@m-reimer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:33109 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752101AbcD3Jg3 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Apr 2016 05:36:29 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.mailbox.org (Postfix) with ESMTPS id C7B1E43AE5
	for <linux-input@vger.kernel.org>; Sat, 30 Apr 2016 11:36:26 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
	by gerste.heinlein-support.de (gerste.heinlein-support.de [91.198.250.173]) (amavisd-new, port 10030)
	with ESMTP id AhXNuIm70Plf for <linux-input@vger.kernel.org>;
	Sat, 30 Apr 2016 11:36:25 +0200 (CEST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>

Hello,

I'm currently trying to somehow get uinput connected with ff-memless.

My first try (which is some kind of hack which prevents API changes and 
doesn't work at all) failed. Now my idea is to add some more simple (and 
probably working) API for this. All, I need in the "memless case", is 
some way to get two motor speeds sent to usermode, which doesn't require 
all this callback stuff.

There is a new API which, as far as I understand, is meant to be easier 
extendable:
https://github.com/torvalds/linux/commit/052876f8e5

What I need is some way to pass an additional boolean to tell the kernel 
module that usermode wants to use ff-memless. Device setup is done with 
an struct "uinput_setup". As far as I know it isn't easily possible to 
extend this without breaking existing stuff.

It would be possible to write some hack which passes this information 
via magic-value through ff_effects_max but I think there has to be some 
nicer way.

So how to pass one more piece of information from usermode to kernel 
module while setup without breaking existing (probably closed-source) 
stuff? Keep a definition of the old struct version and decide which one 
to use based on size?

Thank you very much in advance for any help.

Manuel
