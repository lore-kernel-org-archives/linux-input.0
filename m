From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] HID: uhid: Fix sending events with invalid data
Date: Sun, 15 Jul 2012 00:51:52 +0200
Message-ID: <CANq1E4RO4r0Cx=j9oR=mgHd0CwcQd5LtUiGNvgEyS1BtTP5Pxg@mail.gmail.com>
References: <1342303165-28708-1-git-send-email-vinicius.gomes@openbossa.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:39463 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208Ab2GNWvx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 Jul 2012 18:51:53 -0400
Received: by wgbdr13 with SMTP id dr13so4183054wgb.1
        for <linux-input@vger.kernel.org>; Sat, 14 Jul 2012 15:51:52 -0700 (PDT)
In-Reply-To: <1342303165-28708-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Vinicius

CC'ing Jiri

On Sat, Jul 14, 2012 at 11:59 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> This was detected because events with invalid types were arriving
> to userspace.
>
> The code before this patch would only work for the first event in the
> queue (when uhid->tail is 0).
>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
> ---
> David,
>
> Do you have any clue why it took so long for us to detect this issue?

Ugh! Thanks for spotting this! I actually have no idea why this wasn't
detected earlier. I always run the sample file in ./samples/uhid/ and
they worked fine. Could it be that this only occurs when the queue
runs full? That is, there is more than one event in the queue? This
would explain why I never saw this bug. Or maybe the first event is
just repeated all the time instead of reporting the new events which
would explain why the example in ./samples/uhid works fine.

It definitely has to do with the late transition from a fixed array to
a dynamically allocated pointer-array so all the early tests from the
bluez guys worked fine. This is probably also the reason why we all
didn't encounter this in the early tests.

I just recompiled the example with the old code and it still works
fine. I occasionally see the "invalid event" warnings now, but only 1
or 2 times. Maybe it's just dropping all except the 32'th package
(buffer-size) so I cannot see it and the mouse-emulation still works
smoothly (but at 1/32th of the original speed). Anyway, the patch
looks good, thanks!

Reviewed-by: David Herrmann <dh.herrmann@googlemail.com>
Thanks!

David

> Cheers,
>
>
>  drivers/hid/uhid.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/uhid.c b/drivers/hid/uhid.c
> index 119b7e6..714cd8c 100644
> --- a/drivers/hid/uhid.c
> +++ b/drivers/hid/uhid.c
> @@ -465,7 +465,7 @@ try_again:
>                 goto try_again;
>         } else {
>                 len = min(count, sizeof(**uhid->outq));
> -               if (copy_to_user(buffer, &uhid->outq[uhid->tail], len)) {
> +               if (copy_to_user(buffer, uhid->outq[uhid->tail], len)) {
>                         ret = -EFAULT;
>                 } else {
>                         kfree(uhid->outq[uhid->tail]);
> --
> 1.7.10.4
