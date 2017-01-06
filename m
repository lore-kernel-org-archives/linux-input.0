From: David Lechner <david@lechnology.com>
Subject: [PATCH 0/3] Input: add optional enable gpio to pwm-beeper
Date: Thu,  5 Jan 2017 20:43:51 -0600
Message-ID: <1483670635-25060-1-git-send-email-david@lechnology.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from vern.gendns.com ([206.190.152.46]:56112 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754237AbdAFCn7 (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Thu, 5 Jan 2017 21:43:59 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: David Lechner <david@lechnology.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

This series adds an optional enable gpio to the pwm-beeper driver. This is for
cases when the beeper needs to be "enabled", for example, if there is an
amplifier that drives the speaker that is not always on.

David Lechner (3):
  Input: pwm-beeper: suppress error message on probe defer
  dt-bindings: Input: Add enable-gpios to pwm-beeper
  Input: pwm-beeper: add optional enable gpio

 .../devicetree/bindings/input/pwm-beeper.txt       | 11 +++++++++
 drivers/input/misc/pwm-beeper.c                    | 27 ++++++++++++++++++----
 2 files changed, 34 insertions(+), 4 deletions(-)

-- 
2.7.4

