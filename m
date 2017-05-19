From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 0/1 4.12 REGRESSION fix] input: axp20x-pek: Only check for "INTCFD9" ACPI device on Cherry Trail devices
Date: Fri, 19 May 2017 16:06:10 +0200
Message-ID: <20170519140611.31697-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56586 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754308AbdESOGO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 19 May 2017 10:06:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Hi Dmitry,

The "Input: axp20x-pek - do not register input device on some systems"
patch merged into 4.12-rc1, causes a regression where the power-button
no longer works on Bay Trail devices, this patch fixes this, can you
please que it up for merging into 4.12 ?

Regards,

Hans
