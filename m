From: "Henrik Rydberg" <rydberg@bitmath.se>
Subject: Re: [PATCH v3] HID: Allow drivers to be their own listener
Date: Fri, 20 Jul 2012 14:28:01 +0200
Message-ID: <20120720122801.GA1463@polaris.bitmath.org>
References: <1342777749-31457-1-git-send-email-dh.herrmann@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from csmtp2.one.com ([91.198.169.22]:33000 "EHLO csmtp2.one.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751979Ab2GTM0w (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Jul 2012 08:26:52 -0400
Content-Disposition: inline
In-Reply-To: <1342777749-31457-1-git-send-email-dh.herrmann@googlemail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-input@vger.kernel.org, jkosina@suse.cz

On Fri, Jul 20, 2012 at 11:49:09AM +0200, David Herrmann wrote:
> hid-picolcd and hid-wiimote do not allow any of hidinput, hiddev or hidraw
> to claim the device but still want to remain on the bus. Hence, if a
> driver uses the raw_event callback but no other listener claimed the
> device, we still leave it on the bus as the driver handles everything by
> itself. It thus becomes its own listener.
> 
> Under some circumstances (eg., hidinput_connect() fails and raw_event set)
> a device may be left on the bus even though it requires external
> listeners. But then if hidinput_connect() fails there are bigger issues
> than a device that is left unhandled. So we can safely use this heuristic
> to avoid adding another flag for special devices like hid-picolcd and
> hid-wiimote.
> 
> This also removes the ugly hack from hid-picolcd as this is no longer
> required.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
> Sorry for the delay. I had two exams this week that got into my way. Anyway, I
> hope this time the patch looks ok.
> 
> Thanks to Henrik for reviewing it the previous times.

Thanks, David, looking good now.

    Acked-by: Henrik Rydberg <rydberg@euromail.se>

Henrik
