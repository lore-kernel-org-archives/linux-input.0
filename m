From: =?UTF-8?B?RMOibmllbA==?= Fraga <fragabr@gmail.com>
Subject: Re: 3.5.1 hid_generic causes mouse locking until a button is
 clicked
Date: Mon, 13 Aug 2012 06:18:55 -0300
Message-ID: <5028c683.0a4bec0a.097b.4fca@mx.google.com>
References: <k06dcc$u9q$1@dough.gmane.org>
	<20120812195329.2cb454c3@neptune.home>
	<50281d29.516eec0a.683e.1052@mx.google.com>
	<2204600.iAkYKzSYsi@linux-lqwf.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:46596 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750929Ab2HMJTA (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Aug 2012 05:19:00 -0400
Received: by yenl14 with SMTP id l14so1665138yen.19
        for <linux-input@vger.kernel.org>; Mon, 13 Aug 2012 02:19:00 -0700 (PDT)
In-Reply-To: <2204600.iAkYKzSYsi@linux-lqwf.site>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: Bruno =?UTF-8?B?UHLDqW1vbnQ=?= <bonbons@linux-vserver.org>, linux-input@vger.kernel.org

On Mon, 13 Aug 2012 08:30:35 +0200
Oliver Neukum <oneukum@suse.de> wrote:

> The kernel doesn't do this. Mice are told to wake up when they have input
> data. They decide themselves what data should be collected while they
> sleep. The USB HID spec offers no way to learn what will wake up a device.
> In fact, it does'nt mention power management.

	Ok.

> Probably the device didn't autosuspend. Disable autosuspension.

	Nice, this is a good workaround:

/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.6/power$ echo -1 >
autosuspend

	Now it's correct. Thank you ;)

-- 
Linux 3.5.1: Saber-toothed Squirrel
http://www.youtube.com/DanielFragaBR
