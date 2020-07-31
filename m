Return-Path: <SRS0=R+4h=BK=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18B6C433E0
	for <linux-input@archiver.kernel.org>; Fri, 31 Jul 2020 22:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A1122B3F
	for <linux-input@archiver.kernel.org>; Fri, 31 Jul 2020 22:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="J8gGLVro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGaWqj (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Fri, 31 Jul 2020 18:46:39 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:48271 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgGaWqi (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Fri, 31 Jul 2020 18:46:38 -0400
Date:   Fri, 31 Jul 2020 22:36:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1596235010;
        bh=jOpCThSd4zWFLr8rUsalKKueJOq+gXIB/lUGVFH8X7E=;
        h=Date:To:From:Reply-To:Subject:From;
        b=J8gGLVroyMELyjskaOqt0mP3TbXAhWwdb1W2q2Qng3XROXR+YyebrRW+TFoXd6pHT
         r+ioKrRotSatCkr8QEKBGVKHyqudcuLn8r6WVqWxFlmE1MGJQwaEnygkCm/Jh2RJmC
         SgEdX+FgzrQ06eyUr9HiHTnOSX/eXN37h0W7/cCk=
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From:   =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Reply-To: =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH 2/2] Documentation/ABI/hid-multitouch: add description for {surface,button}_switch sysfs attributes
Message-ID: <x9Al963GDBPgGb1TfOxsddmqRVUvJ6C6D6VfNkA6YFiRd_6n9cMOdbfpds63rwANYhzdKCSPG5QVpKsKc96CqP1suNhXrJOrwsosvf2j9QU=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

This commit adds description for the {surface,button}_switch sysfs
attributes that are exported by the hid-multitouch driver, and that
may be used to enable/disable certain parts of a touch device.

Signed-off-by: Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.com>
---
 .../ABI/testing/sysfs-driver-hid-multitouch     | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-hid-multitouch b/Docume=
ntation/ABI/testing/sysfs-driver-hid-multitouch
index f79839d1af37..10c8d427232d 100644
--- a/Documentation/ABI/testing/sysfs-driver-hid-multitouch
+++ b/Documentation/ABI/testing/sysfs-driver-hid-multitouch
@@ -7,3 +7,20 @@ Description:=09The integer value of this attribute corresp=
onds to the
 =09=09MT_QUIRKS_* in hid-multitouch.c).
 =09=09When written this attribute change on the fly the quirks, then
 =09=09the protocol to handle the device.
+
+What:=09=09/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/surface_switch
+Date:=09=09July 2020
+Contact:=09linux-input@vger.kernel.org
+Description:=09The integer value of this attribute corresponds to the stat=
e of
+=09=09the device's surface switch. It is 0 if the the surface switch
+=09=09is off, meaning no surface events are reported; otherwise it
+=09=09is 1. Writing to this attribute changes the state of the switch.
+
+
+What:=09=09/sys/bus/usb/devices/<busnum>-<devnum>:<config num>.<interface =
num>/<hid-bus>:<vendor-id>:<product-id>.<num>/button_switch
+Date:=09=09July 2020
+Contact:=09linux-input@vger.kernel.org
+Description:=09The integer value of this attribute corresponds to the stat=
e of
+=09=09the device's button switch. It is 0 if the the button switch
+=09=09is off, meaning no button events are reported; otherwise it
+=09=09is 1. Writing to this attribute changes the state of the switch.
--
2.27.0


