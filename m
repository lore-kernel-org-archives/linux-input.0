From: ulrik.debie-os@e2big.org
Subject: Re: [PATCH 0/5] Input: elantech - support the Fujitsu H730 laptop
Date: Thu, 23 Oct 2014 20:36:19 +0200
Message-ID: <20141023183618.GA7637@lantern>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
 <542FBEDD.5090409@web.de>
 <542FBF9A.5040003@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:43671 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751062AbaJWTJj (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2014 15:09:39 -0400
Content-Disposition: inline
In-Reply-To: <542FBF9A.5040003@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jan Kiszka <jan.kiszka@web.de>, Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>

Hi Dmitry,

On Sat, Oct 04, 2014 at 11:36:26AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/04/2014 11:33 AM, Jan Kiszka wrote:
> > On 2014-08-30 16:10, Ulrik De Bie wrote:
> >> This patch set makes the elantech driver work for the Fujitsu H730 laptop. It
> >> also adds a sysfs knob to allow other laptops that are facing similar
> >> problems as the Fujitsu H730 to have working touchpad.
> >>
> >> I'm considering adding a WARN_ONCE when the crc_enabled signature check
> >> fails. The message would then point the user to the crc_enabled sysfs knob,
> >> and kindly ask the user to report the laptop to linux-input mailinglist ?
> >> Any suggestions ?
> >>
> >> Two users have tested the combination of this patchset and confirmed that
> >> it makes the H730 touchpad/trackpoint work.
> >>
> >> Here an overview of the patchset:
> >>
> >> Patch 1/ : Input: elantech - use elantech_report_trackpoint for hardware v4 too
> >> The Fujitsu H730 is the first v4 hardware identified that also sends the
> >> trackpoint packets. This patch enables the trackpoint on v4 hardware.
> >> With this patch the trackpoint will work.
> >>
> >> Patch 2/ : Input: elantech - Fix crc_enabled for Fujitsu H730
> >> Uses DMI to detect the H730 and ,if detected, will set crc_enabled to 1. 
> >> With this patch the touchpad and left/right button will start to work.
> >>
> >> Patch 3/ : Input: elantech - report the middle button of the touchpad
> >> The Fujitsu H730 is the first laptop listed in the elantech.c file with
> >> 3 touchpad buttons. This patch enables the middle button for all elantech
> >> hardware and enables the reporting for v4 hardware.
> >> I want to hear feedback here on what preferences exist for the conditions
> >> to enable the middle button:
> >> - DMI
> >> - enable only for v4
> >> - enable for all/report for v3+v4
> >> ...
> >>
> >> Patch 4/ : Input: Elantech - provide a sysfs knob for crc_enabled
> >> Probably H730 will not remain the only elantech laptop that has this failing
> >> detection for the crc_enabled. This provides users with a workaround when
> >> the crc_enabled detection fails.
> >>
> >> Patch 5/ : Elantech - Update the documentation: trackpoint,v3/v4,crc_enabled
> >> This provides an update of the elantech documentation. 
> >>
> >> Patch 4 depends on patch 2, and for consistency, patch 5 depends on patch 1-2-4.
> >>
> >> Ulrik De Bie (5):
> >>   Input: elantech - use elantech_report_trackpoint for hardware v4 too
> >>   Input: elantech - Fix crc_enabled for Fujitsu H730
> >>   Input: elantech - report the middle button of the touchpad
> >>   Input: elantech - provide a sysfs knob for crc_enabled
> >>   Input: elantech - Update the documentation:
> >>     trackpoint,v3/v4,crc_enabled
> >>
> >>  Documentation/input/elantech.txt |  85 ++++++++++++++++++++++++++--
> >>  drivers/input/mouse/elantech.c   | 119 ++++++++++++++++++++++++++++++++-------
> >>  drivers/input/mouse/elantech.h   |   2 +-
> >>  3 files changed, 179 insertions(+), 27 deletions(-)
> >>
> >> Best regards,
> >> Ulrik De Bie
> >>
> > 
> > What's the status of this series? Is it queued for 3.18 already?
> 
> I don't see them in next yet:
> 
> http://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git/log/drivers/input/mouse/elantech.c
> 
> I agree it would be nice to get these into 3.18.
> 
> Dmitry, what is the plan here ?

Ping Dmitry ?

Do you want me to resend the patch ?

Kind regards,
Ulrik
