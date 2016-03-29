From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend 0/4] of_touchscreen-helpers: Add support for inverted / swapped axis
Date: Tue, 29 Mar 2016 10:29:25 +0200
Message-ID: <1459240169-11531-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58910 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455AbcC2I3h (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 29 Mar 2016 04:29:37 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, Chen-Yu Tsai <wens@csie.org>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree <devicetree@vger.kernel.org>

Hi Dmitry,

It seems that this series has fallen through the cracks *again*.

This is a resend of the resend of this set posted a while back, now rebased
on top of v4.6-rc1.

Last time one remark you made was:

+#include <asm/types.h>

> If you are trying to add this to have s32 typedefs
> then I think it is wrong one.

I've double checked and I believe it is the right one,
s32 is typedef-ed in <asm-generic/int-ll64.h> but no-one is including that
directly.

Regards,

Hans
