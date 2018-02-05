From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH 0/5] [RFC] add video controls to SUR40 driver
Date: Mon,  5 Feb 2018 15:29:36 +0100
Message-ID: <1517840981-12280-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: linux-media@vger.kernel.org, hverkuil@xs4all.nl
Cc: linux-input@vger.kernel.org, modin@yuri.at
List-Id: linux-input@vger.kernel.org

The SUR40 (aka Pixelsense) has internal registers that expose sensor
parameters such as brightness, gain etc. This patch creates V4L2
control items and maps them to the appropriate parameters.

This is an initial submission for review, comments welcome!

Best regards, Florian
