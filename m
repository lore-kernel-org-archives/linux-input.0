From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: not supported hardware: Gigabyte K8100 Aivia USB Gaming Keyboard
Date: Sat, 28 Jan 2012 01:12:23 -0600
Message-ID: <20120128071223.GA27331@burratino>
References: <4D55AE81.3030805@freemail.hu>
 <20120126002100.GA4495@burratino>
 <4F21C49D.2010906@freemail.hu>
 <20120126213939.GA5179@burratino>
 <4F230A1A.7080508@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:61178 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477Ab2A1HMi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Jan 2012 02:12:38 -0500
Content-Disposition: inline
In-Reply-To: <4F230A1A.7080508@freemail.hu>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: zitev <zitev@freemail.hu>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org, jkosina@suse.cz

zitev wrote:

> I attached the lsusb output!

Perfect, thanks.

> Bus 001 Device 004: ID 1044:7a02 Chu Yuen Enterprise Co., Ltd 
[...]
>     bNumInterfaces          3
[...]
>     Interface Descriptor:
>       bInterfaceClass         3 Human Interface Device
>       iInterface              2 KB
[...]
>     Interface Descriptor:
>       bInterfaceClass         3 Human Interface Device
>       iInterface              3 Mouse
[...]
>     Interface Descriptor:
>       bInterfaceClass         3 Human Interface Device
>       iInterface              4 K8100 Interface

Can you set up usbmon and get a trace of e.g., pressing, holding,
then releasing the "a" key?  See Documentation/usb/usbmon.txt
in the Linux source or the doc directory of the linux-doc-3.2
package for details.

It works roughly like this:

1. Mount debugfs and load the usbmon module:

  mount -t debugfs debugfs /sys/kernel/debug
  modprobe usbmon

2. Start tracing:

  {
    sleep 1; # one second of quiet
    cat /sys/kernel/debug/usb/usbmon/1u >/tmp/mon.out &
    sleep 20; # twenty seconds or so to run the test
    kill $!; # and then stop collecting data
  }

3. Somehow summarize the output.  If it is fairly small, an
attachment is fine; otherwise, excerpts and maybe a link to a
copy that can be downloaded online might work.

Hope that helps,
Jonathan
