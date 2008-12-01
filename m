From: Julian Sikorski <belegdol@gmail.com>
Subject: Re: Logitech Alto Cordless
Date: Mon, 01 Dec 2008 17:46:49 +0100
Message-ID: <493414F9.2050309@gmail.com>
References: <4933E4BC.5090801@gmail.com> <alpine.LRH.1.10.0812011734130.28179@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:40495 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751529AbYLAQqx (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Dec 2008 11:46:53 -0500
Received: by ug-out-1314.google.com with SMTP id 39so2724227ugf.37
        for <linux-input@vger.kernel.org>; Mon, 01 Dec 2008 08:46:51 -0800 (PST)
In-Reply-To: <alpine.LRH.1.10.0812011734130.28179@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Jiri Kosina pisze:
> On Mon, 1 Dec 2008, Julian Sikorski wrote:
> 
>> during a discussion on fedora-devel-list, I was suggested to check if
>> the said keyboard is compliant with the standards before requesting
>> xkeyboard-config changes. The problem exists with two keys:
>> - Fn-F3, has MSIE logo on it, emits XF86HomePage, should emit XF86WWW
>> - Fn-F4, has a tune on it, emit XF86Tools, should XF86AudioMedia
>> This is under Fedora 10 x86_64, using evdev driver and evdev-managed
>> keyboard map.
> 
> In order to answer this question, we need to know what the keyboard is 
> acutally sending when these keys are being pressed (and also product ID 
> would be useful -- this can be obtained from lsusb output).
> 
> Assuming that Fedora has the CONFIG_HID_DEBUG kernel option turned on (I 
> don't know whether this is true or not), could you please
> 
> 	rmmod usbhid
> 	rmmod hid
> 	modprobe hid debug=2
> 	modprobe usbhid
> 
> press the keys, and send the dmesg output?
> 
> Thanks,
> 
Hmm, the option is set, but there are no such modules here...
I am running 2.6.27.5-117.fc10.x86_64 kernel. Relevant lsusb output:
Bus 001 Device 014: ID 046d:c527 Logitech, Inc.

Julian

