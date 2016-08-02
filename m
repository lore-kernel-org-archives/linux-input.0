From: <mika.penttila@nextfour.com>
Subject: [PATCH v6 0/2] Input: SiS 9200 family I2C touchscreen controller driver
Date: Tue, 2 Aug 2016 12:52:29 +0300
Message-ID: <1470131552-13401-1-git-send-email-mika.penttila@nextfour.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-db5eur01on0077.outbound.protection.outlook.com ([104.47.2.77]:34528
	"EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755572AbcHCCnR (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 2 Aug 2016 22:43:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: tammy_tseng@sis.com, yuger_yu@sis.com

Hi,

Here are the v6 patches for SiS 9200 I2C multitouch controller.
Cleanups, fixes and simplifications from the last review are included.

Rebased to 4.7.

Thanks,
Mika

[PATCH v6 1/2] Input: Driver for SiS-9200 family I2C touchscreen controller
[PATCH v6 2/2] Input: SiS 9200 documentation parts
