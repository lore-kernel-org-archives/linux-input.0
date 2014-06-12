From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 0/4] Input: atmel_mxt_ts - make it work on Tegra
Date: Thu, 12 Jun 2014 11:37:37 -0600
Message-ID: <5399E561.7020102@wwwdotorg.org>
References: <1399414392-32572-1-git-send-email-swarren@wwwdotorg.org> <CANLzEkv8To0gWWYBF3JjRDqt+1xGUhQiYJJUwovVhBDEMW569Q@mail.gmail.com> <536963A0.4060506@wwwdotorg.org> <536BAA5A.1010809@itdev.co.uk> <536BB3C9.8070908@wwwdotorg.org> <536BDFFD.4080009@itdev.co.uk> <537128D0.3060005@wwwdotorg.org> <53763B06.7020100@itdev.co.uk> <53763F95.6000609@wwwdotorg.org> <537B8087.1040306@itdev.co.uk> <53989D30.1000605@wwwdotorg.org> <53998E12.8050408@itdev.co.uk> <5399DF76.8020108@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:58191 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752850AbaFLRhk (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 Jun 2014 13:37:40 -0400
In-Reply-To: <5399DF76.8020108@wwwdotorg.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benson Leung <bleung@chromium.org>, Yufeng Shen <miletus@chromium.org>, Daniel Kurtz <djkurtz@chromium.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Stephen Warren <swarren@nvidia.com>, "Bowens, Alan" <Alan.Bowens@atmel.com>

On 06/12/2014 11:12 AM, Stephen Warren wrote:
...
> One bug I see is that the mouse doesn't seem to release when I drag it
> (either through double clicking and holding on the second click, or by a
> two-finger drag). Is that a known issue?

Let me refine the issue: It's nothing to do with drags, but rather any
time I push the touchpad hard to physically press the mouse button,
there's no release event.

"Soft" taps of the touchpad work fine, for single, double, or even
triple clicks:

(single soft click)
> Event: time 1402594144.964326, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
> Event: time 1402594144.964326, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
...
...
> Event: time 1402594145.026351, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 0
> Event: time 1402594145.026351, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 0

However, "hard" pushes that physically depress the touchpad and activate
the physical button don't generate release events, so clicks and drags
never end.

Single hard click:

> Event: time 1402594196.593745, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 1
> Event: time 1402594196.593745, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 1
...
> Event: time 1402594196.614456, type 1 (EV_KEY), code 272 (BTN_LEFT), value 1
...
> Event: time 1402594196.946386, type 1 (EV_KEY), code 330 (BTN_TOUCH), value 0
> Event: time 1402594196.946386, type 1 (EV_KEY), code 325 (BTN_TOOL_FINGER), value 0

(BTN_LEFT value 0 not sent)

Perhaps commit "Input: atmel_mxt_ts - Set pointer emulation on
touchpads" is incomplete? However, without that applied, neither soft
nor hard click generate any kind of mouse button events, just BTN_TOUCH
which X doesn't seem to interpret as a mouse click.
