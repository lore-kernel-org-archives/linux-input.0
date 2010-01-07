From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH resend] Input: psmouse - Fix a synaptics protocol
 detection mistake
Date: Thu, 7 Jan 2010 01:55:18 -0800
Message-ID: <20100107095518.GA16387@core.coreip.homeip.net>
References: <20100103145633.E2E9C9D400D@zog.reactivated.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.216.174]:36943 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab0AGJzX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 7 Jan 2010 04:55:23 -0500
Received: by pxi4 with SMTP id 4so1142910pxi.33
        for <linux-input@vger.kernel.org>; Thu, 07 Jan 2010 01:55:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100103145633.E2E9C9D400D@zog.reactivated.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Daniel Drake <dsd@laptop.org>
Cc: linux-input@vger.kernel.org, akpm@linux-foundation.org

On Sun, Jan 03, 2010 at 02:56:33PM +0000, Daniel Drake wrote:
> For configurations where synaptics hardware is present but the synaptics
> extensions support is not compiled in, the mouse is reprobed and a new
> device is allocated on every suspend/resume.
> 
> During probe, psmouse_switch_protocol() calls psmouse_extensions() with
> set_properties=1. This calls the dummy synaptics_init() which returns an
> error code, instructing us not to use the synaptics extensions.
> 
> During resume, psmouse_reconnect() calls psmouse_extensions() with
> set_properties=0. This caused PSMOUSE_SYNAPTICS to be returned as the
> supported extensions, and as this is a different result from earlier it
> then causes psmouse_reconnect() to fail and a full reprobe happens.
> 
> Fix this by tweaking the set_properties=0 codepath in psmouse_extensions()
> to be more careful about offering PSMOUSE_SYNAPTICS extensions.
> 
> Signed-off-by: Daniel Drake <dsd@laptop.org>

Applied, thank you Daniel.

-- 
Dmitry
