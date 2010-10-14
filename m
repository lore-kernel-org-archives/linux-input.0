From: Alan Ott <alan@signal11.us>
Subject: Re: [RFC, PATCH] HID: hid-sony, override usbhid_output_raw_report    for Sixaxis
Date: Thu, 14 Oct 2010 11:09:33 -0400
Message-ID: <4CB71D2D.90200@signal11.us>
References: <4CB62F69.1070809@signal11.us>	<1287010481-8356-1-git-send-email-ospite@studenti.unina.it>	<4CB63F88.9080300@signal11.us> <20101014094840.e215ef88.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from core.signal11.us ([64.251.29.136]:49952 "EHLO core.signal11.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225Ab0JNPJh (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 14 Oct 2010 11:09:37 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by core.signal11.us (Postfix) with SMTP id 4F8461CCAAA8
	for <linux-input@vger.kernel.org>; Thu, 14 Oct 2010 11:09:36 -0400 (EDT)
In-Reply-To: <20101014094840.e215ef88.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Antonio Ospite <ospite@studenti.unina.it>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, falktx@gmail.com

On 10/14/2010 03:48 AM, Antonio Ospite wrote:
>
> The point about overriding hid_output_raw_report() is not about
> sixaxis_set_operational_usb() sending a control message, but about any
> _output_ (not feature) report the user would like to send via
> hidraw_write(), the sixaxis will accept those only if sent on the
> control endpoint (it will discard them if sent on the interrupt ep,
> like the current usbhid code does) maybe I didn't state that clearly,
> sorry.
>    

Ok, that makes a lot more sense then. You're saying it's not about the 
code _in_ your driver, it's about userspace code accessing the sixaxis 
via hidraw.

My personal preference is that I like the override idea better than the 
quirk. An override will be slightly faster, because of not having to 
check for the quirk in non-sixaxis cases.

> About sixaxis_set_operational_usb(), I don't remember _any_ change to
> it except its name, but I guess we can very well make it call
> hid_output_raw_report(), just only after your hidraw feature report
> patches land to mainline.
>
>    

sixaxis_set_operational_usb() doesn't bother me. I was confused about 
the original intent of your patch.

Alan.


