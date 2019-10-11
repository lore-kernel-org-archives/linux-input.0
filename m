Return-Path: <SRS0=yoJq=YE=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,HK_RANDOM_REPLYTO,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84172C4360C
	for <linux-input@archiver.kernel.org>; Fri, 11 Oct 2019 00:58:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFD021A4C
	for <linux-input@archiver.kernel.org>; Fri, 11 Oct 2019 00:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xhN0fejB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727935AbfJKA6D (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Thu, 10 Oct 2019 20:58:03 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:62324 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbfJKA6D (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 10 Oct 2019 20:58:03 -0400
Date:   Fri, 11 Oct 2019 00:57:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1570755479;
        bh=40ozhm8SAMu/Ca+SqfeDN4mOkL6t9KC8t8EHDPyCn0c=;
        h=Date:To:From:Cc:Reply-To:Subject:Feedback-ID:From;
        b=xhN0fejB9ReFC1TO16gDyD8ibJaaqJkpZL7gqIM7KlNtHThyiEZm/2iDmzfhbgCwE
         ahnmLjTCIyc+y/Z552MqBIcL4B0FoaBWaUPQJyIGWA9ZBPAq8v3Xm1EclfMiky1sBg
         uTX1sbQlY2whmccpqSsNBDgSKPMdTgRYYvKSEPnA=
To:     "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
From:   Mazin Rezk <mnrzk@protonmail.com>
Cc:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "jikos@kernel.org" <jikos@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>,
        "mnrzk@protonmail.com" <mnrzk@protonmail.com>
Reply-To: Mazin Rezk <mnrzk@protonmail.com>
Subject: [PATCH v4 4/4] HID: logitech: Support WirelessDeviceStatus connect events
Message-ID:
 <GOPSiaLYzQc3Hi9-MvdMQOmiF6O9whCeVYWavirKdm-9VHGb37VtawOPII8FEdYAOWZYFvk3oSQcHkPGazJKZNx8DEwBO7JfrRjLjWA84UI=@protonmail.com>
Feedback-ID: 18B_FC5q-t32TXzMsVp9BgkgrdNH3iwklfW8WOrHrcxZA0WRj7JodCh5VXKxs6A3OaiHK0QNd8wi3SImKex8yQ==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org
Message-ID: <20191011005756.qguOZgKKONFdKxe3EcwVvjroJ3EgulT_O0pdppbdTfk@z>

On Saturday, October 5, 2019 9:05 PM, Mazin Rezk <mnrzk@protonmail.com> wro=
te:

> This patch makes WirelessDeviceStatus (0x1d4b) events get detected as
> connection events on devices with HIDPP_QUIRK_WIRELESS_DEVICE_STATUS.
>
> This quirk is currently an alias for HIDPP_QUIRK_CLASS_BLUETOOTH since
> the added Bluetooth devices do not support regular connect events.

No changes have been made to this patch in v4.

Signed-off-by: Mazin Rezk <mnrzk@protonmail.com>
---
 drivers/hid/hid-logitech-hidpp.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hi=
dpp.c
index 2062be922c08..b2b5fe2c74db 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -84,6 +84,7 @@ MODULE_PARM_DESC(disable_tap_to_click,

 /* Just an alias for now, may possibly be a catch-all in the future */
 #define HIDPP_QUIRK_MISSING_SHORT_REPORTS=09HIDPP_QUIRK_CLASS_BLUETOOTH
+#define HIDPP_QUIRK_WIRELESS_DEVICE_STATUS=09HIDPP_QUIRK_CLASS_BLUETOOTH

 #define HIDPP_QUIRK_DELAYED_INIT=09=09HIDPP_QUIRK_NO_HIDINPUT

@@ -406,9 +407,22 @@ static inline bool hidpp_match_error(struct hidpp_repo=
rt *question,
 =09    (answer->fap.params[0] =3D=3D question->fap.funcindex_clientid);
 }

-static inline bool hidpp_report_is_connect_event(struct hidpp_report *repo=
rt)
+#define HIDPP_PAGE_WIRELESS_DEVICE_STATUS=09=090x1d4b
+
+static inline bool hidpp_report_is_connect_event(struct hidpp_device *hidp=
p,
+=09=09=09=09=09=09 struct hidpp_report *report)
 {
-=09return (report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) &&
+=09if (hidpp->quirks & HIDPP_QUIRK_WIRELESS_DEVICE_STATUS) {
+=09=09/* If feature is invalid, skip array check */
+=09=09if (report->fap.feature_index > hidpp->feature_count)
+=09=09=09return false;
+
+=09=09return (hidpp->features[report->fap.feature_index] =3D=3D
+=09=09=09 HIDPP_PAGE_WIRELESS_DEVICE_STATUS);
+=09}
+
+=09return ((report->report_id =3D=3D REPORT_ID_HIDPP_SHORT) ||
+=09=09(hidpp->quirks & HIDPP_QUIRK_MISSING_SHORT_REPORTS)) &&
 =09=09(report->rap.sub_id =3D=3D 0x41);
 }

@@ -3157,7 +3171,7 @@ static int hidpp_raw_hidpp_event(struct hidpp_device =
*hidpp, u8 *data,
 =09=09}
 =09}

-=09if (unlikely(hidpp_report_is_connect_event(report))) {
+=09if (unlikely(hidpp_report_is_connect_event(hidpp, report))) {
 =09=09atomic_set(&hidpp->connected,
 =09=09=09=09!(report->rap.params[0] & (1 << 6)));
 =09=09if (schedule_work(&hidpp->work) =3D=3D 0)
--
2.23.0
