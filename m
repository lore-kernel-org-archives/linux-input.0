From: Oliver Neukum <oliver@neukum.org>
Subject: Re: suspend
Date: Thu, 3 Apr 2008 22:42:35 +0200
Message-ID: <200804032242.36493.oliver@neukum.org>
References: <dd18b0c30804012331oc548416k113e492d7dc9c189@mail.gmail.com> <200804031231.19193.oliver@neukum.org> <e79639220804030844w40d50824q8fbb8352ac3c0f3b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-out003.kontent.com ([81.88.40.217]:52611 "EHLO
	smtp-out003.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758233AbYDCUpo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Apr 2008 16:45:44 -0400
In-Reply-To: <e79639220804030844w40d50824q8fbb8352ac3c0f3b@mail.gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stefan Schweizer <genstef@gentoo.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb@vger.kernel.org, linux-input@vger.kernel.org

Am Donnerstag, 3. April 2008 17:44:19 schrieb Stefan Schweizer:
> Cannot seem to find the persist attribute even after this patch applied :((
> 
> CONFIG_USB_PERSIST is enabled, but other drivers do not provide it.
> However this is 2.6.24 - I will try it on 2.6.25 now.

Odd, I can't reproduce it. Alan?

	Regards
		Oliver

oneukum@tranquility:/sys/bus/usb/devices/6-1/power> ll
insgesamt 0
-r--r--r-- 1 root root 4096  3. Apr 22:40 active_duration
-rw-r--r-- 1 root root 4096  3. Apr 22:40 autosuspend
-r--r--r-- 1 root root 4096  3. Apr 22:40 connected_duration
-rw-r--r-- 1 root root 4096  3. Apr 22:40 level
-rw-r--r-- 1 root root 4096  3. Apr 22:40 persist
-rw-r--r-- 1 root root 4096  3. Apr 22:40 wakeup
