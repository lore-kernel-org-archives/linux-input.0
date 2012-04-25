From: "James Woodcock" <James.Woodcock@ACULAB.COM>
Subject: Memory leak in drivers/hid/hidraw.c
Date: Wed, 25 Apr 2012 10:56:57 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F602BB6E1D@saturn3.aculab.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx0.aculab.com ([213.249.233.131]:44455 "HELO mx0.aculab.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754975Ab2DYJ5C convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Apr 2012 05:57:02 -0400
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 19199-05 for <linux-input@vger.kernel.org>;
 Wed, 25 Apr 2012 10:56:59 +0100 (BST)
Content-class: urn:content-classes:message
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

I have got a USB HID device which I am talking to with ioctls
HIDIOCSFEATURE and HIDIOCGFEATURE on Linux 3.3.3, and I think I have
discovered a memory leak.

When I call ioctl(fd, HIDIOCGFEATURE...), a long series of things
happens in the kernel that eventually causes hidraw_report_event() to be
called to let the user space program know there is data to be retrieved
by read().  hidraw_report_event() calls kmemdup() to create a copy of
the data to be returned.  However, I'm never going to call read()
because
the data is returned by the ioctl() call.

So, I think that the main bug I have spotted is that if the user calls
ioctl(fd, HIODCGFEATURE...), hidraw_report_event() should not be called.
I'm not really familiar with the code, so I'm not sure what the best fix
would be.

There are a couple of secondary issues:
hidraw_report_event() copies data onto the circular buffer like this:
  list->buffer[list->head].value = kmemdup(data, len, GFP_ATOMIC)
If list->buffer[list->head].value is not NULL (because I haven't ever
called read()), then the old list->buffer[list->head].value memory is
leaked.

hidraw_release() should probably free any non-NULL values in
list->buffer, I think.

James



