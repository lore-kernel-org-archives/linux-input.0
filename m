From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] Input :Added Check for EV_ABS event params
Date: Wed, 22 Apr 2015 08:35:13 +0200
Message-ID: <55374121.8000308@redhat.com>
References: <aksgarg1989@gmail.com> <1429640392-30471-1-git-send-email-aksgarg1989@gmail.com> <20150421182916.GB16790@dtor-ws> <20150421215600.GA22958@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54097 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964847AbbDVGfR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 22 Apr 2015 02:35:17 -0400
In-Reply-To: <20150421215600.GA22958@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Anshul Garg <aksgarg1989@gmail.com>, linux-input@vger.kernel.org, anshul.g@samsung.com, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>

Hi,

On 21-04-15 23:56, Peter Hutterer wrote:
> On Tue, Apr 21, 2015 at 11:29:16AM -0700, Dmitry Torokhov wrote:
>> Hi Anshul,
>>
>> On Tue, Apr 21, 2015 at 11:19:52AM -0700, Anshul Garg wrote:
>>> From: Anshul Garg <aksgarg1989@gmail.com>
>>>
>>> while handling EV_ABS event in input_handle_abs_event
>>> function added check for out of range event value from
>>> input driver. As input driver sets the ABS params at
>>> registration time so input core should ignore events out
>>> of the range set by the input driver.
>>
>> No, I do not think we want to do that, at least not unconditionally,
>> especially since it is perfectly allowed to use 0 as min/max, which
>> means that exact min and max are not defined. Historically min and max
>> were provided to the userspace as a guidance and it was up to userspace
>> to decide what to do with values outside of the limits.
>
> for the archives:
> X requires us to drop coordinates outside the given range, at least the
> ones we forward to the clients from absolute devices. We have used
> out-of-bounds variables within the synaptics driver in the past though.

Also for the record, for touchpad devices min-max typically give the edges
not the absolute min / max values of the sensor. In some cases there may also
be margins given in the min/max values coming from the touchpad-firmware which
already take an edge-scrolling area into account. So with touchpads getting
values outside of the min/max range is sometimes something which not only
may happen, but actually is expected to happen.

Regards,

Hans
