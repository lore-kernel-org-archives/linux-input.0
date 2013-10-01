From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 1/3] HID: Delay opening HID device
Date: Tue, 01 Oct 2013 09:42:15 +0100
Message-ID: <524A8AE7.5000108@kernel.org>
References: <1379524399-16995-1-git-send-email-srinivas.pandruvada@linux.intel.com> <alpine.LNX.2.00.1309241131510.18703@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51372 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751326Ab3JAHlw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Oct 2013 03:41:52 -0400
In-Reply-To: <alpine.LNX.2.00.1309241131510.18703@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, holler@ahsoftware.de

On 09/24/13 10:32, Jiri Kosina wrote:
> On Wed, 18 Sep 2013, Srinivas Pandruvada wrote:
> 
>> Don't call hid_open_device till there is actually an user. This saves
>> power by not opening underlying transport for HID. Also close device
>> if there are no active mfd client using HID sensor hub.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> 
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> 
> Jonathan, I'd be good if I pass this to you to apply the whole lot.
Applied to the togreg branch of iio.git

Thanks,
