From: Henrik Rydberg <rydberg@euromail.se>
Subject: Re: How to indicate hover touch when exact distance unknown?
Date: Wed, 24 Sep 2014 07:28:07 +0200
Message-ID: <54225667.30801@euromail.se>
References: <CAG_cf+dJfiqW_V1k4MfGMBNUK9Kgc4=9BPAuum7dbs6rkmAgrQ@mail.gmail.com> <20140923145916.GA3110@mail.corp.redhat.com> <20140923162811.GB40700@core.coreip.homeip.net> <20140924045213.GA4194@jelly.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtprelay-h21.telenor.se ([195.54.99.196]:45757 "EHLO
	smtprelay-h21.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750744AbaIXF1V (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Sep 2014 01:27:21 -0400
Received: from ipb1.telenor.se (ipb1.telenor.se [195.54.127.164])
	by smtprelay-h21.telenor.se (Postfix) with ESMTP id 3F0A5CFC0
	for <linux-input@vger.kernel.org>; Wed, 24 Sep 2014 07:27:18 +0200 (CEST)
In-Reply-To: <20140924045213.GA4194@jelly.redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Peter Hutterer <peter.hutterer@who-t.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Andrew de los Reyes <andrew-vger@gizmolabs.org>, hdegoede@redhat.com, jikos@jikos.cz, David Herrmann <dh.herrmann@gmail.com>, Linux Input <linux-input@vger.kernel.org>

>>> FWIW, hid-multitouch already support those devices.
>>> ABS_MT_DISTANCE is set with a min/max of 0/1 when we detect win8
>>> certified panels with hovering capability. By default the spec does not
>>> provide the distance IIRC, and you only have one byte: InRange.
>>
>> Hmm, I missed that and this is unfortunate. The ABS capabilities
>> advertised by the devices should match their real capabilities. If
>> device can't properly report distance it should not be using
>> ABS_MT_DISTANCE/ABS_DISTANCE...
> 
> I think the hid-mt behaviour makes sense. Without explicit resolution (and
> no device sets that anyway, IIRC) any distance value > min tells us only that a
> tool is within detectable range, but not yet touching. Anything between
> min/max is only useful as a relative scale, but effectively that [min,max]
> range could be a metre or a millimeter, we can't know. So a device with a
> 0/1 range simply has low granularity and is only able to detect whether
> something is within range or touching the surface.

I agree with this, but I also share Dmitry's concern.

A device that can detect hovering, if only binary, does in fact coarsely
estimate the distance from the touching surface. A device allowing for a smooth
approach of objects would simply support a better resolution. From that
perspective, using the ABS_MT_DISTANCE capability makes sense. Pragmatically.

However, at no point are we really changing the coordinate system, which remains
euclidian space. We are simply changing resolution and thresholds for what
constitues a touch. Forcing userland to step away from the simple interpretation
is what eventually makes the capability impossible to use as intended.

So, if we cannot express, using the abs_info data, something like "contains a
detector which can coarsely estimate the distance and then uses a detector
threshold to set that distance to zero or one", we had better express it in some
other way, which is less ambiguous.

How about ABS_MT_PRESENT and/or ABS_PRESENT? It would complement TOUCH in the
case of hovering, allow the state where the tool is there but not touching, and
would unambiguously advertise the capability of detecting presence. It would
also be forward compatible with additional capabilities, such as reporting the
actual distance to the surface.

Henrik

