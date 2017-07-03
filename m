From: Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
Subject: [PATCHv2 0/2] Input: atmel_mxt_ts: Add reset support
Date: Mon,  3 Jul 2017 14:38:41 +0200
Message-ID: <20170703123843.19340-1-sebastian.reichel@collabora.co.uk>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nick Dyer <nick-gcszYUEDH4VrovVCs/uTlw@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Henrik Rydberg <rydberg-FFUHeuDi6mxAfugRpC6u6w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Reichel <sebastian.reichel-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

Hi,

This adds support for the reset pin of Atmel MXT.

Changes since PATCHv1:
 - Add new patch preparing for resource managed gpio
 - Use resource managed gpio
 - Wait for interrupt after reset

-- Sebastian

Sebastian Reichel (2):
  Input: atmel_mxt_ts: Use more managed resources
  Input: atmel_mxt_ts: Add support for reset line

 .../devicetree/bindings/input/atmel,maxtouch.txt   |  2 ++
 drivers/input/touchscreen/atmel_mxt_ts.c           | 42 +++++++++++++++-------
 2 files changed, 31 insertions(+), 13 deletions(-)

-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
