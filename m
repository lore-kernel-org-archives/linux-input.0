From: Henrik Rydberg <rydberg@bitmath.org>
Subject: Re: [PATCH RFC 0/8] Input: atmel_mxt_ts - raw data via debugfs
Date: Wed, 13 Jan 2016 21:42:12 +0100
Message-ID: <5696B6A4.9080304@bitmath.org>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
 <5672EF68.3000800@itdev.co.uk> <20160111232413.GA39766@dtor-ws>
 <20160112081041.GB19287@mail.corp.redhat.com> <56968779.5060302@itdev.co.uk>
 <20160113184005.GB39593@dtor-ws>
 <CAFXsbZrJg75Z1jRYmzac9grr5Oqqtq4gW9Cs8aDh15wvBjrKNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailrelay6.public.one.com ([91.198.169.200]:44534 "EHLO
	mailrelay6.public.one.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069AbcAMU6Y (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 Jan 2016 15:58:24 -0500
In-Reply-To: <CAFXsbZrJg75Z1jRYmzac9grr5Oqqtq4gW9Cs8aDh15wvBjrKNg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Chris Healy <cphealy@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Nick Dyer <nick.dyer@itdev.co.uk>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Andrew Duggan <aduggan@synaptics.com>, James Chen <james.chen@emc.com.tw>, Dudley Du <dudl@cypress.com>, Andrew de los Reyes <adlr@chromium.org>, sheckylin@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Florian Echtler <floe@butterbrot.org>, Jonathan Cameron <jic23@cam.ac.uk>

>> I understand that the current controller and firmware you are working on
>> is not suitable for actual processing and the data rate is only useful
>> for diagnostic. This does not mean however that we can't use the same
>> high-speed interface for both diagnostic and processing, if such
>> interface is available. And given that there is desire to do some of the
>> host-side processing I'd prefer to standardize on interface that is
>> suitable for both instead of stuffing driver-specific bits into debugfs.

[snip]

> All that said, my hope is that there is room for both APIs so we can retain some
> simple console accessible debug API that works with typical shell commands,
> (cat, hexdump, sed, awk) to support simple testing, while the high performance
> userspace processing API gets what it needs too, which I would think should
> include some low-latency means of getting input events back into the kernel
> without needing uinput.

The notion of a simple high-speed input interface is surely attractive, but
perhaps the mismatch in scope says something important here.

For high-speed io, there are several subsystems that can be used as-is: video,
sound and iio for instance. The last one has matured through industrial beating,
and is now heavily used for bidirectional io (adding Jonathan).

But for the input subsystem, the versatile io device stands in juxtaposition to
the generic userland interface, which is the essence of the objection here.
Input devices and their capabilities should be easily enumerable and
recognizable. An ad-hoc debug interface is not.

So if we see an interest to incorporate high-speed io nodes in the world of
enumerable input devices, maybe it can be as easy as tucking some property and
control ioctls on top a device node driven by any or all of the mentioned
subsystems. It ought to be even simpler to use than debufs. You should certainly
be able to use it as you describe.

Henrik

