From: Donghoon Han <nazgul33@gmail.com>
Subject: [PATCH V2 0/2] input: rotary-encoder: Support key events
Date: Tue,  8 Jan 2019 01:42:47 +0900
Message-ID: <20190107164249.2342-1-nazgul33@gmail.com>
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
 drivers/input/misc/rotary_encoder.c                        | 24 ++++++++++++++++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)
