From: Jean Delvare <khali@linux-fr.org>
Subject: Accelerometer drivers in drivers/hwmon
Date: Sat, 25 Sep 2010 13:23:30 +0200
Message-ID: <20100925132330.4ee5e6a7@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zone0.gcu-squad.org ([212.85.147.21]:12001 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756556Ab0IYLXi (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Sep 2010 07:23:38 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Takashi Iwai <tiwai@suse.de>, Jonathan Cameron <jic23@cam.ac.uk>

Hi Dmitry,

I would like to kick the following 5 drivers out of drivers/hwmon: ams,
hdaps, hp_accel, lis3lv02d and applesmc. These are primarily
accelerometer devices, so the drivers do not belong to hwmon.

ams, hdaps, hp_accel and lis3lv02d don't even register a hwmon device.
They are pure accelerometer drivers as far as I can see. Would you take
them in drivers/input/misc?

applesmc is more complex, it's a multifunction device. Maybe it would
better go to drivers/macintosh, where the other thermal management
drivers for mac machines live.

If you don't want hdaps and hp_accel, they might also fit under
drivers/platform/x86. There are quite a few laptop-specific drivers
living there already.

If nobody wants these drivers, drivers/misc is yet another option. I'm
open to suggestions. Virtually anything which moves these drivers
outside of drivers/hwmon will make me happy.

Thanks,
-- 
Jean Delvare
