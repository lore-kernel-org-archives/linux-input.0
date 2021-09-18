Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC62AC433EF
	for <linux-input@archiver.kernel.org>; Sat, 18 Sep 2021 09:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C31B56113A
	for <linux-input@archiver.kernel.org>; Sat, 18 Sep 2021 09:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbhIRJTs (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sat, 18 Sep 2021 05:19:48 -0400
Received: from mail.cock.li ([37.120.193.124]:33250 "EHLO mail.cock.li"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231497AbhIRJTr (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 18 Sep 2021 05:19:47 -0400
X-Greylist: delayed 304 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Sep 2021 05:19:47 EDT
Date:   Sat, 18 Sep 2021 11:12:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=firemail.cc; s=mail;
        t=1631956397; bh=zOX1zQewWb8lPRPShofdL/oYmEdkKbM6wSy2UHTFlCc=;
        h=Date:From:To:Subject:From;
        b=vHySUmV2mul2ptQNMguuoGPlJd1EhMvH7tEgyc29zWpam6fVj23m/nN87PXcQpKtb
         YYC4VuSUGMBK5a3y54SOQB0HVRxydU1kolR7CSKg1QJgfb2GcAMIIb31g7YMnUKrqJ
         ANosHhOf4WY7e0X10wGNPipJt1Nl5gD0u8dP7d5vMNXIjCrgG+Web0zObKoTu+pX8F
         OrU/Hi2eIjgVGGTYdmqlcsRrMlBaCByXlJclzATQbYjK1aMERcxAdfQd1hk/8KuxzL
         RLC3/Jotz1U1fHcL0pqSGJZ6qzL2zdB8ETRqn+ITMw9x/IYk49lQmRetPYIYNtmG2M
         x9FdvYYmN8fyA==
From:   literallynobody <literallynobody@firemail.cc>
To:     linux-input@vger.kernel.org
Subject: Solved freezing keyboard and touchpad with synaptics intertouch
Message-ID: <20210918091037.fydfczi6vglc4qcb@firemail.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Hello, as instructed in logs im writing this to tell you that i resolved
my problem with randomly freezing keyboard and touchpad in my laptop by adding
psmouse.synaptics_intertouch=1 to boot options in GRUB. Details below.

The problem was happening when i was using touchpad, never when using
keyboard. It would "freeze" or "clog" but it would still
remember my inputs from keyboard, and when i would do(with external
keyboard, because when touchpad was frozen so was keyboard)
sudo modprobe -r psmouse
sudo modprobe psmouse
all the inputs during the time of freeze would be pressed, and keyboard
and touchpad would work for some time (about few minutes, occasionally
longer). Nothing came in xorg logs, and not in journalctl when freeze
came. I stumbled upon only information that my touchpad supports
psmouse.synaptics_intertouch=1 so i gave that a shot and it fixed the
issue.

My laptop is HP 250 G7.

uname -a
Linux nowhere 5.14.5-arch1-1 #1 SMP PREEMPT Thu, 16 Sep 2021 11:02:40 +0000 x86_64 GNU/Linux
