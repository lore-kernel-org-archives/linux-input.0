From: Benson Leung <bleung@chromium.org>
Subject: [PATCH 0/4] Input: cyapa - Add firmware update feature
Date: Wed, 13 Mar 2013 16:50:47 -0700
Message-ID: <1363218651-22457-1-git-send-email-bleung@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rydberg@euromail.se, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: bleung@chromium.org, olofj@chromium.org, djkurtz@chromium.org, dudl@cypress.com
List-Id: linux-input@vger.kernel.org

Add a feature to update trackpad firmware via request_firmware to cyapa.
The last patch in the series adds sysfs attributses useful for version
and product identification that a user mode utility will need to
keep track of the current firmware on the device.

This is used today on Chromebook systems with cypress trackpads:
Samsung Series 5 550 Chromebook
Acer C7
HP Pavilion 14
Samsung Chromebook (2012, ARM version)

[PATCH 1/4] Input: cyapa - Move common initialization to cyapa_detect
[PATCH 2/4] Input: cyapa - Firmware update via request firmware
[PATCH 3/4] Input: cyapa - Allow filename to be changed in update_fw
[PATCH 4/4] Input: cyapa - Add sysfs attrs for product_id and fw_version
