From: Frank Praznik <frank.praznik@oh.rr.com>
Subject: Re: [PATCH 1/2] HID: sony: Add force feedback for the Dualshock 4
Date: Thu, 09 Jan 2014 14:29:22 -0500
Message-ID: <52CEF892.2000509@oh.rr.com>
References: <alpine.DEB.2.10.1401031518010.29517@franz-virtual-machine>    <c6470a2c8d6a5ad2e6d3c023ae49e7ef.squirrel@mungewell.org>    <e14a0771e48b8c1d72ee9182eb7d2593.squirrel@mungewell.org> <9702a6d4a97cca7e0f05dd2329dca326.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:50273 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbaAIT3Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 14:29:25 -0500
In-Reply-To: <9702a6d4a97cca7e0f05dd2329dca326.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: simon@mungewell.org
Cc: linux-input@vger.kernel.org

On 1/9/2014 01:42, simon@mungewell.org wrote:
>>> However I am seeing some weird behaviour in whether FF/LED actually
>>> functions. It seems that in a 'complete' kernel installation the driver
>>> does not present FF or LED.
>>>
> Found the problem (or at least a solution), there is no entry in 'hid-core.c'
> --
> static const struct hid_device_id hid_have_special_driver[] = {
> ...
> 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
> USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
> --
>
> Adding this makes it work for me, although I don't know why the insmod
> trick was working....
> Simon
>
Ah, I didn't realize that it needed an entry there.  I'll add this to v2 
of the patch set.  Thanks!
