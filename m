From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 0/6] Fixes for ALPS trackstick
Date: Wed, 14 Jan 2015 14:55:48 -0800
Message-ID: <1421276154-8689-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:59332 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753627AbbANW4H (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Jan 2015 17:56:07 -0500
Received: by mail-ie0-f175.google.com with SMTP id x19so11766884ier.6
        for <linux-input@vger.kernel.org>; Wed, 14 Jan 2015 14:56:07 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc: Yunkang Tang <yunkang.tang@cn.alps.com>, Hans de Goede <hdegoede@redhat.com>

Hi Pali,

This series try to address the issue you brought regarding trackstick
initialization on Dell Latitudes in a different way than the patches you
proposed. Basically in this series we move resetting and all detection in
alps_detect() and make sure we keep the state so alps_init() can reuse it
and not perform the detection all over again. Doing this allows us to set
up device characteristics (name, version, etc) properly from the get go
while still performing reset only once.

This is untested as I do not have any ALPS devices anymore so I'd
appreciate you giving it a spin.

Thanks!

-- 
Dmitry
