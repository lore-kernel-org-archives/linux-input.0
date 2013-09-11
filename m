From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] uinput: Use input_inject_event in uinput_inject_event
Date: Tue, 10 Sep 2013 17:12:36 -0700
Message-ID: <20130911001235.GA5840@core.coreip.homeip.net>
References: <1378855973-11595-1-git-send-email-rmallon@gmail.com>
 <1378855973-11595-2-git-send-email-rmallon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:59322 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751890Ab3IKAMk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Sep 2013 20:12:40 -0400
Content-Disposition: inline
In-Reply-To: <1378855973-11595-2-git-send-email-rmallon@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ryan Mallon <rmallon@gmail.com>
Cc: rydberg@euromail.se, carl@ok-labs.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Ryan,

On Wed, Sep 11, 2013 at 09:32:53AM +1000, Ryan Mallon wrote:
> Call input_inject_event rather than input_event in uinput_inject_event. This
> mirrors the behaviour of evdev_write. input_inject_event will ignore the
> injected event if the uinput input device has been grabbed for exclusive
> access by a handler other than uinput.

uinput is not an input handler but input driver and therefore should
continue using input_event().

Thanks.

-- 
Dmitry
