From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: Input: Cypress TTSP device driver
Date: Sat, 20 Aug 2011 00:01:49 -0400
Message-ID: <1313812912-2848-1-git-send-email-martinez.javier@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:48859 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab1HTECH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Aug 2011 00:02:07 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kevin McNeely <kev@cypress.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, Srikar <ext-srikar.1.bhavanarayana@nokia.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Cypress TrueTouch(tm) Standard Product controllers are found in
a wide range of embedded devices. This patchset adds support for a
variety of TTSP controllers.

The original author of the driver is Kevin McNeely <kev@cypress.com>

Since the hardware is capable of tracking identifiable contacts and the
original driver used multi-touch protocol type A (stateless), I've added
multi-touch protocol type B (stateful) support.

The driver is composed of a core driver that process the data sent by
the contacts (fingers) and two bus specific interface modules (I2C and SPI).

The patchset is composed of:

[PATCH 1/3] Input: cyttsp - Cypress TTSP capacitive multi-touch screen support
[PATCH 2/3] Input: cyttsp - add support for Cypress TTSP touchscreen I2C bus interface
[PATCH 3/3] Input: cyttsp - add support for Cypress TTSP touchscreen SPI bus interface
