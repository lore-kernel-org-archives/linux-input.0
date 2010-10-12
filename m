From: Oliver Neukum <oneukum@suse.de>
Subject: Re: [RFT]patch to remove kernel thread for runtime pm from usbhid
Date: Tue, 12 Oct 2010 16:40:48 +0200
Message-ID: <201010121640.48586.oneukum@suse.de>
References: <201010121000.50465.oneukum@suse.de> <201010121339.49932.oneukum@suse.de> <AANLkTimfK2JeAf2DMV_qw3a4UiZwQKJQfF2HNNU=RWP8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:60202 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932221Ab0JLMkw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Oct 2010 08:40:52 -0400
In-Reply-To: <AANLkTimfK2JeAf2DMV_qw3a4UiZwQKJQfF2HNNU=RWP8@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Maulik Mankad <mankad.maulik@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, USB list <linux-usb@vger.kernel.org>

Am Dienstag, 12. Oktober 2010, 14:10:42 schrieb Maulik Mankad:
> On Tue, Oct 12, 2010 at 5:09 PM, Oliver Neukum <oneukum@suse.de> wrote:

> > Thank you. Do both devices support remote wakeup? How much sleep time
> > was generated?
> >
> 
> Reading the wakeup node (as below) shows that its enabled.
> 
> cat /sys/bus/usb/devices/1-1/manufacturer
> Dell
> 
> # cat /sys/bus/usb/devices/1-1/power/wakeup
> enabled
> 
> My test was basically using the HID device post enumeration, and make
> sure that data transfers work reliably.
> 
> I can test more if you provide steps as per your need.

Very good! Please do a
echo "auto" >/sys/bus/usb/devices/1-1/power/level
and do the test. After that I'd like to have the content of
active_duration  connected_duration  runtime_active_time  runtime_enabled  runtime_status  runtime_suspended_time  runtime_usage  wakeup_count
in /sys/bus/usb/devices/1-1/power/

	Regards
		Oliver
