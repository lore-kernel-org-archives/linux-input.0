From: Przemo Firszt <przemo@firszt.eu>
Subject: Re: [PATCH v2 00/10] Input - wacom: conversion to HID driver,
 series 2
Date: Fri, 25 Jul 2014 13:42:20 +0100
Message-ID: <1406292140.2664.17.camel@fedora-lan>
References: <1406225645-32141-1-git-send-email-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406225645-32141-1-git-send-email-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Ping Cheng <pinglinux@gmail.com>, Jason Gerecke <killertofu@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Dnia 2014-07-24, czw o godzinie 14:13 -0400, Benjamin Tissoires pisze:
[..]
> Hi Przemo,
Hi Benjamin,
> Normally, this series contains all the bits of hid-wacom (except the custom
> LED/OLED API). Please tell me if I am missing anything and if you like the
> change.

I can't cleanly apply your set yet to test it, so:

Acked-by: Przemo Firszt <przemo@firszt.eu>

What's your plan about LED/OLED API? 

> Benjamin Tissoires (9):
>   Input - wacom: put a flag when the led are initialized
>   Input - wacom: enhance Wireless Receiver battery reporting
>   Input - wacom: use a uniq name for the battery device
>   Input - wacom: register an ac power supply for wireless devices
>   Input - wacom: prepare the driver to include BT devices
>   Input - wacom: handle Graphire BT tablets in wacom.ko
>   Input - wacom: handle Intuos 4 BT in wacom.ko
>   Input - wacom: add copyright note and bump version to 2.0
>   HID: remove hid-wacom Bluetooth driver
> 
> Jason Gerecke (1):
>   Input - wacom: Support up to 2048 pressure levels with ISDv4
> 
>  drivers/hid/Kconfig     |  10 +-
>  drivers/hid/Makefile    |   3 +-
>  drivers/hid/hid-core.c  |   2 -
>  drivers/hid/hid-wacom.c | 973 ------------------------------------------------
>  drivers/hid/wacom.h     |  11 +
>  drivers/hid/wacom_sys.c | 217 ++++++++++-
>  drivers/hid/wacom_wac.c | 195 +++++++++-
>  drivers/hid/wacom_wac.h |  10 +
>  8 files changed, 415 insertions(+), 1006 deletions(-)
>  delete mode 100644 drivers/hid/hid-wacom.c
> 

-- 
Kind regards,
Przemo Firszt
