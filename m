From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Subject: [PATCH 0/3] input: Simplifying the rotary encoder devicetree binding
Date: Fri,  9 Oct 2015 10:46:53 -0300
Message-ID: <1444398416-3073-1-git-send-email-ezequiel@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34992 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752884AbbJINvF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 9 Oct 2015 09:51:05 -0400
Received: by qgt47 with SMTP id 47so68835559qgt.2
        for <linux-input@vger.kernel.org>; Fri, 09 Oct 2015 06:51:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <zonque@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, mark.rutland@arm.com, robh+dt@kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, ariel@vanguardiasur.com.ar, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>

Hi Dmitry,

This patchset is another attempt at supporting rotary encoders
with stable state on each output states. Previous efforts to
support this has been done by Sascha Hauer [1] and myself [2].

After some discussion we agreed to remove the current ad-hoc
bindings for each of the rotary-encoders types, and instead
introduce "one binding to rule them all".

This patchset introduces a new 'steps-per-period' property.
Such a property can be used to model the three types
of rotary-encoders.

>From the GPIO output diagram, we can see where these types
come from, and how the steps-per-period describes each
of them.

                  _____       _____       _____
                 |     |     |     |     |     |
  Channel A  ____|     |_____|     |_____|     |____

                 :  :  :  :  :  :  :  :  :  :  :  :
            __       _____       _____       _____
              |     |     |     |     |     |     |
  Channel B   |_____|     |_____|     |_____|     |__

                 :  :  :  :  :  :  :  :  :  :  :  :
  Event          a  b  c  d  a  b  c  d  a  b  c  d

                |<-------->|
                  one step, steps-per-period = 1

                |<-->|
                  one step, steps-per-period = 2

                |<>|
                  one step, steps-per-period = 4

The 'half-period' property is marked as deprecated and a
warning message is issued if it's used, although the driver
retains its old behavior.

I'm also submitting Ben Gamari's cleanup, with the commit log
slightly ammended.

Feedback welcome!

[1] http://www.spinics.net/lists/linux-input/msg28701.html
[2] http://www.spinics.net/lists/linux-input/msg27644.html

Ben Gamari (1):
  input: rotary-encoder: Use of_property_read_bool

Ezequiel Garcia (2):
  input: rotary-encoder: Introduce new 'steps-per-period' property
  input: rotary-encoder: Support 'steps-per-period' DT property

 .../devicetree/bindings/input/rotary-encoder.txt   |  9 +++
 Documentation/input/rotary-encoder.txt             |  8 +-
 drivers/input/misc/rotary_encoder.c                | 94 +++++++++++++++++++---
 include/linux/rotary_encoder.h                     |  2 +-
 4 files changed, 101 insertions(+), 12 deletions(-)

-- 
2.5.2

