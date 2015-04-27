From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 2/2] Input - synaptics: pin 3 touches when the firmware
 reports 3 fingers
Date: Mon, 27 Apr 2015 13:48:29 -0400
Message-ID: <20150427174829.GC25614@mail.corp.redhat.com>
References: <1429717509-27396-1-git-send-email-benjamin.tissoires@redhat.com>
 <1429717509-27396-3-git-send-email-benjamin.tissoires@redhat.com>
 <20150423163818.GC34808@dtor-ws>
 <20150423184825.GB10937@mail.corp.redhat.com>
 <20150424225049.GA14791@mail.corp.redhat.com>
 <553B610E.2000500@bitmath.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:53331 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753098AbbD0Rsj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 27 Apr 2015 13:48:39 -0400
Content-Disposition: inline
In-Reply-To: <553B610E.2000500@bitmath.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@bitmath.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hutterer <peter.hutterer@who-t.net>, Hans de Goede <hdegoede@redhat.com>

Hi Henrik,

On Apr 25 2015 or thereabouts, Henrik Rydberg wrote:
> Benjamin,
> 
> >>>> For old kernels this is not a problem because max_slots was 2 and libinput/
> >>>> xorg-synaptics knew how to deal with that. Now that max_slot is 3, the
> >>>> clients ignore BTN_TOOL_TRIPLETAP and count the actual used slots (so 2).
> >>>> It then gets confused when receiving the BTN_TOOL_TRIPLETAP and DOUBLETAP
> >>>> information, and goes wild.
> 
> Maybe the cr48 sensor should be classified as MT_SEMI instead.
> 

That's not a cr48 issue (actually the cr48 is also affected given that
it allocates 2 slots). To be able to fix the cursors jumps that we see
with any regular image sensor touchpad, I cleaned up all the code and
relied on the kernel tracking to provide an actual tracking. So now,
either the touchpad is old and it does forwards SEMI_MT, either it is
new enough and uses the in-kernel tracking.

Cheers,
Benjamin
