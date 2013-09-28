From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [RFC/PATCH 0/1] rotary-encoder: Add new interruption handler
Date: Sat, 28 Sep 2013 15:26:37 -0300
Message-ID: <1380392798-23345-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f50.google.com ([74.125.82.50]:45075 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078Ab3I1S0i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Sep 2013 14:26:38 -0400
Received: by mail-wg0-f50.google.com with SMTP id f12so4043259wgh.5
        for <linux-input@vger.kernel.org>; Sat, 28 Sep 2013 11:26:37 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Daniel Mack <zonque@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

Some rotary-encoder devices (such as those with detents) are capable
of producing a stable event on each step. This simple patch adds support
for this case, by implementing a new interruption handler.

The handler needs only detect the direction of the turn and generate
an event according to this detection.

We encode the previous and the current state, and then use the sum of them
to decide on the direction of the turn, according to the following simple
table:

Previous state + currrent state	| Movement
==========================================
	0b1101			| clockwise
	0b0100			|   ..
	0b0010			|   ..
	0b1011			|   ..
==========================================
	0b1110			| counter-clockwise
	0b0111			|   ..
	0b0001			|   ..
	0b1000			|   ..

(The other sumed values are considered illegal)

This calculation is based on some previous work found at this blog:

  http://bildr.org/2012/08/rotary-encoder-arduino/

The result is a seemingly very robust behavior, with a truly simple
implementation, that produces an event on each turn of the device.

I don't have much experience with this rotary-encoder devices, so I'm sending
this just as an RFC/PATCH, to get some early feedback. In particular, I got a
bit puzzled by the current implementation with 'armed' and 'dis-armed'.
Maybe there's some way of using the current driver and get an event on each turn?

If this change looks more or less acceptable, I can add device-tree bindings
(which are missing from this first patch) and re-send.

Thanks!

Ezequiel Garcia (1):
  Input: rotary-encoder: Add 'stepped' irq handler

 drivers/input/misc/rotary_encoder.c | 34 ++++++++++++++++++++++++++++++++++
 include/linux/rotary_encoder.h      |  1 +
 2 files changed, 35 insertions(+)

-- 
1.8.1.5

