From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: uinput problem
Date: Mon, 19 May 2008 11:58:09 -0400
Message-ID: <20080519115457.ZZRA012@mailhub.coreip.homeip.net>
References: <482DB441.7020205@twam.info>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:14098 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760572AbYESP6U (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 May 2008 11:58:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1690939fgg.17
        for <linux-input@vger.kernel.org>; Mon, 19 May 2008 08:58:18 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <482DB441.7020205@twam.info>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tobias M??ller <Tobias_Mueller@twam.info>
Cc: linux-input@vger.kernel.org

Hi Tobias,

On Fri, May 16, 2008 at 06:20:17PM +0200, Tobias M??ller wrote:
> Hello everybody,
>
> I'm trying to write a small userspace program to receive keys via rs232 and sent the corresponding key events.
>
> Everything seems to work fine, except when I'm sending something like Aa oder aA where die keycode is the same. Then only AA or aa is recognized. I did't set the EV_REP bit because i don't need any auto-repeat features.
>
> I'm sending the events via the following function.
>
> void SysKeypress(int fd, int code, int down) {
> 	struct input_event ev;
> 	memset (&ev, 0, sizeof(ev));
> 	ev.type=EV_KEY; ev.code=code; ev.value=down;
> 	write (fd, &ev, sizeof(ev));
> }
>
> and if I hardcode an
>
> 	SysKeypress (uinput_fd, KEY_LEFTSHIFT, 1);
> 	SysKeypress (uinput_fd, KEY_1, 1);
> 	SysKeypress (uinput_fd, KEY_1, 0);
> 	SysKeypress (uinput_fd, KEY_LEFTSHIFT, 0);
>
> 	SysKeypress (uinput_fd, KEY_1, 1);
> 	SysKeypress (uinput_fd, KEY_1, 0);
>
> it only receices an !! and if I change the blocks an 11.
>
> I read the documentfile about input drivers, but i didn't find anything special about uinput.
>

Are you working in the console or in X? What keyboard driver are you
using? You may want to send EV_SYN/SYN_REPORT calls in between
keypress events since consumers might rely on them.

-- 
Dmitry
