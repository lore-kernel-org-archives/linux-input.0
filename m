From: Benson Leung <bleung@chromium.org>
Subject: [PATCH 0/2] Add platform data and touchpad functionality for Pixel
Date: Fri,  1 Mar 2013 17:20:52 -0800
Message-ID: <1362187254-9227-1-git-send-email-bleung@chromium.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:51311 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896Ab3CBBVN (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 1 Mar 2013 20:21:13 -0500
Received: by mail-pa0-f49.google.com with SMTP id kp6so2119644pab.22
        for <linux-input@vger.kernel.org>; Fri, 01 Mar 2013 17:21:12 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: olofj@chromium.org, miletus@chromium.org, dmitry.torokhov@gmail.com, matthew.garrett@nebula.com, rydberg@euromail.se, djkurtz@chromium.org, jy0922.shim@samsung.com, wfp5p@virginia.edu, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Cc: bleung@chromium.org

Add support for an "atmel_mxt_tp" variant in the atmel_mxt_ts.c driver.
Then, add platform data for the 224s trackpad and the 1664s touchscreen
in chromeos_laptop so that the existing version of the driver will
probe these devices correctly.

[PATCH 1/2] Input: atmel_mxt_ts - add device id for touchpad variant
[PATCH 2/2] Platform: x86: chromeos_laptop : Add basic platform data
