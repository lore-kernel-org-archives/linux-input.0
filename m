From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: keypad input method question
Date: Mon, 28 Sep 2009 10:02:40 -0700
Message-ID: <20090928170240.GE21455@core.coreip.homeip.net>
References: <3ea34a000909250601n5127dd2bt6a84aab7a93c26ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:59075 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751694AbZI1RCm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2009 13:02:42 -0400
Received: by fxm18 with SMTP id 18so3825500fxm.17
        for <linux-input@vger.kernel.org>; Mon, 28 Sep 2009 10:02:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <3ea34a000909250601n5127dd2bt6a84aab7a93c26ed@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Christopher Friedt <chrisfriedt@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Christopher,

On Fri, Sep 25, 2009 at 03:01:37PM +0200, Christopher Friedt wrote:
> Hi folks,
> 
> Recently, I ported Linux to a previously unsupported device (it uses
> pxa270 processer, so most of the work was already done), and I had a
> couple of issues that I hope you could help me with.
> 
> 1) I wrote a new 'multi-function' driver for the STMPE2401 gpio
> expander, which also has a keypad controller, 3 pwm channels, and a
> rotator input, and I would appreciate it if a couple of people could
> review it for me so that it could be submitted upstream. So far, only
> the keypad function is implemented because my device doesn't use the
> others. However, I've already coded in most of the structure for the
> other device functions but they just return -ENOSYS on probe. I'm sure
> that someone with sufficient experience could probably look at my
> driver and give me a few tips on how to improve it before submission.
> Which leads me to my next question...

Just post in on the mailing list (and mark that it is for initial
review).

> 
> 2) currently the input is a bit complicated - there are a couple of
> different modifier keys, and I'm not really sure where to start to
> have userspace handle the scancode-keycode mapping. Right now it's
> done in kernel mode in a small callback function. Can somebody point
> me in the right direction? It would be nice if the keypad worked at
> the console and also in X or other graphical environments. Currently
> I'm trying to get it to work in Android, which just uses the typical
> event interface for key-remapping.
> 
> I suppose one way to do it would be to have the kernel dynamically
> switch based on if the event device is open... still it's a bit
> confusing. Any tips?
>

I would not recommend doing it, nothing stops userspace from accessing
the device through both inetrfaces (evdev and legacy one) at the same
time.

It would be curious to see what kind of keypad you have.

-- 
Dmitry
