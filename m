From: "Stefan Schweizer" <genstef@gentoo.org>
Subject: Re: suspend
Date: Sat, 5 Apr 2008 00:40:35 +0200
Message-ID: <e79639220804041540u3b0278cchff1d36b4cba5fc05@mail.gmail.com>
References: <200804032242.36493.oliver@neukum.org>
	 <200804041059.10276.oliver@neukum.org>
	 <e79639220804040220g560e94b4l418724ff1653780d@mail.gmail.com>
	 <200804041336.32457.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.177]:52507 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbYDDWkh (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Apr 2008 18:40:37 -0400
Received: by wa-out-1112.google.com with SMTP id v27so207675wah.23
        for <linux-input@vger.kernel.org>; Fri, 04 Apr 2008 15:40:35 -0700 (PDT)
In-Reply-To: <200804041336.32457.oliver@neukum.org>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Apr 4, 2008 at 1:36 PM, Oliver Neukum <oliver@neukum.org> wrote:
> Am Freitag, 4. April 2008 11:20:51 schrieb Stefan Schweizer:
>
> > Yeah, I tested it with the combined patch. How can I test if
>  > autosuspend works? Seems to work fine so far but does not write in my
>  > logfile. No problems found when testing.
>
>  Please compile your kernel with CONFIG_PM_DEBUG and follow the
>  instructions in Documentation/usb. You should see something in the log.

there is still no information in dmesg when I use the device. Do I
need more debugging maybe?

That is one rmmod; modprobe cycle:

usbcore: deregistering interface driver appletouch
PM: Removing info for No Bus:mouse1
PM: Removing info for No Bus:event5
PM: Removing info for No Bus:input5
input: appletouch disconnected
appletouch: Geyser mode initialized.
PM: Adding info for No Bus:input12
input: appletouch as
/devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.1/input/input12
PM: Adding info for No Bus:mouse1
PM: Adding info for No Bus:event5
usbcore: registered new interface driver appletouch

Best regards,
Stefan
