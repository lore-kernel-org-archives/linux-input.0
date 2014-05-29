From: David Herrmann <dh.herrmann@gmail.com>
Subject: Re: joydev devices are world readable
Date: Thu, 29 May 2014 10:44:02 +0200
Message-ID: <CANq1E4QOOimhZ9pDLkRMvPYZBko8sWZiugHKgYwBR1gb7CKW5w@mail.gmail.com>
References: <op.xgl3pdtz5k9y7g@alice.jkfloris.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55045 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546AbaE2IoE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 May 2014 04:44:04 -0400
Received: by mail-ie0-f179.google.com with SMTP id rd18so14711iec.24
        for <linux-input@vger.kernel.org>; Thu, 29 May 2014 01:44:02 -0700 (PDT)
In-Reply-To: <op.xgl3pdtz5k9y7g@alice.jkfloris.demon.nl>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Floris <jkfloris@dds.nl>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

Hi

On Thu, May 29, 2014 at 10:11 AM, Floris <jkfloris@dds.nl> wrote:
> Hey,
>
> after asking the systemd mailing list [1] I will try this list. Maybe
> someone can help me to solve this issue or point me to someone/ some list.
>
> The short version of the problem:
>
> I have created a multiseat setup with systemd. And used "loginctl attach" to
> attach devices to an other seat. The input from the mouse and keyboard are
> working as expected. They both only work on the seat they are attached to.
> Nevertheless, the joysticks ignore the seat rules and works on every seat.
> So a user from seat0 can interact with seat1. Maybe this is not directly a
> security problem as it is annoying.
>
> Please read the systemd-devel mailing list [1] for more information or ask
> me if you need more information about my system or the problem.

I posted an explanation on systemd-devel [1] this morning. Please note
that this is a policy-issue created in user-space. The kernel-side
cannot help you there. Furthermore, the kernel recommends using evdev
instead of joydev and friends. Therefore, I cannot see what you expect
from us.

If you want to get this solved, simply change the udev rules on your
system to prevent joydev devices from being world-readable.

Thanks
David

[1] http://lists.freedesktop.org/archives/systemd-devel/2014-May/019566.html
