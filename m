From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v3 3/4] Input: gpio_keys - Allow suppression of input
 events for wakeup button presses
Date: Mon, 30 Oct 2017 11:17:06 -0700
Message-ID: <20171030181706.huwka5foqxparsiq@dtor-ws>
References: <20171030174050.30375-1-hdegoede@redhat.com>
 <20171030174050.30375-3-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:46543 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932716AbdJ3SRJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Mon, 30 Oct 2017 14:17:09 -0400
Received: by mail-pg0-f67.google.com with SMTP id k7so12339387pga.3
        for <linux-input@vger.kernel.org>; Mon, 30 Oct 2017 11:17:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20171030174050.30375-3-hdegoede@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org

On Mon, Oct 30, 2017 at 06:40:49PM +0100, Hans de Goede wrote:
> In some cases it is undesirable for a wakeup button to send input events
> to userspace if pressed to wakeup the system (if pressed during suspend).
> 
> A typical example of this is the power-button on laptops / tablets,
> sending a KEY_POWER event to userspace when woken up with the power-button
> will cause userspace to immediately suspend the system again which is
> undesirable.
> 
> For power-buttons attached to a PMIC, or handled by e.g. ACPI, not sending
> an input event in this case is take care of by the PMIC / ACPI hardware /
> code. But in the case of a GPIO button we need to explicitly suppress the
> sending of the input event.
> 
> This commit supports this by adding a suppress_evdev_events_on_wakeup bool
> to struct gpio_keys_button, which platform code can set to suppress the
> input events for presses of wakeup keys during suspend.

I think this is [your] userspace issue. What if I press the button
rapidly several times? I know Android actually _wants_ to see KEY_POWER
at resume, or its opportunistic suspend will kick in right away. I think
ChromeOS is OK with getting KEY_POWER on resume as well.

I'd say you need to have a small timeout before you start suspending
again.

Thanks.

-- 
Dmitry
