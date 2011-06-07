From: David Jander <david@protonic.nl>
Subject: [PATCH v3 0/3] Input: gpio_keys.c: Add support for OF and I2C GPIO chips
Date: Tue,  7 Jun 2011 11:04:26 +0200
Message-ID: <1307437469-3791-1-git-send-email-david@protonic.nl>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from protonic.xs4all.nl ([213.84.116.84]:16124 "EHLO
	protonic.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752285Ab1FGJEr (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 7 Jun 2011 05:04:47 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, linux-input@vger.kernel.org

This patch series adds support for OF device-tree platform data and non-local
GPIO chips, such as I2C I/O expanders.
This is version 3 of the patches.

