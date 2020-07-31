Return-Path: <SRS0=R+4h=BK=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F263C433DF
	for <linux-input@archiver.kernel.org>; Fri, 31 Jul 2020 22:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C34EC206D4
	for <linux-input@archiver.kernel.org>; Fri, 31 Jul 2020 22:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="TFs0ddSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgGaWgW (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:36:22 -0400
Received: from mail-40141.protonmail.ch ([185.70.40.141]:43185 "EHLO
        mail-40141.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGaWgW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Jul 2020 18:36:22 -0400
Date:   Fri, 31 Jul 2020 22:36:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1596234980;
        bh=o2WFTR9PkqpBRE8lf9X1az6u7gsotwLsP6RzSC71dvU=;
        h=Date:To:From:Reply-To:Subject:From;
        b=TFs0ddSntbN6eYT9bjAOliBAvLeMu8Eo8eks6gPsvrv3UVPci5eQw51La+QHJoT3I
         4gKirpg9DDEpPyRi2ZnSqr7TFYKA2QXApt/1ics13oasPcs5fKC76NpQIA2MDarxO7
         AwK/8NjMNw5B01QhwE3aQ5cZrEOQ6Lzh1ENkjs7Y=
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH 0/2] HID: multitouch: export {surface,button}_switch to sysfs
Message-ID: <4uCCZfPhwQ6XuvdMGOD_7rJkHzD8UxooQCZStEWb3mn-VY6CD58V3rRCfK-vhK3rnQDWGe4_1c2ZGG0KZJs-XsBhR-ImT47Yj9fmScrVq6I=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This patch series introduces two new sysfs attributes
for devices handled by the hid-multitouch driver:
- surface_switch
- button_switch.
Rationale in the commit messages.
Furthermore, the ABI documentation is extended.

Barnab=C3=A1s P=C5=91cze (2):
  HID: multitouch: export {surface,button}_switch to sysfs
  Documentation/ABI/hid-multitouch: add description for
    {surface,button}_switch sysfs attributes

 .../ABI/testing/sysfs-driver-hid-multitouch   | 17 ++++
 drivers/hid/hid-multitouch.c                  | 96 +++++++++++++++++--
 2 files changed, 103 insertions(+), 10 deletions(-)

--
2.27.0

