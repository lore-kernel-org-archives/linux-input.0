From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: [PATCH v5 0/3] Input: Cypress TTSP device driver
Date: Sat,  8 Oct 2011 20:37:57 +0200
Message-ID: <1318099080-26227-1-git-send-email-martinez.javier@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:59929 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753243Ab1JHSiS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 8 Oct 2011 14:38:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Cypress TrueTouch(tm) Standard Product controllers are found in
a wide range of embedded devices. This patch-set adds support for a
variety of TTSP controllers.

The original author of the driver is Kevin McNeely <kev@cypress.com>

Since the hardware is capable of tracking identifiable contacts and the
original driver used multi-touch protocol type A (stateless), I've added
multi-touch protocol type B (stateful) support.

The driver is composed of a core driver that process the data sent by
the contacts (fingers) and two bus specific interface modules (I2C and SPI).

This is a fifth version of the driver that fixes issues called out by
Dmitry Torokhov, Henrik Rydberg and Mohan Pallaka and Kevin McNeely.

The patchset is composed of the patches:

[PATCH v5 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch screen support
[PATCH v5 2/3] Input: cyttsp - add support for Cypress TTSP touchscreen I2C bus interface
[PATCH v5 3/3] Input: cyttsp - add support for Cypress TTSP touchscreen SPI bus interface
