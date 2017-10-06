From: Masaki Ota <012nexus@gmail.com>
Subject: [PATCH]Support new Alps HID Touchpad device
Date: Fri,  6 Oct 2017 10:16:54 +0900
Message-ID: <20171006011701.3761-1-masaki.ota@jp.alps.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:37681 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdJFBRI (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 5 Oct 2017 21:17:08 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, masaki.ota@jp.alps.com

I have modified the Patch.
About __maybe_unused annotation, it was specified by Benjamin in previous review.
So I added this annotation.
Best Regards,
Masaki OTa
