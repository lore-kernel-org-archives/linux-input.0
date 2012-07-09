From: Seth Forshee <seth.forshee@canonical.com>
Subject: Re: Lenovo G360: ALPS Touchpad Recognized as "PS/2 Generic
 Mouse"(with newly dmesg information)
Date: Mon, 9 Jul 2012 09:45:08 -0500
Message-ID: <20120709144508.GB4985@thinkpad-t410>
References: <20120706113942.40152322.dashing.meng@gmail.com>
 <20120706051141.GA2937@thinkpad-t410>
 <20120707133519.25bf82d4.dashing.meng@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:45098 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab2GIOpM (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Jul 2012 10:45:12 -0400
Content-Disposition: inline
In-Reply-To: <20120707133519.25bf82d4.dashing.meng@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: littlebat <dashing.meng@gmail.com>
Cc: linux-input@vger.kernel.org, 679750@bugs.debian.org, jrnieder@gmail.com, rik.theys@gmail.com

On Sat, Jul 07, 2012 at 01:35:19PM +0800, littlebat wrote:
> Briefly, "proto_version" V4 with "command_mode_resp" 0x00, 0x01, 0x73,
> 0x0d and V3 with 0x0d, 0x73, show the almost same symptoms:
> 1, dmesg output:
> [   19.105550] psmouse serio4: alps: E6 report: 00 00 64
> [   19.130028] psmouse serio4: alps: E7 report: 73 03 50
> [   19.149304] psmouse serio4: alps: unknown response while entering
> command mode: 73 01 0d 
> mode

Okay, I don't suspect the v3/v4 protocol support is likely to work then.

> And, V2 or V1 with 0x8a or 0x00, show the almost same symptoms below:
> 1, dmesg output:
> [   19.935069] psmouse serio4: alps: E6 report: 00 00 64
> [   19.960457] psmouse serio4: alps: E7 report: 73 03 50
> [   20.000732] psmouse serio4: alps: Status: 10 00 0a

...

> 4, There is touchpad tab in gnome mouse setting dialog, but the
> functions of "edge scrolling" and "disable touchpad when typing" still
> can't work even if I can setup them in touchpad tab in gnome mouse
> setting dialog.

The alps driver will detect and handle raw PS/2 mouse data, so what it
sounds like to me is that the alps driver manages to attach to your
device but doesn't get it sending absolute data packets. As a result the
driver is only passing relative motion data instead of absolute position
data, which means the touchpad is usable but still can't support any
touchpad features like edge scrolling.

So it sounds like we don't know how to talk to your touchpad, and
there's no trivial way to add support for it to the driver. There's
not really anything more I can do to help since I don't have access to
the hardware.

Seth
