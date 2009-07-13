From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add Hold on/off and volume event keys
Date: Sun, 12 Jul 2009 20:44:00 -0700
Message-ID: <20090713034359.GB10819@dtor-d630.eng.vmware.com>
References: <4A5A0251.8010803@marcansoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.231]:52541 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbZGMDoE (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 12 Jul 2009 23:44:04 -0400
Received: by rv-out-0506.google.com with SMTP id f6so552371rvb.1
        for <linux-input@vger.kernel.org>; Sun, 12 Jul 2009 20:44:04 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A5A0251.8010803@marcansoft.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hector Martin <hector@marcansoft.com>
Cc: linux-input@vger.kernel.org

Hi Hector,

On Sun, Jul 12, 2009 at 05:33:37PM +0200, Hector Martin wrote:
> Recent Acer laptops produce key events when the Hold button on the media
> control panel is activated and deactivated. These events are relevant
> for software that wishes to interact with the media panel beyond just
> using the media control keys.

What exactly is supposed to happen when you press hold key? Also, is it
tuly a key or a switch?

> 
> There's also a volume notification key event that replaces the usual
> volume-up/down events when the panel is in software-controlled mode.
> Software can react to this to detect volume level changes instead of
> polling.
> 

No, I don't think this kind of notification belongs to input layer.

-- 
Dmitry
