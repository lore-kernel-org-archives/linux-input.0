From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Hp 3d driveguard seems to be sending events through the keyboard
 bus - should atkbd be modified to ignore that?
Date: Thu, 16 Oct 2014 16:11:08 -0700
Message-ID: <20141016231108.GE30009@dtor-ws>
References: <543FECAD.5030104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f173.google.com ([209.85.192.173]:46682 "EHLO
	mail-pd0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751116AbaJPXLM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Oct 2014 19:11:12 -0400
Received: by mail-pd0-f173.google.com with SMTP id g10so4059578pdj.18
        for <linux-input@vger.kernel.org>; Thu, 16 Oct 2014 16:11:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <543FECAD.5030104@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Giedrius Statkevicius <giedrius.statkevicius@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Giedrius,

On Thu, Oct 16, 2014 at 07:05:01PM +0300, Giedrius Statkevicius wrote:
> Hello,
> In some hp laptops there is a functionality called hp 3d driverguard
> which is basically a accelerometer that detects free fall. It seems
> that on some laptops a keyboard button press event is generated when
> accelerometer's values change and ofc the scan code is not recognized
> by atkbd (and it shouldn't be as it's not a real key). The result of
> this is that the system log gets filled with these messages:
> 
> [ 9163.578181] atkbd serio0: Unknown key pressed (translated set 2, code 0xa8 on isa0060/serio0).
> [ 9163.578189] atkbd serio0: Use 'setkeycodes e028 <keycode>' to make it known.
> 
> The range of scan codes seem to be from 0xa5 to 0xa8. In my opinion,
> these scan codes on hp laptops with this future should definitely be
> ignored because they are handled by the 'hp_accel' driver. For some
> reason, the accelerometer sends the events through the keyboard bus too.
> 
> I've filled a bug report here:
> https://bugzilla.kernel.org/show_bug.cgi?id=84941
> 
> What does everyone else think about ignoring these scan codes for
> laptops with this particular feature?

hp_accel driver should use i8042_install_filter() to install a
filtering function that will remove accelerometer data from the keyboard
data stream.

Thanks.

-- 
Dmitry
