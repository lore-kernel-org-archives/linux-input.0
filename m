From: Christoph Langner <mail@christoph-langner.de>
Subject: Erratic cursor movement with Apple Magic Mouse
Date: Fri, 7 May 2010 11:07:58 +0200
Message-ID: <v2ka31bf27a1005070207ga9e8420as99deff74cc41655@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:54978 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752798Ab0EGJIT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 May 2010 05:08:19 -0400
Received: by fxm10 with SMTP id 10so603419fxm.19
        for <linux-input@vger.kernel.org>; Fri, 07 May 2010 02:08:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello!

I'm trying to use a Apple Magic Mouse on a ordinary PC with Ubuntu
Linux 10.04. Out of the box the mouse "worked" in Lucid. Paring,
moving the cursor over the screen and right/left clicks worked. After
I installed multitouch-kernel-source_1.2. and a reboot I was able to
scroll and do middle clicks. So more or less it worked very good.

Today (i can't remember that i changed a thing) the cursor is stuck at
the top left corner of the screen,  even when I move the mouse. When i
touch the surface of the mouse I can move the cursor. It looks like
the surface of the mouse controls the position of the cursor on my
screen. I installed the kernel module inside Ubuntu Lucid Lynx 10.04
and the PPA of Chase Douglas [1]. Other people [2] report similar
issues. Deleting the connection between my
system and the mouse and re-pair it doesn't help.

I reported the issue to bugzilla.kernel.org [3], is there something I
can do to make the mouse work again?

Thanks
Christoph


[1] https://launchpad.net/~chasedouglas/+archive/multitouch
[2] http://ubuntuforums.org/showpost.php?p=9244651&postcount=121
[3] https://bugzilla.kernel.org/show_bug.cgi?id=15928
