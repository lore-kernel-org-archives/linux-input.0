From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v4 0/2] Add support for Broadcom iProc touchscreen
Date: Thu, 12 Mar 2015 10:45:10 -0700
Message-ID: <1426182312-6081-1-git-send-email-jonathar@broadcom.com>
References: <Jonathan Richardson <jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org

This patchset contains initial support for the touchscreen on the Broadcom
iProc family of SoCs. This driver has been validated with Cygnus and is expected
to work on other iProc family of SoCs that use the same touchscreen controller.

Changes from v3:
- Fixed typo in Kconfig.

Changes from v2:
- Misc style changes.
- Removed assumptions about interrupts generated in ISR. It now emits all
  events and then syncs if necessary.
- Removed our rotation property and replaced with the latest
  touchscreen-inverted-x/y. Also added support for the standard optional
  properties touchscreen-size-x/y and touchscreen-fuzz-x/y. Did not add support
  for inverted-x/y at this time as our touchscreen is currently only oriented
  180 degres.

Changes from v1:
- Add missing newlines to debug messages
- Use BIT macro for defines
- Fix logic in get_tsc_config to improve readability
- Get rid of unnecessary remove() function

Jonathan Richardson (2):
  Input: touchscreen-iproc: Add Broadcom iProc touchscreen driver
  Input: touchscreen-iproc: add device tree bindings

 .../input/touchscreen/brcm,iproc-touchscreen.txt   |   76 +++
 drivers/input/touchscreen/Kconfig                  |   11 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/bcm_iproc_tsc.c          |  527 ++++++++++++++++++++
 4 files changed, 615 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/brcm,iproc-touchscreen.txt
 create mode 100644 drivers/input/touchscreen/bcm_iproc_tsc.c

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
