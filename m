From: David Herrmann <dh.herrmann@googlemail.com>
Subject: Re: [PATCH] hid: Fix uninitialized variable "size" in hid-wiimote-debug
Date: Thu, 17 Jan 2013 21:07:45 +0100
Message-ID: <CANq1E4RhX2U2WWDr39hbsnSfZTQTC526_2yw_5MEjbdRMt+YVg@mail.gmail.com>
References: <1358452047-15451-1-git-send-email-sque@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:60433 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755742Ab3AQUNA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Jan 2013 15:13:00 -0500
Received: by mail-ee0-f43.google.com with SMTP id c50so1395169eek.30
        for <linux-input@vger.kernel.org>; Thu, 17 Jan 2013 12:12:59 -0800 (PST)
In-Reply-To: <1358452047-15451-1-git-send-email-sque@chromium.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Que <sque@chromium.org>
Cc: linux-input@vger.kernel.org, msb@chromium.org

Hi Simon

On Thu, Jan 17, 2013 at 8:47 PM, Simon Que <sque@chromium.org> wrote:
> This variable is initialized conditionally, based on whether a wiimote
> call succeeds.  However, the logic is not obvious to the compiler so it
> throws a warning.  Eliminate the warning by initializing "size" to 0.

Hm, I think it says:

  54         ret = wiimote_cmd_wait(wdata);
  55         if (!ret)
  56                 size = wdata->state.cmd_read_size;

...not touching "size" or "ret" inbetween...

  64         if (ret)
  65                 return ret;

...using "size" below...

Weird that gcc cannot figure that out that there is no path to line 66
where "size" is uninitialized. Anyway, I am fine with this fix. We
test for "size == 0" anyway.

Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>

Next time please copy the gcc-warning message verbatim into the
commit-message so we can more easily reproduce this and see which line
is affected.

Thanks for the patch
David
