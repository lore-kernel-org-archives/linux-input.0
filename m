From: David =?iso-8859-1?Q?H=E4rdeman?= <david@hardeman.nu>
Subject: Two questions regarding evdev
Date: Wed, 24 Mar 2010 21:53:32 +0100
Message-ID: <20100324205332.GA7303@hardeman.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:52072 "EHLO
	palpatine.hardeman.nu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751533Ab0CXVC2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Mar 2010 17:02:28 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

I've been going over the evdev (drivers/input/evdev.c) code since I'm 
using it as inspiration for a small project I'm hacking on. So far I 
have two questions with regard to the code:

First, evdev_event passes a new event to all connected clients (writing 
it to each client's event fifo) and then calls wake_up_interruptible.  
However, given that all clients will have at least one new event to read 
after evdev_event is done, shouldn't wake_up_interruptible_all be called 
instead?

Second, evdev_poll never sets the POLLOUT flag, but evdev can accept 
writes (which will be passed to input_inject_event), so shouldn't the 
POLLOUT flag always be set?

Regards,
David

