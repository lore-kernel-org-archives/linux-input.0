From: Jarod Wilson <jarod@redhat.com>
Subject: Re: [PATCH] hid: ignore all recent SoundGraph iMON devices
Date: Mon, 19 Oct 2009 13:10:30 -0400
Message-ID: <4ADC9D86.9030704@redhat.com>
References: <200907311056.36729.jarod@redhat.com> <200908022116.05450.jarod@redhat.com> <4A76E098.90705@gmail.com> <200908030922.32334.jarod@redhat.com> <4A76E94F.1010508@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35297 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756363AbZJSRLb (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 19 Oct 2009 13:11:31 -0400
In-Reply-To: <4A76E94F.1010508@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

On 8/3/09 9:42 AM, Anssi Hannula wrote:
>>>> We're already doing
>>>> >>>  input layer stuff with the mouse mode and mouse buttons, and looking to
>>>> >>>  further extend that, potentially making the driver pure input layer,
>>>> >>>  but still usable with the lirc devinput userspace driver.
>>> >>  Oh, this sounds to me like active work getting lirc into upstreamable
>>> >>  condition:)   Is it that?
>> >
>> >  It is. I'm hoping to send another submission for upstream review Real
>> >  Soon Now. lirc_imon, lirc_mceusb, lirc_serial and lirc_i2c are all in
>> >  pretty good shape now, will probably limit the submission to those
>> >  four this time around...
> Great:)

With luck, this submission will finally go out tonight or tomorrow. I've 
got a 99% functional pure input layer imon driver implementation 
together now that'll be included -- it'll be the default mode for imon 
devices that do onboard decoding, with a modparam that can be used to 
fall back to "classic" lirc mode. Just need to do a bit of final testing 
and code cleanup.

-- 
Jarod Wilson
jarod@redhat.com
