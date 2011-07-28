From: Javier Martinez Canillas <martinez.javier@gmail.com>
Subject: staging: Add Cypress TTSP G3 support
Date: Thu, 28 Jul 2011 12:27:39 +0200
Message-ID: <1311848862-24236-1-git-send-email-martinez.javier@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:62037 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403Ab1G1K2Z (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 28 Jul 2011 06:28:25 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
Cc: Kevin McNeely <kev@cypress.com>, devel@linuxdriverproject.org, kernel-janitors@vger.kernel.org, linux-input@vger.kernel.org, Steve Kolokowsky <syk@cypress.com>, rydberg@euromail.se, Oleg Drokin <green@linuxhacker.ru>, William Marone <wmarone@gmail.com>

This patchset adds support to Cypress (TTSP) touchscreen hardware.

The original author of this code is Kevin McNeely <kev@cypress.com>.

The patchset is divided in three patchs:

[PATCH 1/3] staging: cyttsp: Add Cypress TTSP G3 Core Driver
[PATCH 2/3] staging: cyttsp: Add Cypress TTSP G3 I2C Device Driver
[PATCH 3/3] staging: cyttsp: Add Cypress TTSP G3 SPI Device Driver

The fist one adds the core support for the TTSP touchscreen and the
other two adds communications modules for I2C and SPI buses respectively.
