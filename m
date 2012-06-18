From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] HID: uhid: silence gcc warning
Date: Mon, 18 Jun 2012 20:09:29 +0200
Message-ID: <CANq1E4SUTegcC+_=UJcMpJQpTUiD9TG489Nh=wyA+-_vMhrWzA@mail.gmail.com>
References: <alpine.LNX.2.00.1206181711260.15308@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34237 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751951Ab2FRSJa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 Jun 2012 14:09:30 -0400
Received: by wibhj8 with SMTP id hj8so2366959wib.1
        for <linux-input@vger.kernel.org>; Mon, 18 Jun 2012 11:09:29 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1206181711260.15308@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

Hi Jiri

On Mon, Jun 18, 2012 at 5:12 PM, Jiri Kosina <jkosina@suse.cz> wrote:
> gcc is giving me:
>
> drivers/hid/uhid.c: In function =91uhid_hid_get_raw=92:
> drivers/hid/uhid.c:157: warning: =91len=92 may be used uninitialized =
in this function
>
> which is clearly bogus, as
>
> - when used as memcpy() argument, it's initialized properly
> - the code is structured in a way that either 'ret' or 'len'
> =A0is always initialized, so the return statement always has
> =A0an initialized value.
>
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> David,
>
> I have applied this on top of your uhid series in my tree.

Yes, looks totally bogus to me, too. I also don't get the warning with
gcc-4.7.0. Thanks for applying it, looks ok to me.

Regards
David

> =A0drivers/hid/uhid.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
