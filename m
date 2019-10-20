Return-Path: <SRS0=pFeM=YN=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6231FCA9EA0
	for <linux-input@archiver.kernel.org>; Sun, 20 Oct 2019 04:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 325D421D80
	for <linux-input@archiver.kernel.org>; Sun, 20 Oct 2019 04:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Mrjla7kj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725851AbfJTEkG (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 20 Oct 2019 00:40:06 -0400
Received: from mail-40135.protonmail.ch ([185.70.40.135]:33268 "EHLO
        mail-40135.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfJTEkG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 20 Oct 2019 00:40:06 -0400
Date:   Sun, 20 Oct 2019 04:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1571546402;
        bh=JpGq6kLQ71UO60e8vaDVRt0HWQHzEZQmR/GqtUISMVI=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=Mrjla7kjQaxaKicNRDRAc/aO2N3VS6KRIXRY+8/RZeasK+DaBUz55DSL1i47SOfRg
         fkYWSEdIhdCSFTs+uybKtI4H+TA0c+MT5MsTT76QlEQUx1XKHiX8EWZzORp8FxxGoN
         7E9Pwr51r+5RD0g6sCbSUzj5JaqNpVerl/3/e/U4=
To:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>,
        "mnrzk@protonmail.com" <mnrzk@protonmail.com>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH v7 0/3] Logitech HID++ Bluetooth LE support
Message-ID: <t5LOL-A4W7aknqQdC-3TavitC94BY_Ra1qyxCZMh_nprrDNSl4UF-jYpWtaDSU-0oQ5xzRyAo9o_mvSnA78bib_p6I3ePSJnTrp3Eb0X_yg=@protonmail.com>
Feedback-ID: 18B_FC5q-t32TXzMsVp9BgkgrdNH3iwklfW8WOrHrcxZA0WRj7JodCh5VXKxs6A3OaiHK0QNd8wi3SImKex8yQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This series allows hid-logitech-hidpp to support Bluetooth LE HID++
devices. Only the MX Master is added right now but more HID++ Bluetooth LE
devices can be added once they are tested.

Thanks,
Mazin

Changes since [v6]:

        - Based patch on "HID: logitech-hidpp: rework device validation"

        - Removed the need for additional quirks

Changes since [v5]:

        - Fixed bug where added quirks would overflow an unsigned long

        - Changed the reserved quirk class bits from 0..20 to 0..15

Changes since [v4]:

        - Omitted "HID: logitech: Add feature 0x0001: FeatureSet"

        - Stored WirelessDeviceStatus feature index in hidpp_device

        - Made Bluetooth quirk class alias quirks instead of vice versa

        - Omitted non-tested devices

Changes since [v3]:

        - Renamed hidpp20_featureset_get_feature to
          hidpp20_featureset_get_feature_id.

        - Re-ordered hidpp20_featureset_get_count and
          hidpp20_featureset_get_feature_id based on their command IDs.

        - Made feature_count initialize to 0 before running
          hidpp20_get_features.

Changes since [v2]:

        - Split up the single patch into a series

Changes since [v1]:

        - Added WirelessDeviceStatus support

[v6] https://lore.kernel.org/lkml/ggKipcQplIlTFmoP3hPnrQ-7_5-C0PKGd5feFymts=
3uenIBA8zOwz47YmKheD34H1rpkguDAGdx5YbS9UqpwfjT5Ir0Lji941liLVp--QtQ=3D@proto=
nmail.com
[v5] https://lore.kernel.org/lkml/Mbf4goGxXZTfWwWtQQUke_rNf8kezpNOS9DVEVHf6=
RnnmjS1oRtMOJf4r14WfCC6GRYVs7gi0uZcIJ18Va2OJowzSbyMUGwLrl6I5fjW48o=3D@proto=
nmail.com
[v4] https://lore.kernel.org/lkml/uBbIS3nFJ1jdYNLHcqjW5wxQAwmZv0kmYEoeoPrxN=
hfzi6cHwmCOY-ewdqe7S1hNEj-p4Hd9D0_Y3PymUTdh_6WFXuMmIYUkV2xaKCPMYz0=3D@proto=
nmail.com
[v3] https://lore.kernel.org/lkml/l7xYjnA9EGfZe03FsrFhnH2aMq8qS8plWhHVvOtY_=
l4ShZ1NV6HA6hn9aI-jAzbLYUGFCIQCIKkx9z42Uoj4-AZDwBfRcAecYIn-0ZA5upE=3D@proto=
nmail.com
[v2] https://www.spinics.net/lists/linux-input/msg63467.html
[v1] https://www.spinics.net/lists/linux-input/msg63317.html

Mazin Rezk (3):
  HID: logitech-hidpp: Support translations from short to long reports
  HID: logitech-hidpp: Support MX Master (b012, b01e) over Bluetooth
  HID: logitech-hidpp: Support WirelessDeviceStatus connect events

 drivers/hid/hid-logitech-hidpp.c | 69 +++++++++++++++++++++++++++-----
 1 file changed, 59 insertions(+), 10 deletions(-)

--
2.23.0

