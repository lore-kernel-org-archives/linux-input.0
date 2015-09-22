From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v3 0/4] input: gpio_keys_polled: Add support for abs/rel axis
Date: Tue, 22 Sep 2015 15:23:56 +0200
Message-ID: <1442928240-2452-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49426 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932214AbbIVNYD (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 22 Sep 2015 09:24:03 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

Hi Dmitry,

This patch-series really is 2 related series:

Patch 1 + 2:

Support for abs/rel axis in gpio_keys_polled, the dt-bindings patch is
updated, the actual implementation is the same as the v2 version.

Patch 3 + 4:

Add a single header with key / btn / axis defines to be shared by input.h
and the dt-bindings headers, as requested by you. The first patch introduces
a new header for this, the second patch makes dt-bindings/input/input.h
use this new header. The second patch has been Acked by the devicetree
maintainer, and since it depends on the first one I believe that it is
best if this patch gets merged via your tree too.

Regards,

Hans


