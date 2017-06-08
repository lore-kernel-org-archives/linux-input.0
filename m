From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: Re: [PATCH] macintosh: move mac_hid driver to input/mouse.
Date: Fri, 9 Jun 2017 09:07:52 +1000
Message-ID: <20170608230752.GA4254@jelly>
References: <20170509191418.10144-1-msuchanek@suse.de>
 <20170510004327.GA32584@dtor-ws>
 <20170528114758.52b619f2@neko>
 <20170528175540.GA8094@dtor-ws>
 <20170607185351.5fcd91df@kitsune.suse.cz>
 <20170607171622.GE13116@dtor-ws>
 <20170607211737.01888f04@kitsune.suse.cz>
 <20170607231303.GB29224@jelly>
 <20170608151842.71b59dad@kitsune.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from leo.clearchain.com ([199.73.29.74]:38684 "EHLO
        mail.clearchain.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751132AbdFHXIQ (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 8 Jun 2017 19:08:16 -0400
Content-Disposition: inline
In-Reply-To: <20170608151842.71b59dad@kitsune.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Thu, Jun 08, 2017 at 03:18:42PM +0200, Michal Suchánek wrote:
> This is what evtest reports about my keyboard:
> 
> Select the device event number [0-12]: 2
> Input driver version is 1.0.1
> Input device ID: bus 0x3 vendor 0x413c product 0x2107 version 0x111
> Input device name: "DELL Dell USB Entry Keyboard"
> Supported events:
>   Event type 0 (EV_SYN)
>   Event type 1 (EV_KEY)
>     Event code 1 (KEY_ESC)
>     Event code 2 (KEY_1)
>     Event code 3 (KEY_2)
>     Event code 4 (KEY_3)
> ...
>     Event code 193 (KEY_F23)
>     Event code 194 (KEY_F24)
>     Event code 240 (KEY_UNKNOWN)
>     Event code 272 (BTN_LEFT)
>     Event code 273 (BTN_RIGHT)
>     Event code 274 (BTN_MIDDLE)
>   Event type 4 (EV_MSC)
>     Event code 4 (MSC_SCAN)
>   Event type 17 (EV_LED)
>     Event code 0 (LED_NUML) state 1
>     Event code 1 (LED_CAPSL) state 0
>     Event code 2 (LED_SCROLLL) state 0
>     Event code 3 (LED_COMPOSE) state 0
>     Event code 4 (LED_KANA) state 0
> Key repeat handling:
>   Repeat type 20 (EV_REP)
>     Repeat code 0 (REP_DELAY)
>       Value    250
>     Repeat code 1 (REP_PERIOD)
>       Value     33
> Properties:

looks like it's not tagged as ID_INPUT_MOUSE by the default udev rules
because for that we need x/y axes (either relative for real mice or absolute
ones for the VMWare USB mouse). This keyboard only has buttons though. So it
gets ID_INPUT_KEYBOARD for the keys, but no ID_INPUT_MOUSE.

Google isn't overly forthcoming on "DELL Dell USB Entry Keyboard" but the
few pictures I can find all point to a keyboard that doesn't have any
physical mouse buttons at all. Does yours have buttons? Can you post a
picture of it somewhere?

Cheers,
   Peter
