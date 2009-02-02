From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Trying to remap a wrongly labelled key
Date: Mon, 2 Feb 2009 13:32:06 +0100 (CET)
Message-ID: <alpine.LRH.1.10.0902021329210.22097@twin.jikos.cz>
References: <1232640514.3330.665.camel@cookie.hadess.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-input-owner@vger.kernel.org>
Received: from twin.jikos.cz ([213.151.79.26]:46769 "EHLO twin.jikos.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753847AbZBBMcP (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 2 Feb 2009 07:32:15 -0500
In-Reply-To: <1232640514.3330.665.camel@cookie.hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org

On Thu, 22 Jan 2009, Bastien Nocera wrote:

> This Dell keyboard has a "media" key, with a music note on it. The
> problem is that it's KEY_CONFIG I get instead of KEY_MEDIA.
> 
> So I'm trying to fix the problem in user-space. This is one of the
> snippets I've tried to use:
> 
>         int codes[2];
>         codes[0] = 0x183;
>         codes[1] = KEY_MEDIA;
>         if (ioctl (fd, EVIOCSKEYCODE, codes) < 0)
>                 perror ("Set keycode failed");
> 
> I inserted that into evtest.
> 
> # ./evtest /dev/input/event6 
> Input driver version is 1.0.0
> Input device ID: bus 0x3 vendor 0x413c product 0x2010 version 0x110
> Input device name: "Dell Dell USB Keyboard Hub"
> Supported events:
>   Event type 0 (Sync)
>   Event type 1 (Key)
> <snip>
>     Event code 171 (Config)
> <snip>
> Set keycode failed: Invalid argument
> 
> So there's a key for which the scancode corresponds to KEY_CONFIG. It
> should be 0x183 according to the HUT. but it doesn't want to work for
> me...

Hi Bastien,

for HID devices, the 'scancode' is in fact the full usage as reported by 
the device (i.e. including the HID usage page), not only the usage code 
itself. I.e. in your case this should be 0xc0183.

-- 
Jiri Kosina
SUSE Labs

