From: simon@mungewell.org
Subject: Re: [PATCH 1/2] HID: sony: Add force feedback for the Dualshock 4
Date: Thu, 9 Jan 2014 01:42:17 -0500
Message-ID: <9702a6d4a97cca7e0f05dd2329dca326.squirrel@mungewell.org>
References: <alpine.DEB.2.10.1401031518010.29517@franz-virtual-machine>
    <c6470a2c8d6a5ad2e6d3c023ae49e7ef.squirrel@mungewell.org>
    <e14a0771e48b8c1d72ee9182eb7d2593.squirrel@mungewell.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:35189 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751183AbaAIGmV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 9 Jan 2014 01:42:21 -0500
In-Reply-To: <e14a0771e48b8c1d72ee9182eb7d2593.squirrel@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Frank Praznik <frank.praznik@oh.rr.com>, linux-input@vger.kernel.org

>
>> However I am seeing some weird behaviour in whether FF/LED actually
>> functions. It seems that in a 'complete' kernel installation the driver
>> does not present FF or LED.
>>

Found the problem (or at least a solution), there is no entry in 'hid-core.c'
--
static const struct hid_device_id hid_have_special_driver[] = {
...
	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_SONY,
USB_DEVICE_ID_SONY_PS4_CONTROLLER) },
--

Adding this makes it work for me, although I don't know why the insmod
trick was working....
Simon

