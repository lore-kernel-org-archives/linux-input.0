From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH 1/3] input: axp20x-pek: fixes + improvements
Date: Mon, 17 Apr 2017 22:13:29 +0200
Message-ID: <20170417201332.13983-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752462AbdDQUNf (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 17 Apr 2017 16:13:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Hi Dmitry,

Here are 3 patches for the axp20x-pek driver, the first one is a
regression-fix for a patch you've already queued up for 4.12 !

The other 2 are normal improvements / fixes.

Regards,

Hans
