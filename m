From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: New "ABS_WHEEL2" axis?
Date: Wed, 5 Oct 2011 20:34:52 -0700
Message-ID: <201110052034.52397.dmitry.torokhov@gmail.com>
References: <CANRwn3SH9VO-1P_zAkDopVJRjApnZWpEZWP3YpuXg3cbiCQffg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:42861 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752250Ab1JFDfB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 23:35:01 -0400
Received: by iakk32 with SMTP id k32so2495550iak.19
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 20:35:00 -0700 (PDT)
In-Reply-To: <CANRwn3SH9VO-1P_zAkDopVJRjApnZWpEZWP3YpuXg3cbiCQffg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Linux Input <linux-input@vger.kernel.org>

On Wednesday, October 05, 2011 12:44:40 PM Jason Gerecke wrote:
> I'm working on adding support for the recently-announced Cintiq 24HD,
> and am hashing out most of the details on the linuxwacom mailing list.
> In the discussions there, it was suggested that we add a new e.g.
> "ABS_WHEEL2" axis to the input.h header to represent the second touch
> ring available on the 24HD. I think it's a good idea, but wanted to
> get some opinions from over here before making a patch. The other
> option we have available is to use an axis not already in use by the
> wacom driver (such as ABS_RUDDER), but none have a matching semantic
> meaning.

And what if next device adds another wheel? And another...

Do these rings only make sense in the context of entire Cintiq device,
or maybe they should be treated as ancillary devices (with separate
input_dev from the main tablet device)?

Thanks.

-- 
Dmitry
