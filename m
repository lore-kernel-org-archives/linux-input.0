From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 0/3] input / dt-bindings: Unify defining of evdev codes
Date: Sat, 12 Sep 2015 15:26:09 +0200
Message-ID: <1442064372-3030-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43792 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751117AbbILN0P (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 12 Sep 2015 09:26:15 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

Hi All,

Here is a patch-set to unify the defining of evdev codes between
uapi/linux/input.h and dt-bindings/input/input.h by using a single
shared file, rather then manually keeping things in sync.

The third patch is mainly included as an example using some new / extra
evcodes this makes available in dts files.

Assuming everyone involved likes this, I believe it is best for the
first 2 patches to be both merged to Dmitry's input tree, as the second
patch depends on the first one.

Regards,

Hans
