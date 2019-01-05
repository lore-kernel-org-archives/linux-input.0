From: Donghoon Han <nazgul33@gmail.com>
Subject: [PATCH 0/2] input: rotary-encoder: Support key events
Date: Sun,  6 Jan 2019 05:26:57 +0900
Message-ID: <20190105202659.20198-1-nazgul33@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Mack <daniel@caiaq.de>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patchset supports generating EV_KEY, instead of EV_REL.

An example could be a volume knob, with key events:
 - KEY_VOLUMEDOWN / KEY_VOLUMEUP

[tested on imx6q platform,  full period, half period]

Donghoon Han (2):
    Input: rotary_encoder - Support key events
    Input: rotaty-encoder - Add DT binding document

 Documentation/devicetree/bindings/input/rotary-encoder.txt | 12 ++++++++++++
 drivers/input/misc/rotary_encoder.c                        | 23 +++++++++++++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)
