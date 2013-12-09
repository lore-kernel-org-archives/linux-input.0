From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH 2/2] elantech: Add support for IC-body version 8
Date: Mon, 9 Dec 2013 12:50:43 -0500
Message-ID: <CAN+gG=F6tjhWQjbSEx9ku+AYrZkUjjdUwWE6oiCwcyysMAvUUg@mail.gmail.com>
References: <1386599551-2339-1-git-send-email-hdegoede@redhat.com>
	<1386599551-2339-2-git-send-email-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-la0-f53.google.com ([209.85.215.53]:48516 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760514Ab3LIRup (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Dec 2013 12:50:45 -0500
Received: by mail-la0-f53.google.com with SMTP id mc6so1582673lab.40
        for <linux-input@vger.kernel.org>; Mon, 09 Dec 2013 09:50:43 -0800 (PST)
In-Reply-To: <1386599551-2339-2-git-send-email-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: linux-input <linux-input@vger.kernel.org>, Peter Hutterer <peter.hutterer@redhat.com>

On Mon, Dec 9, 2013 at 9:32 AM, Hans de Goede <hdegoede@redhat.com> wrote:
> Acording to: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1232877
> a patch for this has been send before, but I don't see this in 3.13-rc3,
> so here is another one.
>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>

Hey Hans,

good to see you on linux-input :)

anyway, Dmitry already took this patch in his tree:
https://git.kernel.org/cgit/linux/kernel/git/dtor/input.git/commit/?h=for-linus&id=9cb80b965eaf7af1369f6e16f48a05fbaaccc021

And this patch is part of the pull request for 3.13-rc3 (so should be in rc4).

Cheers,
Benjamin
