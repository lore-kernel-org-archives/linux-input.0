From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH resend v2 0/1] input: goodix: Poll the 'buffer status' bit before reading
Date: Fri, 13 Oct 2017 13:19:06 +0200
Message-ID: <20171013111907.6913-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56798 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757484AbdJMLTO (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 13 Oct 2017 07:19:14 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Hi All,

Here is a resend of my v2 of Paul Cercueil's patch to fix sometimes
fingers getting stuck (seen as present while already lifted) on goodix
screens. Can someone review this please ?

As this patch seems to be sorta stuck and some users have been asking
about getting this fixed, I've done a v2 addressing Bastien's review
comments on v1.

Regards,

Hans
