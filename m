Return-Path: <SRS0=wy78=CN=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F98C433E2
	for <linux-input@archiver.kernel.org>; Fri,  4 Sep 2020 13:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 953C020829
	for <linux-input@archiver.kernel.org>; Fri,  4 Sep 2020 13:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="vM2qvAol";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="D0/Aq/TI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgIDNsf (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:48:35 -0400
Received: from smtp115.ord1d.emailsrvr.com ([184.106.54.115]:47006 "EHLO
        smtp115.ord1d.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730637AbgIDNrI (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 4 Sep 2020 09:47:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1599225715;
        bh=+hF0AoicIpbtubwK4GqyqoxzstMgY9/dX9rfPFlOUJY=;
        h=From:To:Subject:Date:From;
        b=vM2qvAolOxWJnPodgEM39U55ySz/PRn6NqI97lhBP2fmm5JQjXTWyWtnPbnJg7hXu
         RSxp8QNwcDSK/Qa4v0ZXVfQJ1MR11cB0h7MpT2IO1Ef4nBe4bQRnNXFl+wpM6TPayo
         Vwvy/+TbCYDlPGPSVhKO3sw0T4iNcOWBuyMc7f50=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1599225715;
        bh=+hF0AoicIpbtubwK4GqyqoxzstMgY9/dX9rfPFlOUJY=;
        h=From:To:Subject:Date:From;
        b=D0/Aq/TIUeXVM/BhVSy/7NwDofDkYH/j9Y37ePtZ2u3oG85ymaOihHqxa0M3wmrGf
         Pfm7G3ahdirxcNJcJGHi1SfdchJOetwaMl38p0jgZTSAD6rmThqCtIcMr1p7LsbdIa
         tnlUdAlrxgpBuGUPJayAWTgYicWy2dSvFtsNQa00=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp23.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id E6526200AB;
        Fri,  4 Sep 2020 09:21:53 -0400 (EDT)
From:   Ian Abbott <abbotti@mev.co.uk>
To:     linux-input@vger.kernel.org
Cc:     David Rheinsberg <david.rheinsberg@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Ian Abbott <abbotti@mev.co.uk>, linux-kernel@vger.kernel.org
Subject: {PATCH 0/2] HID: wiimote: Minor change to spinlock usage
Date:   Fri,  4 Sep 2020 14:21:41 +0100
Message-Id: <20200904132143.9496-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: ee464daf-2bdc-4db4-9ef3-697c4738b247-1-1
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

[I have posted these patches previously, but that was over a year ago.
--IA]

A couple of minor changes to the wiimote core module.  They do not
change functionality of the driver:

1) HID: wiimote: make handlers[] const
2) HID: wiimote: narrow spinlock range in wiimote_hid_event()

 drivers/hid/hid-wiimote-core.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

