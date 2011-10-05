From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: [PATCH v4 0/3] Input: Cypress TTSP device driver
Date: Wed,  5 Oct 2011 23:26:02 +0200
Message-ID: <1317849965-18557-1-git-send-email-martinez.javier@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:47816 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752341Ab1JEV00 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 Oct 2011 17:26:26 -0400
Received: by wwf22 with SMTP id 22so3201070wwf.1
        for <linux-input@vger.kernel.org>; Wed, 05 Oct 2011 14:26:25 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Henrik Rydberg <rydberg@euromail.se>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mohan Pallaka <mpallaka@codeaurora.org>, Kevin McNeely <kev@cypress.com>, linux-input@vger.kernel.org

Cypress TrueTouch(tm) Standard Product controllers are found in
a wide range of embedded devices. This patch-set adds support for a
variety of TTSP controllers.

The original author of the driver is Kevin McNeely <kev@cypress.com>

Since the hardware is capable of tracking identifiable contacts and the
original driver used multi-touch protocol type A (stateless), I've added
multi-touch protocol type B (stateful) support.

The driver is composed of a core driver that process the data sent by
the contacts (fingers) and two bus specific interface modules (I2C and SPI).

This is a fourth version of the driver that fixes issues called out by
Dmitry Torokhov, Henrik Rydberg and Mohan Pallaka

The patchset is composed of the patches:

[PATCH v4 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch screen support
[PATCH v4 2/3] Input: cyttsp - add support for Cypress TTSP touchscreen I2C bus interface
[PATCH v4 3/3] Input: cyttsp - add support for Cypress TTSP touchscreen SPI bus interface
