Return-Path: <linux-input-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9788C64ED8
	for <linux-input@archiver.kernel.org>; Sat, 25 Feb 2023 01:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjBYBWV (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 24 Feb 2023 20:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBYBWU (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Feb 2023 20:22:20 -0500
Received: from endrift.com (endrift.com [173.255.198.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7CEF6EA3
        for <linux-input@vger.kernel.org>; Fri, 24 Feb 2023 17:22:19 -0800 (PST)
Received: from nebulosa.vulpes.eutheria.net (unknown [50.47.218.115])
        by endrift.com (Postfix) with ESMTPSA id 9FF9EA161;
        Fri, 24 Feb 2023 17:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=endrift.com; s=2020;
        t=1677288139; bh=YLJGlSBxOZ+AUp9+xjG5Fh386JZ0UF6mc+haLU7UKng=;
        h=From:To:Cc:Subject:Date:From;
        b=q+Lvtdg6pJk1MIuv4W7mzKi765GEmk7Dhl/8CbwVdizIiRin67hfr3QOKgScBaaAl
         54oHJ0G2uPWBVTd+6HnjDHKUZ3mtQGGkxCUi+fdbIuibsaj6HXmUzBFh3QllT8vRSP
         r+bflNkjzsZP4Z1/BTi8g2N/0OtrpC3tqUWqc8S1o5uPZDUO2hkQLloq0FY2nf8wPJ
         BNNI2ONmxag7TV1ni9E/zepffN+uzvORKR70+SyhF5gCObQSODSSp7lbS13H993Odm
         yfqDJnOnexe6p1bpYLMrFbM5jU5a0WOTti5Q4Lhr1lDDR9y3EIRXyhGMFtNMY0Oebw
         e5XxZkZWEfwEg==
From:   Vicki Pfau <vi@endrift.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org
Cc:     Pavel Rojtberg <rojtberg@gmail.com>, Vicki Pfau <vi@endrift.com>
Subject: [PATCH 0/3] Input: xpad - Additional controller support
Date:   Fri, 24 Feb 2023 17:21:45 -0800
Message-Id: <20230225012147.276489-1-vi@endrift.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This series adds support for a handful of third-party controllers in addition
to some minor code cleanup.

The approach to the Xbox 360 controller support added in this series (in the
first patch) is different than an approach used in the separate downstream that
Pavel Rojtberg (CC'd) uses, which is based on a whitelist. Since the first
packet in that downstream approach is sent unconditionally on the Windows
driver, this eschews the whitelist. Please take note that this also replaces
the need for the whitelist for the two controllers mentioned in that downstream
approach, and as such should be considered to conflict with the approach that
patch takes.

Vicki Pfau (3):
  Input: xpad - fix support for some third-party controllers
  Input: xpad - remove unused field in VID/PID table
  Input: xpad - Add VID for Turtle Beach controllers

 drivers/input/joystick/xpad.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

-- 
2.39.2

