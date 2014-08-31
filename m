From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/5] Input: elantech - support the Fujitsu H730 laptop
Date: Sun, 31 Aug 2014 11:54:25 +0200
Message-ID: <5402F0D1.1050200@redhat.com>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58624 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750855AbaHaJya (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Aug 2014 05:54:30 -0400
In-Reply-To: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ulrik De Bie <ulrik.debie-os@e2big.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, David Herrmann <dh.herrmann@gmail.com>

Hi,

On 08/30/2014 04:10 PM, Ulrik De Bie wrote:
> This patch set makes the elantech driver work for the Fujitsu H730 laptop. It
> also adds a sysfs knob to allow other laptops that are facing similar
> problems as the Fujitsu H730 to have working touchpad.
> 
> I'm considering adding a WARN_ONCE when the crc_enabled signature check
> fails. The message would then point the user to the crc_enabled sysfs knob,
> and kindly ask the user to report the laptop to linux-input mailinglist ?
> Any suggestions ?

WARN_ONCE includes a backtrace, which will just scare users, simply use a
function static variable to build your own warn_once, which really only does
warn. Other then that I think having a warning pointing to to the sysfs knob is
a good idea. Although maybe it should only trigger on 2 consecutive crc errors
to avoid false positives?

> Two users have tested the combination of this patchset and confirmed that
> it makes the H730 touchpad/trackpoint work.
> 
> Here an overview of the patchset:
> 
> Patch 1/ : Input: elantech - use elantech_report_trackpoint for hardware v4 too
> The Fujitsu H730 is the first v4 hardware identified that also sends the
> trackpoint packets. This patch enables the trackpoint on v4 hardware.
> With this patch the trackpoint will work.
> 
> Patch 2/ : Input: elantech - Fix crc_enabled for Fujitsu H730
> Uses DMI to detect the H730 and ,if detected, will set crc_enabled to 1. 
> With this patch the touchpad and left/right button will start to work.
> 
> Patch 3/ : Input: elantech - report the middle button of the touchpad
> The Fujitsu H730 is the first laptop listed in the elantech.c file with
> 3 touchpad buttons. This patch enables the middle button for all elantech
> hardware and enables the reporting for v4 hardware.
> I want to hear feedback here on what preferences exist for the conditions
> to enable the middle button:
> - DMI
> - enable only for v4
> - enable for all/report for v3+v4

I assume you've tested this on a v4 model without a middle button ? Assuming
that that is the case I think that always enabling it on v4 is fine. I see no
reason to also enable it on v3 as long as we've no reports of v3 models with
3 buttons.

> ...
> 
> Patch 4/ : Input: Elantech - provide a sysfs knob for crc_enabled
> Probably H730 will not remain the only elantech laptop that has this failing
> detection for the crc_enabled. This provides users with a workaround when
> the crc_enabled detection fails.
> 
> Patch 5/ : Elantech - Update the documentation: trackpoint,v3/v4,crc_enabled
> This provides an update of the elantech documentation. 
> 
> Patch 4 depends on patch 2, and for consistency, patch 5 depends on patch 1-2-4.
> 
> Ulrik De Bie (5):
>   Input: elantech - use elantech_report_trackpoint for hardware v4 too
>   Input: elantech - Fix crc_enabled for Fujitsu H730
>   Input: elantech - report the middle button of the touchpad
>   Input: elantech - provide a sysfs knob for crc_enabled
>   Input: elantech - Update the documentation:
>     trackpoint,v3/v4,crc_enabled

The entire series looks good to me (the adding of the warning can be done in a follow
up patch), and is:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

> 
>  Documentation/input/elantech.txt |  85 ++++++++++++++++++++++++++--
>  drivers/input/mouse/elantech.c   | 119 ++++++++++++++++++++++++++++++++-------
>  drivers/input/mouse/elantech.h   |   2 +-
>  3 files changed, 179 insertions(+), 27 deletions(-)
> 
> Best regards,
> Ulrik De Bie
> 
