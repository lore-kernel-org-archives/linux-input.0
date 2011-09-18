From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: [PATCH V3 0/3] Input: Cypress TTSP device driver
Date: Sun, 18 Sep 2011 04:01:34 +0200
Message-ID: <1316311297-12765-1-git-send-email-martinez.javier@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Cypress TrueTouch(tm) Standard Product controllers are found in
a wide range of embedded devices. This patch-set adds support for a
variety of TTSP controllers.

The original author of the driver is Kevin McNeely <kev@cypress.com>

Since the hardware is capable of tracking identifiable contacts and the
original driver used multi-touch protocol type A (stateless), I've added
multi-touch protocol type B (stateful) support.

The driver is composed of a core driver that process the data sent by
the contacts (fingers) and two bus specific interface modules (I2C and SPI).

This is a third version of the driver that fixes issues called out by
Dmitry Torokhov, Henrik Rydberg and Mohan Pallaka

The patchset is composed of the patches:

[PATCH V3 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch screen support
[PATCH V3 2/3] Input: cyttsp - add support for Cypress TTSP touchscreen I2C bus interface
[PATCH V3 3/3] Input: cyttsp - add support for Cypress TTSP touchscreen SPI bus interface
