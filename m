From: simon@mungewell.org
Subject: Re: [RFC] HID: hid-sony: Add basic iio-subsystem reading of SixAxis
 Accelerometers
Date: Thu, 18 Jun 2015 02:15:46 -0400
Message-ID: <a740eca098128c7a830db825d7c0288c.squirrel@mungewell.org>
References: <195dff9bd065db7e618280cb7c6eb5a9.squirrel@mungewell.org>
    <1434034458-1968-1-git-send-email-simon@mungewell.org>
    <557D9564.9090800@kernel.org>
    <d6702f5d19d2baea80132666fcf7654a.squirrel@mungewell.org>
    <557DC084.6090205@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:58900 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751567AbbFRGPs (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 18 Jun 2015 02:15:48 -0400
In-Reply-To: <557DC084.6090205@kernel.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jonathan Cameron <jic23@kernel.org>
Cc: simon@mungewell.org, linux-input@vger.kernel.org, Frank Praznik <frank.praznik@oh.rr.com>, linux-iio@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>


>> I have further advanced the patch to include reading via buffer, but I'm
>> having trigger 'conceptual' problems getting my head around the HID
>> device
>> issuing an interrupt when a input report is received. Looking at
>> iio_dummy_event and iios_sysfs for inspiration....
> You can skip the triggers.  It's not obligatory, you can push directly
> into a buffer.
> Triggers are nice for 'data ready' type signals (which is closest to what
> we
> have here) if you might want to hang other sensors off the timing (so read
> on demand ADCs etc.  They aren't actually 'required' as such.

After a bit of poking around I got the triggers working as well, I can
self trigger and even trigger another (iio-dummy) device.

However I couldn't trigger two devices at the same time from a single
trigger, is this normal for IIO?


Next is a little code clean-up and I'll post what I have for some more
comments,
Simon.

