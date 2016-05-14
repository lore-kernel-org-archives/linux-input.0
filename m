From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 resend 0/4] of_touchscreen-helpers: Add support for axis inversion / swapping
Date: Sat, 14 May 2016 20:08:18 +0200
Message-ID: <1463249302-16899-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44398 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753790AbcENSI1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2016 14:08:27 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

This the third resend of this patchset (I'm not seeing it in -next, so
hence this resend), this time rebased on top of 4.6.0-rc6.

I'm assuming that so far this has just fallen through the cracks. If
there is any reason why you're not applying it please let me know
and I'll fix it.

Last time one remark you made was:

+#include <asm/types.h>

> If you are trying to add this to have s32 typedefs
> then I think it is wrong one.

I've double checked and I believe it is the right one, s32 is
typedef-ed in <asm-generic/int-ll64.h> but no-one is including
that directly.

Regards,

Hans
