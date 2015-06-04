From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH 0/5] HID: wacom: Support tablets with pen and touch on
 same interface
Date: Thu, 4 Jun 2015 10:18:46 -0400
Message-ID: <20150604141846.GB2495@mail.corp.redhat.com>
References: <1433380697-28612-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:57983 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752102AbbFDOSt (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 4 Jun 2015 10:18:49 -0400
Content-Disposition: inline
In-Reply-To: <1433380697-28612-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Jason Gerecke <jason.gerecke@wacom.com>

Hi Jason,

On Jun 03 2015 or thereabouts, Jason Gerecke wrote:
> I've recently got my hands on a device which has an I2C sensor that sends
> both pen and touch reports from a single interface. To userspace, it shows
> up as a single input device which blends both the report types (e.g. it has
> ABS_PRESSURE for the pen, and ABS_MT_POSITION_X for the touch). This patch
> set modifies the driver to be able to handle devices which place both pen
> and touch on a the same interface. It does this by treating the pen, touch,
> and pad (which was already special-cased) independently. If a device has
> the appropriate device_type, one or more of pen/touch/pad input devices
> will be created, initialized, and used to send data to userspace.
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>

This all seems sensible. I gave a quick look yesterday and could not
found any obvious problem, but I'd like to review it more thoroughly
before giving my rev-by (and do a little bit of testing too).

I don't believe there will be any problems for the series, besides the
Bamboo PAD. Have you tested on this?

Cheers,
Benjamin

> 
> Jason Gerecke (5):
>   HID: wacom: Simplify 'wacom_update_name'
>   HID: wacom: Treat features->device_type values as flags
>   HID: wacom: Introduce a new WACOM_DEVICETYPE_PAD device_type
>   HID: wacom: Split apart 'wacom_setup_pentouch_input_capabilites'
>   HID: wacom: Introduce new 'touch_input' device
> 
>  drivers/hid/wacom.h     |   4 +-
>  drivers/hid/wacom_sys.c | 194 +++++++++++++++----------
>  drivers/hid/wacom_wac.c | 379 ++++++++++++++++++++++++++----------------------
>  drivers/hid/wacom_wac.h |  15 +-
>  4 files changed, 332 insertions(+), 260 deletions(-)
> 
> -- 
> 2.4.1
> 
