From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: wacom: generic: Send BTN_STYLUS3 when both barrel
 switches are set
Date: Thu, 9 Nov 2017 13:34:06 +0100 (CET)
Message-ID: <nycvar.YFH.7.76.1711091333510.32604@cbobk.fhfr.pm>
References: <20171107162517.1591-1-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:52904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754268AbdKIMeH (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Nov 2017 07:34:07 -0500
In-Reply-To: <20171107162517.1591-1-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Peter Hutterer <peter.hutterer@who-t.net>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

On Tue, 7 Nov 2017, Jason Gerecke wrote:

> The Wacom Pro Pen 3D includes a third barrel switch which is intended to
> be particularly useful in applications where one frequency uses pan, zoom,
> and rotate to navigate around a scene or model. The pen is compatible with
> the MobileStudio Pro, 2nd-gen Intuos Pro, and Cintiq Pro. When the third
> button is pressed, these devices set both the HID_DG_BARRELSWITCH and
> HID_DG_BARRELSWITCH2 usages since their HID descriptors do not include a
> usage specific to the button.
> 
> Rather than send both BTN_STYLUS and BTN_STYLUS2 when the third button is
> pressed, userspace (libinput) has requested that we detect this condition
> and report a newly-defined BTN_STYLUS3 event instead. We could define a
> quirk specific to devices compatible with the Pro Pen 3D, but the liklihood
> of seeing both barrel switch bits set with other pens/devices is low enough
> to not worry about (pens mechanically prevent accidental activation of
> multiple switches).
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Acked-by: Peter Hutterer <peter.hutterer@who-t.net>
> Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Applied to for-4.15/wacom.

-- 
Jiri Kosina
SUSE Labs

