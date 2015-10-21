From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH v3] HID: wacom: Add support for Cintiq Companion 2
Date: Wed, 21 Oct 2015 11:21:56 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1510211121440.21100@pobox.suse.cz>
References: <561BDE9F.7070404@gmail.com> <1444755829-2481-1-git-send-email-killertofu@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38588 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631AbbJUJV4 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Oct 2015 05:21:56 -0400
In-Reply-To: <1444755829-2481-1-git-send-email-killertofu@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jason Gerecke <killertofu@gmail.com>
Cc: linux-input@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Ping Cheng <pinglinux@gmail.com>, Aaron Skomra <skomra@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>, Clifford Jolly <expiredpopsicle@gmail.com>

On Tue, 13 Oct 2015, Jason Gerecke wrote:

> Adds support for the EMR (pen+pad) and touchscreen devices used by the
> Wacom Cintiq Companion 2. This applies both to using the device as a
> standalone system, as well as when operating in "Cintiq mode" (where
> the EMR/touchscreen are simply exposed as USB devices to the system
> its connected to).
> 
> Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
> Signed-off-by: Clifford Jolly <expiredpopsicle@gmail.com>
> ---
> Changes from v2:
>  * The switch in wacom_setup_pen_input_capabilities now only contains the
>    first CINTIQ_COMPANION_2 case. The second case has been moved to the
>    switch in wacom_setup_pad_input_capabilities where it belongs.
> 
>  * The second CINTIQ_COMPANION_2 case mentioned above no longer explicitly
>    sets up the pad buttons since wacom_setup_numbered_buttons is now
>    (70ee06c) in charge of this initialization.

Applied to for-4.4/wacom.

-- 
Jiri Kosina
SUSE Labs

