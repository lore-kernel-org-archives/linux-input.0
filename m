From: Gregor Riepl <onitake@gmail.com>
Subject: Support for additional properties in touchscreen.h
Date: Sat, 11 Nov 2017 15:34:37 +0100
Message-ID: <00f3838a-455a-574b-5a7a-c494cd39e36a@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f53.google.com ([74.125.82.53]:32779 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750918AbdKKOen (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 11 Nov 2017 09:34:43 -0500
Received: by mail-wm0-f53.google.com with SMTP id r68so8916481wmr.0
        for <linux-input@vger.kernel.org>; Sat, 11 Nov 2017 06:34:43 -0800 (PST)
Content-Language: en-GB
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Hans de Goede <j.w.r.degoede@gmail.com>

Hi,

I was discussing jitter problems with a Silead touchscreen user today.
This is a general issue that should be solved on the hardware or firmware
level, but as we don't have a way to modify either for Silead controllers, I
was thinking that there might be a way to apply interpolation in the driver.

input_set_abs_params has fuzz and flat parameters, perhaps these can be used
for that purpose? Is there a better way to do interpolation?

Would it make sense to add corresponding jitter_x and jitter_y parameters to
include/linux/input/touchscreen.h ?

Regards,
Greg
