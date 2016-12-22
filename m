From: "Lars R. Damerow" <lars@pixar.com>
Subject: increasing LED_MAX and INPUT_DEVICE_ID_LED_MAX?
Date: Thu, 22 Dec 2016 13:03:07 -0800
Message-ID: <20161222210306.GE8919@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-lb.pixar.com ([138.72.247.109]:64834 "EHLO
        smtp-lb.pixar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752619AbcLVVNk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 22 Dec 2016 16:13:40 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hello,

I'm trying to use a range of P. I. Engineering's X-keys (like this one: http://xkeys.com/xkeys/xk60.php) on Linux.

The XK-60 mostly works when it's plugged in, but buttons on the last four columns don't do anything. I figured out that this is because of how the events get coded in the input system. Button events from the XK-60's generic event device are marked as type EV_LED, and the event code seems to represent the button's column on the device, starting at 10 for the leftmost column.

Since LED_MAX is set to 0x0f, only the first six columns of buttons can report events, and the remaining columns set their code higher than LED_MAX, causing the input system to drop those events.

I patched my kernel to increase LED_MAX and INPUT_DEVICE_ID_LED_MAX to 0x20, and after that all of the XK-60's buttons worked.

Would it be acceptable to make this change upstream, or should this problem be solved a different way (e.g., tweaking the events so that they're EV_KEY instead of EV_LED, though I wouldn't want them to autorepeat)?

Thanks!
-lars

--
lars r. damerow :: button pusher :: pixar animation studios

https://keybase.io/ldamerow
F29F 160D B23C 3237 1BA3 FCD5 4E13 C775 36B3 ABCA
