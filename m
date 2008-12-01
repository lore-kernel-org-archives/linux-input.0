From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Logitech Alto Cordless
Date: Mon, 1 Dec 2008 17:36:35 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0812011734130.28179@twin.jikos.cz>
References: <4933E4BC.5090801@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:45242 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751270AbYLAQgl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 1 Dec 2008 11:36:41 -0500
In-Reply-To: <4933E4BC.5090801@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Julian Sikorski <belegdol@gmail.com>
Cc: linux-input@vger.kernel.org

On Mon, 1 Dec 2008, Julian Sikorski wrote:

> during a discussion on fedora-devel-list, I was suggested to check if
> the said keyboard is compliant with the standards before requesting
> xkeyboard-config changes. The problem exists with two keys:
> - Fn-F3, has MSIE logo on it, emits XF86HomePage, should emit XF86WWW
> - Fn-F4, has a tune on it, emit XF86Tools, should XF86AudioMedia
> This is under Fedora 10 x86_64, using evdev driver and evdev-managed
> keyboard map.

In order to answer this question, we need to know what the keyboard is 
acutally sending when these keys are being pressed (and also product ID 
would be useful -- this can be obtained from lsusb output).

Assuming that Fedora has the CONFIG_HID_DEBUG kernel option turned on (I 
don't know whether this is true or not), could you please

	rmmod usbhid
	rmmod hid
	modprobe hid debug=2
	modprobe usbhid

press the keys, and send the dmesg output?

Thanks,

-- 
Jiri Kosina
SUSE Labs

