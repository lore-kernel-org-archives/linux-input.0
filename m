From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Wacom Intuos4 LED and OLED control
Date: Fri, 6 May 2011 10:42:00 -0700
Message-ID: <BANLkTik2dYnc9tboMdb1KNC_o-YLmMV81w@mail.gmail.com>
References: <1302303254-3062-1-git-send-email-eduard@hasenleithner.at>
	<20110506155204.GA4754@core.coreip.homeip.net>
	<4DC421BF.9020204@hasenleithner.at>
	<20110506164301.GA27419@core.coreip.homeip.net>
	<4DC4309B.9080605@hasenleithner.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40276 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755137Ab1EFRmB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 May 2011 13:42:01 -0400
Received: by mail-bw0-f46.google.com with SMTP id 15so2672349bwz.19
        for <linux-input@vger.kernel.org>; Fri, 06 May 2011 10:42:01 -0700 (PDT)
In-Reply-To: <4DC4309B.9080605@hasenleithner.at>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eduard Hasenleithner <eduard@hasenleithner.at>
Cc: linux-input@vger.kernel.org

On Fri, May 6, 2011 at 10:32 AM, Eduard Hasenleithner
<eduard@hasenleithner.at> wrote:
> Apparently, for a device having only four LEDs wacom managed to implement a
> behaviour, which is not easy to explain. These four LEDs have two functions,
> one is the "status" LED function, the other is what I call the "wheel
> function indicator" LED function.
>
> Devices before Intuos4 just had a single status LED with three luminance
> levels "high" and "low" and "off". When "off" it means that the device is
> not ready for use (e.g driver not loaded, or device not connected). When
> "low", this LED just says to the user "Driver loaded, ready for input". When
> the stylus then touches the tablet surface, it lights with the "high" level.
> The same behavior is also obvserved when the stylus is in proximity to the
> tablet, and a button on the stylus is pressed. In the end, having the
> status-LED at "high" level means that logically at least one stylus "button"
> is pressed, including the vitual "stylus has contact with tablet surface"
> button.
>
> The Intuos4 adds the possibility to set the luminance levels for "high" and
> "low" states, with values from 0..127. low=32 and high=64 means that the
> status led will brighten during stylus contact, low=64 and high=32 will
> cause the status LED to dim during stylus contact.
>
> With Intuos4 wacom also added a touch wheel to the tablet. In the
> windows-driver it is possible to control four different "axes" with the
> single touch wheel. In order to know which axis is controlled, they could
> have simply added another four LEDs, with one of them being "on", giving a
> total of five leds. But they saved one LED, and put the status information
> to the one LED which shows the current wheel function "selection".

I see. Do all 4 leds share the settings for luminance?

-- 
Dmitry
