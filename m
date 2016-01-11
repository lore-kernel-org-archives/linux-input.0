From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH RFC 0/8] Input: atmel_mxt_ts - raw data via debugfs
Date: Mon, 11 Jan 2016 15:24:13 -0800
Message-ID: <20160111232413.GA39766@dtor-ws>
References: <1449088951-7069-1-git-send-email-nick.dyer@itdev.co.uk>
 <5672EF68.3000800@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35617 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758151AbcAKXYR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Jan 2016 18:24:17 -0500
Content-Disposition: inline
In-Reply-To: <5672EF68.3000800@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Benson Leung <bleung@chromium.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Alan Bowens <Alan.Bowens@atmel.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Chris Healy <cphealy@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>, Andrew Duggan <aduggan@synaptics.com>, James Chen <james.chen@emc.com.tw>, Dudley Du <dudl@cypress.com>, Andrew de los Reyes <adlr@chromium.org>, sheckylin@chromium.org, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>

Hi Nick,

On Thu, Dec 17, 2015 at 05:22:48PM +0000, Nick Dyer wrote:
> On 02/12/15 20:42, Nick Dyer wrote:
> > This is a series of patches to add diagnostic data support to the Atmel
> > maXTouch driver. There's an existing implementation in the open-source mxt-app
> > tool, however there are performance advantages to moving this code into the driver.
> > The algorithm for retrieving the data has been fairly consistent across a range of
> > chips, with the exception of the mXT1386 series (see patch).
> > 
> > The intention is to open-source a utility which can read/display this data, this
> > should be available very shortly.
> 
> Hi-
> 
> The utility to read this data has now been released, and you can find it at:
> https://github.com/ndyer/heatmap
> 
> I've recorded a couple of videos of the utility in action on a Pixel 2:
> * https://youtu.be/M0VD2gZt8Zk
> * https://youtu.be/nwDLB4zikzU

Thank you for sharing the utility and the recording, but it seems that
there is a desire to get access to the heat maps not only for
validation, but also for certain processing purposes, and so I do not
think that we should try to standardize on debugfs as the interface, but
rather look for something that allows better performance.

I wonder if the interface should look similar to the V4L2 capture API
where application opens a character device, uses several ioctls to query
its capabilities/set up capture parameters (i.e reference or deltas),
select()s file descriptor for reading and then uses mmap() to access the
captured heat map.

I've CCed a few people who might be interested in this topic.

Thanks.

-- 
Dmitry
