From: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Subject: [PATCH RFC] sh: maple: Add support for SEGA Dreamcast VMU and
 clean up maple bus driver (0/3)
Date: Wed, 28 Jan 2009 23:47:36 +0000
Message-ID: <1233186456.6734.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>, Greg KH <greg@kroah.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, dwmw2 <dwmw2@infradead.org>
Cc: linux-sh <linux-sh@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>, linux-mtd <linux-mtd@vger.kernel.org>
List-Id: linux-input@vger.kernel.org

These patches add support for the SEGA Dreamcast VMU and clean up the
maple bus driver, allowing it to support block devices and ensuring it
supports concurrent reads and writes eg no more mixing up which thread
locks and unlocks a mutex etc.

A consequential fix for the maple keyboard driver is also attached.

The VMU is added as an MTD (mapping) device. It's flash but its is also
"smart" so could have conceivably been added as a general block device
but it transpires that as well as actually being based on flash, it
displays behaviour on plugging and unplugging and on writing that make
the MTD block layer a good fit (namely the MTD block layer's insistence
on carrying on after a perceived hotplug event).

I posted an earlier set of patches in Spring 2008 and given the
difficulties with them these are posted here for review and comment
rather than as a simple request for inclusion as is.

Signed-off-by: Adrian McMenamin <adrian@mcmen.demon.co.uk>
---

