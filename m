From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 0/7] Input: pixcir_i2c_ts: Add Type-B Multi-touch and DT support
Date: Mon, 5 May 2014 12:04:31 +0300
Message-ID: <1399280678-23925-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: rydberg-Hk7bIW8heu4wFerOooGFRg@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org, dmurphy-l0cyMroinI0@public.gmane.org, mugunthanvnm-l0cyMroinI0@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi Dmitry,

This series does the following

- use devres managed resource allocations
- convert to Type-B multi touch protocol
- support upto 5 fingers with hardware supplied tracking IDs
- device tree support

Please queue this for -next (3.16). Thanks.

cheers,
-roger

Changelog:

v4:
- imporved pixcir_stop() as per Dmitry's suggestion.
- removed unnecessary input_unregister_device() from .remove().

v3:
- Rebased to 3.15-rc3
- Fixed suspend while touchscreen in use
- Fixed module removal while touchscreen in use

v2:
- Addressed review comments and re-arranged patch order

v1:
- http://article.gmane.org/gmane.linux.kernel/1616417

---
Roger Quadros (7):
  Input: pixcir_i2c_ts: Use devres managed resource allocations
  Input: pixcir_i2c_ts: Initialize interrupt mode and power mode
  Input: pixcir_i2c_ts: Get rid of pdata->attb_read_val()
  Input: pixcir_i2c_ts: Use Type-B Multi-Touch protocol
  Input: pixcir_i2c_ts: support upto 5 fingers and hardware provided
    tracking IDs
  Input: pixcir_i2c_ts: Implement wakeup from suspend
  Input: pixcir_i2c_ts: Add device tree support

 .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |  26 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/touchscreen/pixcir_i2c_ts.c          | 524 ++++++++++++++++++---
 include/linux/input/pixcir_ts.h                    |  56 ++-
 4 files changed, 546 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/pixcir_i2c_ts.txt

-- 
1.8.3.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
