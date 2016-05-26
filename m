From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH] Alps SS4 V2 support for Dell Latitude 7470
Date: Thu, 26 May 2016 10:55:11 +0200
Message-ID: <1464252914-11450-1-git-send-email-ben@smart-cactus.org>
References: <201605251801.45240@pali>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56238 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbcEZI4H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 26 May 2016 04:56:07 -0400
In-Reply-To: <201605251801.45240@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>


Hello everyone,

Here is a small patchset adding support for the Alps dualpoint device shipped
with the Dell Latitude 7470. Most of the driver support was already present as
this device speaks a variant of the SS4 V2 protocol (in particular, the variant
spoken by buttonpad devices, despite not being a buttonpad itself).

The majority of the delta here is adding missing touchstick support for the SS4
protocol.

Thanks to Masaki Ota for his help in getting this device working.

Cheers,

- Ben
