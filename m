From: Benson Leung <bleung@chromium.org>
Subject: [PATCH v3 0/2] Add platform data and touchpad functionality for Pixel
Date: Thu,  7 Mar 2013 19:43:32 -0800
Message-ID: <1362714214-32405-1-git-send-email-bleung@chromium.org>
References: <1362187254-9227-1-git-send-email-bleung@chromium.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <1362187254-9227-1-git-send-email-bleung@chromium.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: torvalds@linux-foundation.org, olofj@chromium.org, miletus@chromium.org, dmitry.torokhov@gmail.com, matthew.garrett@nebula.com, rydberg@euromail.se, djkurtz@chromium.org, jy0922.shim@samsung.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: bleung@chromium.org, davem@davemloft.net
List-Id: linux-input@vger.kernel.org

Add support for a touchpad variant in the atmel_mxt_ts driver.
Then, add platform data for the 224s trackpad and the 1664s touchscreen
in chromeos_laptop so that the existing version of the driver will
probe these devices correctly.

v3 : Add platform data for is_tp and key_map. Remove dependence on
     device name for tp behavior.
v2 : Minor bugfix in patch 1. Cleanup client_id from commit message.
     Make sure chromeos_laptop patch applies cleanly to v3.9-rc1

[PATCH v3 1/2] Input: atmel_mxt_ts - Support for touchpad variant
[PATCH v3 2/2] Platform: x86: chromeos_laptop : Add basic platform data
