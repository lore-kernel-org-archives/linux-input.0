From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH RFC 0/8] Input: atmel_mxt_ts - raw data via debugfs
Date: Mon, 8 Feb 2016 21:38:48 +0000
Message-ID: <56B90AE8.9010608@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
 <5672EF68.3000800@itdev.co.uk> <20160111232413.GA39766@dtor-ws>
 <20160112081041.GB19287@mail.corp.redhat.com> <56968779.5060302@itdev.co.uk>
 <20160113184005.GB39593@dtor-ws>
 <CAFXsbZrJg75Z1jRYmzac9grr5Oqqtq4gW9Cs8aDh15wvBjrKNg@mail.gmail.com>
 <5696B6A4.9080304@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:50902 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756275AbcBHVjB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Feb 2016 16:39:01 -0500
In-Reply-To: <5696B6A4.9080304@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>, Chris Healy <cphealy@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Cameron <jic23@cam.ac.uk>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andrew Duggan <aduggan@synaptics.com>, James Chen <james.chen@emc.com.tw>, Dudley Du <dudl@cypress.com>, Andrew de los Reyes <adlr@chromium.org>, sheckylin@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Florian Echtler <floe@butterbrot.org>, Hans Verkuil <hansverk@cisco.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Junghak Sung <jh1009.sung@samsung.com>

On 13/01/16 20:42, Henrik Rydberg wrote:
>>> I understand that the current controller and firmware you are working on
>>> is not suitable for actual processing and the data rate is only useful
>>> for diagnostic. This does not mean however that we can't use the same
>>> high-speed interface for both diagnostic and processing, if such
>>> interface is available. And given that there is desire to do some of the
>>> host-side processing I'd prefer to standardize on interface that is
>>> suitable for both instead of stuffing driver-specific bits into debugfs.
> 
> [snip]
> 
>> All that said, my hope is that there is room for both APIs so we can retain some
>> simple console accessible debug API that works with typical shell commands,
>> (cat, hexdump, sed, awk) to support simple testing, while the high performance
>> userspace processing API gets what it needs too, which I would think should
>> include some low-latency means of getting input events back into the kernel
>> without needing uinput.
> 
> The notion of a simple high-speed input interface is surely attractive, but
> perhaps the mismatch in scope says something important here.
> 
> For high-speed io, there are several subsystems that can be used as-is: video,
> sound and iio for instance. The last one has matured through industrial beating,
> and is now heavily used for bidirectional io (adding Jonathan).
> 
> But for the input subsystem, the versatile io device stands in juxtaposition to
> the generic userland interface, which is the essence of the objection here.
> Input devices and their capabilities should be easily enumerable and
> recognizable. An ad-hoc debug interface is not.
> 
> So if we see an interest to incorporate high-speed io nodes in the world of
> enumerable input devices, maybe it can be as easy as tucking some property and
> control ioctls on top a device node driven by any or all of the mentioned
> subsystems. It ought to be even simpler to use than debufs. You should certainly
> be able to use it as you describe.

Thanks for the useful replies. We've taken a bit of time to have a look at
the V4L2 and IIO subsystems to see how we might fit raw touch data in.

Although IIO has a lot of flexibility, I don't believe it is really
suitable for the case where a single sample is a frame of up to a few
thousand 16-bit ints. I found this mail from Jonathan Cameron last year
that seems to be a similar type of use case:
http://marc.info/?l=linux-iio&m=144585499631661&w=2

Whereas V4L2 is absolutely suitable for handling frames of date, and in
fact we already have an example of it working in the sur40 driver.

It looks to me as though we would need to define a new V4L2_CTRL_CLASS
(v4l2-controls.h) to handle any touch-specific setup from user space
(mainly selecting which data types to capture, since V4L2 already has
metadata for size and data format).

I suppose it depends whether the V4L2 maintainers would be amenable to that
(added some more CCs).

Nick
