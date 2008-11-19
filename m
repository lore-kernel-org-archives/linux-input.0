From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [RFC 2.6.27 1/1] Add support for Wacom W8001 penabled serial
	touchscreen
Date: Wed, 19 Nov 2008 11:33:47 -0500
Message-ID: <20081119112804.ZZRA012@mailhub.coreip.homeip.net>
References: <1227071666-10509-1-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:16622 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273AbYKSQdy (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 19 Nov 2008 11:33:54 -0500
Received: by rv-out-0506.google.com with SMTP id k40so27703rvb.1
        for <linux-input@vger.kernel.org>; Wed, 19 Nov 2008 08:33:53 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1227071666-10509-1-git-send-email-jayakumar.lkml@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Jaya,

On Wed, Nov 19, 2008 at 01:14:26PM +0800, Jaya Kumar wrote:
> Hi Dmitry, linux-input,
> 
> I am resending this patch which I had posted a few weeks back. I would really
> appreciate any feedback.
> 
> Thanks,
> jaya
> 
> 
> The Wacom W8001 sensor is a sensor device (uses electromagnetic resonance)
> and it is interfaced via its serial microcontroller to the host.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
> 

Overall looks good, with the following exceptions:

- you don't seem to report tilt events although you parse the data;
- you don't neet to have cmd_mutex since you call w8001_command just
  once upon initialization; you don't need to re-init completion
  either. I'd also remove w8001_async_command and just did serio_write
  of that 1 character rigth in w8001_connect.
- I wouldn't use expected_packet but rather examine return of
  wait_for_completion_timeout to figure out if query succeeded or not.

Thanks!

-- 
Dmitry
