From: Charles Mooney <charliemooney@google.com>
Subject: Question about ABS_DISTANCE's intended usage.
Date: Tue, 9 Feb 2016 13:56:05 -0800
Message-ID: <CAJ34Pp7OM7DAiA1gZqQ0dtgXZ=z6p+LEVD5aeMiYOecHCbcfLw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yw0-f171.google.com ([209.85.161.171]:34023 "EHLO
	mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932936AbcBIV4p (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 9 Feb 2016 16:56:45 -0500
Received: by mail-yw0-f171.google.com with SMTP id h129so260932ywb.1
        for <linux-input@vger.kernel.org>; Tue, 09 Feb 2016 13:56:45 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dtor@google.com>

Hello all,

I'm currently working with a touchpad vendor with a new device that
supports a limited form of hover detection.  Their sensor is able to
detect the presence or absence of a finger/hand/palm hovering over the
sensor without touching it, but is unable to report any more details
about it.  This is a more limited form of hover detection than some
devices which attach a hover state to each finger they see, and can
even report x/y coordinates to hovering finger.

Instead of using ABS_MT_DISTANCE, it appears that the correct event to
use would be ABS_DISTANCE, since the value is not tied to a specific
finger.  I would like to check with you all about how this value is
intended to be used, because it's not quite as obvious to me as I
first thought.

We need to handle three basic states:
  1. At least one finger is touching the pad.
  2. Something is hovering, but nothing is actually touching.
  3. Nothing is touching the pad and nothing is detected hovering over it either

It's seems clear to me that an ABS_DISTANCE of zero should indicate
state #1 and that any other legal positive value should indicate state
#2, but I'm less clear on what the best way to handle state #3 is.
Currently, I think the best strategy would be to use a value of
ABS_DISTANCE = -1 to indicate that there are no fingers seen (hovering
or otherwise), does that make sense?

If not this, how else would you suggest that this ought to be done?

Thank you,
Charlie
