From: Floris <jkfloris@dds.nl>
Subject: Re: joydev devices are world readable
Date: Thu, 29 May 2014 11:44:58 +0200
Message-ID: <op.xgl708il5k9y7g@alice.jkfloris.demon.nl>
References: <op.xgl3pdtz5k9y7g@alice.jkfloris.demon.nl>
 <CANq1E4QOOimhZ9pDLkRMvPYZBko8sWZiugHKgYwBR1gb7CKW5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-vbr12.xs4all.nl ([194.109.24.32]:4816 "EHLO
	smtp-vbr12.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756074AbaE2JnP (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 05:43:15 -0400
Received: from alice.jkfloris.demon.nl (jkfloris.demon.nl [82.95.130.205])
	(authenticated bits=0)
	by smtp-vbr12.xs4all.nl (8.13.8/8.13.8) with ESMTP id s4T9hBJT034304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-input@vger.kernel.org>; Thu, 29 May 2014 11:43:13 +0200 (CEST)
	(envelope-from jkfloris@dds.nl)
In-Reply-To: <CANq1E4QOOimhZ9pDLkRMvPYZBko8sWZiugHKgYwBR1gb7CKW5w@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

> I posted an explanation on systemd-devel [1] this morning. Please note
> that this is a policy-issue created in user-space. The kernel-side
> cannot help you there. Furthermore, the kernel recommends using evdev
> instead of joydev and friends. Therefore, I cannot see what you expect
> from us.

just curious. If the joydev module is not recommended, why is it still
available and used?

> If you want to get this solved, simply change the udev rules on your
> system to prevent joydev devices from being world-readable.
>
> Thanks
> David

Thank for your explanations. I will try to modify or add udev rules and
see if I can solve this behavior.

Thanks,

floris
