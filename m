From: Benson Leung <bleung@chromium.org>
Subject: [PATCH v2 0/2] Add platform data and touchpad functionality for Pixel
Date: Tue,  5 Mar 2013 23:41:45 -0800
Message-ID: <1362555707-24654-1-git-send-email-bleung@chromium.org>
References: <1362187254-9227-1-git-send-email-bleung@chromium.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1362187254-9227-1-git-send-email-bleung@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: olofj@chromium.org, miletus@chromium.org, dmitry.torokhov@gmail.com, matthew.garrett@nebula.com, rydberg@euromail.se, djkurtz@chromium.org, jy0922.shim@samsung.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: bleung@chromium.org
List-Id: linux-input@vger.kernel.org

Add support for an "atmel_mxt_tp" variant in the atmel_mxt_ts.c driver.
Then, add platform data for the 224s trackpad and the 1664s touchscreen
in chromeos_laptop so that the existing version of the driver will
probe these devices correctly.

v2 : Minor bugfix in patch 1. Cleanup client_id from commit message.
     Make sure chromeos_laptop patch applies cleanly to v3.9-rc1

[PATCH v2 1/2] Input: atmel_mxt_ts - add device id for touchpad variant
[PATCH v2 2/2] Platform: x86: chromeos_laptop : Add basic platform data
