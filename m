From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH RFC 0/8] Input: atmel_mxt_ts - raw data via debugfs
Date: Thu, 10 Mar 2016 14:08:45 +0000
Message-ID: <56E17FED.2010104@itdev.co.uk>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
 <5672EF68.3000800@itdev.co.uk> <20160111232413.GA39766@dtor-ws>
 <20160112081041.GB19287@mail.corp.redhat.com> <56968779.5060302@itdev.co.uk>
 <20160113184005.GB39593@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:50182 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbcCJOIk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 10 Mar 2016 09:08:40 -0500
In-Reply-To: <20160113184005.GB39593@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andrew Duggan <aduggan@synaptics.com>, James Chen <james.chen@emc.com.tw>, Dudley Du <dudl@cypress.com>, Andrew de los Reyes <adlr@chromium.org>, sheckylin@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Florian Echtler <floe@butterbrot.org>

> On Wed, Jan 13, 2016 at 05:20:57PM +0000, Nick Dyer wrote:
>> The devices we want to support are I2C based and the frame rate is low:
>> typically less than 10 fps with 1386 nodes, as an example. So performance
>> is not critical and doing meaningful processing is not really feasible.
>>
>> The use cases we want to support are diagnostic, for instance tuning and
>> analysing touch sensor manufacturing defects. It's useful in this context
>> to be able to interrogate the device using the command line or shell scripts.
> 
> I understand that the current controller and firmware you are working on
> is not suitable for actual processing and the data rate is only useful
> for diagnostic. This does not mean however that we can't use the same
> high-speed interface for both diagnostic and processing, if such
> interface is available. And given that there is desire to do some of the
> host-side processing I'd prefer to standardize on interface that is
> suitable for both instead of stuffing driver-specific bits into debugfs.

Hi Dmitry-

We've begun to look at re-implementing this using V4L2.

One additional thing that I wanted to raise in relation to this feature.
The diagnostic data available from these chips is not limited to raw
capacitance value data for each node on the touch matrix. Examples might be:

* One reading per X/Y line, eg a noise measurement
* Single values, for example a frame counter
* Raw pressure/button data from an active stylus

It's unclear exactly how we are going to expose this kind of information at
the moment.

One option seems to be the multi-plane support in V4L2, or defining a
custom struct for embedding this data in the V4L2 frame.

But the number of differences between chip versions means that we might
have to settle for having some way to get the raw data stream out and
forward it to some user space tool which is able to decode.

Nick
