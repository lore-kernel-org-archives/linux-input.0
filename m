From: =?ISO-8859-1?Q?=C9ric_Piel?= <Eric.Piel@tremplin-utc.net>
Subject: [REGRESSION] "bind" a device to a driver doesn't not work anymore
Date: Sun, 11 Oct 2009 02:04:02 +0200
Message-ID: <4AD120F2.3020606@tremplin-utc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:14494 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754117AbZJKAEm (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 10 Oct 2009 20:04:42 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dtor@insightbb.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linux-input@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

Hello,

After a suspend, I used to do this (to get the PS2 keyboard working 
again), and it used to work fine:
echo -n "i8042" > /sys/bus/platform/drivers/i8042/unbind ; sleep 1 ; 
echo -n "i8042" > /sys/bus/platform/drivers/i8042/bind

Unfortunately since 2.6.32-rc1, the unbind works fine, but the bind 
returns a "no such device" error now (and the binding is not done). 
After that, additional unbinds also report the error. I think 2.6.31 
worked fine. Any idea what's going wrong?

Thanks,
Eric
