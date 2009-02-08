From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: Re: [PATCH] sh: maple: add support for Visual Memory Card devices,
 and make consequential changes to maple input drivers - 0/3 - v5 - diff
 stat correction
Date: Sun, 08 Feb 2009 19:52:17 +0000
Message-ID: <1234122737.6736.17.camel@localhost.localdomain>
References: <1234122069.6736.8.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1234122069.6736.8.camel@localhost.localdomain>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, dwmw2 <dwmw2@infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, MTD <linux-mtd@lists.infradead.org>, linux-sh <linux-sh@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

Great start... sorry here is correct diff stat for these patches...

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---
 
 drivers/input/joystick/maplecontrol.c |    4 +-
 drivers/input/keyboard/maple_keyb.c   |   37 +-
 drivers/mtd/maps/Kconfig              |   12 +-
 drivers/mtd/maps/Makefile             |    1 +
 drivers/mtd/maps/vmu-flash.c          |  827 +++++++++++++++++++++++++++++++++
 drivers/sh/maple/maple.c              |  463 ++++++++++---------
 include/linux/maple.h                 |   62 ++-
 7 files changed, 1139 insertions(+), 267 deletions(-)

