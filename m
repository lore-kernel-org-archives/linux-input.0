From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [Question: Drivers/input/evdev.c] What is the use of write
 function in evdev_fops?
Date: Wed, 13 Aug 2014 10:06:39 -0700
Message-ID: <20140813170639.GA16164@core.coreip.homeip.net>
References: <CADYu30-WqEUF-BiefJBo9yWUpKKX_zoLZGXsrJSdC46N8w0OVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57926 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752831AbaHMRGm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Aug 2014 13:06:42 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so32808pad.24
        for <linux-input@vger.kernel.org>; Wed, 13 Aug 2014 10:06:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CADYu30-WqEUF-BiefJBo9yWUpKKX_zoLZGXsrJSdC46N8w0OVg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aniroop Mathur <aniroop.mathur@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

Hi Aniroop,

On Wed, Aug 13, 2014 at 10:16:34PM +0530, Aniroop Mathur wrote:
> Dear Mr. Torokhov and Linux-Input Community,
> Greetings of the day !! :)
> 
> I have not seen some good use of write function in input subsystem.
> I am trying find the good uses of write function in Input subsystem,
> but could not find the solution over internet.
> Can you please help in answering my query below:
> 
> As you know, in evdev.c file, fops is defined as below
> struct file_operations evdev_fops = {
> .read           = evdev_read,
> .write          = evdev_write,
> ...
> }
> 
> So in what cases, evdev_write function is used ?
> One case I can think of is that, it can be used in input device simulator
> to write the recorded data back into buffer.

You are right, majority of times you are reading from the buffer. Still,
sometimes you want to control hardware state, for example, toggle keyboard LED.
That can be achieved by writing appropriate event to the event device.

For simulators I think uinput is suited the best.

Thanks.

-- 
Dmitry
