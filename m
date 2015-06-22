From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 0/2] Input: xpad: fix 360 wireless controller blinking
 LEDs
Date: Mon, 22 Jun 2015 14:24:24 -0700
Message-ID: <20150622212424.GC2350@dtor-ws>
References: <1433890579-2124-1-git-send-email-rojtberg@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f177.google.com ([209.85.223.177]:36338 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255AbbFVVY3 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 22 Jun 2015 17:24:29 -0400
Received: by iecvh10 with SMTP id vh10so27935873iec.3
        for <linux-input@vger.kernel.org>; Mon, 22 Jun 2015 14:24:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1433890579-2124-1-git-send-email-rojtberg@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Rojtberg <rojtberg@gmail.com>
Cc: linux-input@vger.kernel.org, pgriffais@valvesoftware.com, gregkh@linuxfoundation.org

On Wed, Jun 10, 2015 at 12:56:17AM +0200, Pavel Rojtberg wrote:
> From: Pavel Rojtberg <rojtberg@gmail.com>
> 
> this series is based on the changes discussed in
> "[PATCH 0/7] Input: xpad: Fix wireless controller connection and leds".
> It incorporates the discussed improvements, while leaving the conroversal parts out. 
> So only the constantly blinking LED on the Xbox360 Wireless controller is fixed. 
> But hopefully there is now a better chance to get this merged.
> 
> v2 changes:
> - fix mail subject
> - correct modulus in xpad_send_led_command
> 
> Pavel Rojtberg (1):
>   Input: xpad: re-send LED command on present event
> 
> Pierre-Loup A. Griffais (1):
>   Input: xpad: set the LEDs properly on XBox Wireless controllers
> 

Applied both (with minor edits in #2).

Thank you.

-- 
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" in
