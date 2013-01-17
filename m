From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] hid: Fix uninitialized variable "size" in hid-wiimote-debug
Date: Thu, 17 Jan 2013 21:29:31 +0100
Message-ID: <CANq1E4TT8X3wSFjY4cawux0fC+hiPzXqdJQJ2fiqiAVnoi1sWQ@mail.gmail.com>
References: <1358452047-15451-1-git-send-email-sque@chromium.org>
	<CANq1E4RhX2U2WWDr39hbsnSfZTQTC526_2yw_5MEjbdRMt+YVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f177.google.com ([209.85.215.177]:54013 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756111Ab3AQU3d (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2013 15:29:33 -0500
Received: by mail-ea0-f177.google.com with SMTP id n13so1162525eaa.22
        for <linux-input@vger.kernel.org>; Thu, 17 Jan 2013 12:29:31 -0800 (PST)
In-Reply-To: <CANq1E4RhX2U2WWDr39hbsnSfZTQTC526_2yw_5MEjbdRMt+YVg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Que <sque@chromium.org>
Cc: linux-input@vger.kernel.org, msb@chromium.org, Jiri Kosina <jkosina@suse.cz>

CC'ing Jiri so he can apply it to hid-next.

On Thu, Jan 17, 2013 at 9:07 PM, David Herrmann
<dh.herrmann@googlemail.com> wrote:
> Hi Simon
>
> On Thu, Jan 17, 2013 at 8:47 PM, Simon Que <sque@chromium.org> wrote:
>> This variable is initialized conditionally, based on whether a wiimote
>> call succeeds.  However, the logic is not obvious to the compiler so it
>> throws a warning.  Eliminate the warning by initializing "size" to 0.
>
> Hm, I think it says:
>
>   54         ret = wiimote_cmd_wait(wdata);
>   55         if (!ret)
>   56                 size = wdata->state.cmd_read_size;
>
> ...not touching "size" or "ret" inbetween...
>
>   64         if (ret)
>   65                 return ret;
>
> ...using "size" below...
>
> Weird that gcc cannot figure that out that there is no path to line 66
> where "size" is uninitialized. Anyway, I am fine with this fix. We
> test for "size == 0" anyway.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
>
> Next time please copy the gcc-warning message verbatim into the
> commit-message so we can more easily reproduce this and see which line
> is affected.
>
> Thanks for the patch
> David
