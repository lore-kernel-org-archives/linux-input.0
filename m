From: "Hemanth V" <hemanthv@ti.com>
Subject: [PATCH 0/2] [STAGING] Synaptic Touchscreen Driver
Date: Thu, 1 Apr 2010 18:46:12 +0530 (IST)
Message-ID: <37368.10.24.255.17.1270127772.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41906 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750901Ab0DANQ1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 1 Apr 2010 09:16:27 -0400
References: 
In-Reply-To: 
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gregkh@suse.de, devel@driverdev.osuosl.org
Cc: pavel@ucw.cz, linux-input@vger.kernel.org, linux-omap@vger.kernel.org

This series of 2 patches are for the synaptic
touchscreen driver in staging. This adds
support for threaded irq and some cleanup.


Hemanth V (2)

	PATCH [1/2] Remove non-standard multi touch support
	PATCH [2/2] Add threaded IRQ support

 drivers/staging/dream/synaptics_i2c_rmi.c |   26 +++++--------------------- 1 files changed, 5 insertions(+), 21 deletions(-)





