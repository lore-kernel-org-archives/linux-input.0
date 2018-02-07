From: Florian Echtler <floe@butterbrot.org>
Subject: [PATCH v3] add video controls for SUR40 driver
Date: Wed,  7 Feb 2018 14:00:34 +0100
Message-ID: <1518008438-26603-1-git-send-email-floe@butterbrot.org>
Return-path: <linux-media-owner@vger.kernel.org>
Sender: linux-media-owner@vger.kernel.org
To: hverkuil@xs4all.nl, linux-media@vger.kernel.org
Cc: linux-input@vger.kernel.org, modin@yuri.at
List-Id: linux-input@vger.kernel.org

As discussed previously, here's the third iteration of my patch to add
control functions for the SUR40 driver, with (hopefully) correct handling
of default values/module parameters, using the V4L2 control framework.

Best regards, Florian
