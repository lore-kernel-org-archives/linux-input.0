From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 0/2] HID: allocation neatening and code size reduction
Date: Wed,  1 Mar 2017 11:19:08 -0800
Message-ID: <cover.1488395879.git.joe@perches.com>
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Benjamin Tissoires <benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Jiri Kosina <jikos-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?q?Bruno=20Pr=C3=A9mont?= <bonbons-ud5FBsm0p/xEiooADzr8i9i2O/JbrIOy@public.gmane.org>, Stefan Achatz <erazor_de-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Srinivas Pandruvada <srinivas.pandruvada-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

Joe Perches (2):
  HID: Use krealloc
  HID: Remove unnecessary OOM messages

 drivers/hid/hid-a4tech.c          |  4 +---
 drivers/hid/hid-apple.c           |  4 +---
 drivers/hid/hid-asus.c            |  5 +----
 drivers/hid/hid-core.c            | 24 +++++++++++-------------
 drivers/hid/hid-lenovo.c          |  7 ++-----
 drivers/hid/hid-lg.c              |  5 ++---
 drivers/hid/hid-lg4ff.c           |  4 +---
 drivers/hid/hid-logitech-dj.c     | 12 +++---------
 drivers/hid/hid-magicmouse.c      |  4 +---
 drivers/hid/hid-multitouch.c      |  9 +++------
 drivers/hid/hid-ntrig.c           |  4 +---
 drivers/hid/hid-picolcd_core.c    |  1 -
 drivers/hid/hid-picolcd_leds.c    |  1 -
 drivers/hid/hid-prodikeys.c       |  5 +----
 drivers/hid/hid-rmi.c             |  4 +---
 drivers/hid/hid-roccat-arvo.c     |  5 ++---
 drivers/hid/hid-roccat-isku.c     |  5 ++---
 drivers/hid/hid-roccat-koneplus.c |  5 ++---
 drivers/hid/hid-roccat-konepure.c |  5 ++---
 drivers/hid/hid-roccat-kovaplus.c |  5 ++---
 drivers/hid/hid-roccat-lua.c      |  5 ++---
 drivers/hid/hid-roccat-pyra.c     |  5 ++---
 drivers/hid/hid-roccat-ryos.c     |  5 ++---
 drivers/hid/hid-roccat-savu.c     |  5 ++---
 drivers/hid/hid-saitek.c          |  4 +---
 drivers/hid/hid-sensor-hub.c      |  6 +-----
 drivers/hid/hid-sony.c            |  1 -
 27 files changed, 49 insertions(+), 100 deletions(-)

-- 
2.10.0.rc2.1.g053435c
