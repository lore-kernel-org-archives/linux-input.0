From: Elias Vanderstuyft <elias.vds@gmail.com>
Subject: Re: uinput: How to use force feedback?
Date: Wed, 10 Feb 2016 22:41:36 +0100
Message-ID: <CADbOyBTJtuKOzrCDgstg7V6KenqQLXzi9ZS-9YHhvpHhZnpY+w@mail.gmail.com>
References: <n7g4s1$i1l$1@ger.gmane.org>
	<CADbOyBQpnNjPxoDhy4XuyHSBSyYT6dvwzL2jfPV4FdOS1SzkYQ@mail.gmail.com>
	<n92gka$1fj$1@ger.gmane.org>
	<n932dt$g8i$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f177.google.com ([209.85.161.177]:33823 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095AbcBJVlh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Feb 2016 16:41:37 -0500
Received: by mail-yw0-f177.google.com with SMTP id h129so25420702ywb.1
        for <linux-input@vger.kernel.org>; Wed, 10 Feb 2016 13:41:37 -0800 (PST)
In-Reply-To: <n932dt$g8i$1@ger.gmane.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Manuel Reimer <Manuel.Spam@nurfuerspam.de>
Cc: "open list:HID CORE LAYER" <linux-input@vger.kernel.org>

On Fri, Feb 5, 2016 at 9:58 PM, Manuel Reimer
<Manuel.Spam@nurfuerspam.de> wrote:
> Hello,
>
> I just want to add here, that I found the reason for this problem.
>
> It is required that the ff_effects_max field of the uinput_user_dev struct
> is set. Without doing this everything just hangs...

Indeed, the uinput_user_dev struct should be properly initialized.
I ran into the same problem, and I created some patches which may fix the hangs:
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/drivers/input/ff-core.c?id=33b96d934902f96e901b72ac18bbc47afad1ac20
https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit/drivers/input/misc/uinput.c?id=daf6cd0c1829c48cba197bd87d57fc8bf3f65faa

Which kernel version are you using?
The first patch is already in version 4.4.

Glad you got it working now,
Elias
