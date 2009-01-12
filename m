From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Equivalent of /dev/input/mice for keyboards
Date: Sun, 11 Jan 2009 23:32:46 -0800
Message-ID: <20090111232539.ZZRA012@mailhub.coreip.homeip.net>
References: <495EA371.8050304@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.25]:22849 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbZALHda (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 12 Jan 2009 02:33:30 -0500
Received: by qw-out-2122.google.com with SMTP id 3so9559018qwe.37
        for <linux-input@vger.kernel.org>; Sun, 11 Jan 2009 23:33:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <495EA371.8050304@manoweb.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alessio Sangalli <alesan@manoweb.com>
Cc: linux-input@vger.kernel.org

Hi Alessio,

On Fri, Jan 02, 2009 at 03:29:53PM -0800, Alessio Sangalli wrote:
> Hi, I have developed a PS/2 driver for a new ARM-based hardware.
> 
> I have used the serio subsystem and I can test with input-event or
> similar programs that the keyboard and mouse I have connected work well.
> 
> Now, this platform, being an embedded ARM board, does not have a
> "console" that can be attached to the keyboard. I only connect with
> serial port or telnet. And here I am getting confused: I can read one
> device at a time by opening /dev/input/event*.
> 
> I would like to write my userspace application so that it gets all the
> input from the various keyboards (can be up to two PS/2 keyboards + USB
> ones) and process it. The struct input_event is very convenient but what
> I am doing now is to open all the event* devices and select() them. This
> wouldn't probably work if I connect/disconnect a device on the fly. It
> would be much easier if I had a device similar to input/mice that
> automatically does the muxing for me...
> 

I am very hesitant adding such multiplexing device to the kernel. While
it is pretty easy to write one we had only pain from them. There are all
kinds of quirks, grabs, and workarounds because people are using
/dev/input/mice and console but at the same time want to use event
devices for some of the hardware.

I suppose we could make it depend on CONFIG_EMBEDDED and default to no
and have a big warning in the description that it is only supposed to be
used on embedded boards...

Doing select on event devices in userspace should actually work equally
well and you can either listen to netlink hotplug events or poll
/proc/bus/input/devices to detect when you need to add new device to the
mix. I would prefer this userspace solution.

-- 
Dmitry
