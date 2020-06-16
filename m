Return-Path: <SRS0=d/dN=75=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C2FC433DF
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 19:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6101820B1F
	for <linux-input@archiver.kernel.org>; Tue, 16 Jun 2020 19:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=superboring.dev header.i=@superboring.dev header.b="JM2gq7ME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbgFPTGt (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgFPTGt (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 16 Jun 2020 15:06:49 -0400
Received: from mail.halogenos.org (halogenos.org [IPv6:2a02:c207:2037:5246::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018FDC061755
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2020 12:06:48 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 12E5E1500CDF;
        Tue, 16 Jun 2020 21:01:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=superboring.dev;
        s=dkim; t=1592334070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q3E2Ui1W8iVQUns1ff+8rSZE5FsvHCrbNKjbTVVQ0Xw=;
        b=JM2gq7MEt3M93AZkXZJfRuvRdsoisKzOAohuHMNLigsEjJmLArkCNfQ1OTcFWWRO4WPjcz
        iSHQQ6ProK3YoHYx/Fj6+Hrw+5NpPrvrUM6AgEaGqrp52nobN/Qt/5zV2wDk1+Gt+hqf2g
        mVIeK+C+HkIQayFKVGuQ2RpiFO0EE0Mw9C9N//tDkZNutpVGIKqPx+D4TRpIrNGwSZBXIM
        hVbFhVs0ofJaCiZskkGcYuFvDsLmtWfqJNz0PhNlib29uBQxobYdLJfr6LOI0hoYko6HDZ
        oFyx0/GH2BvESioaDnPq5AsK0HwsZpeBvxE5gwwMjY0WPcoMPCNxpTwpzA7W0A==
From:   Simao Gomes Viana <devel@superboring.dev>
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Simao Gomes Viana <devel@superboring.dev>,
        linux-input@vger.kernel.org
Subject: [PATCH 2/4] drivers: hid: code style fixes
Date:   Tue, 16 Jun 2020 21:00:42 +0200
Message-Id: <20200616190044.126928-2-devel@superboring.dev>
In-Reply-To: <20200616190044.126928-1-devel@superboring.dev>
References: <20200616190044.126928-1-devel@superboring.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Signed-off-by: Simao Gomes Viana <devel@superboring.dev>
---
 drivers/hid/hid-input.c | 99 ++++++++++++++++++++++++++++-------------
 1 file changed, 67 insertions(+), 32 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5a7282a0abbb..e70066e4c545 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -751,17 +751,17 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 	case HID_UP_LED:
 		switch (usage->hid & 0xffff) {		      /* HID-Value:                   */
-		case 0x01:  map_led (LED_NUML);     break;    /*   "Num Lock"                 */
-		case 0x02:  map_led (LED_CAPSL);    break;    /*   "Caps Lock"                */
-		case 0x03:  map_led (LED_SCROLLL);  break;    /*   "Scroll Lock"              */
-		case 0x04:  map_led (LED_COMPOSE);  break;    /*   "Compose"                  */
-		case 0x05:  map_led (LED_KANA);     break;    /*   "Kana"                     */
-		case 0x27:  map_led (LED_SLEEP);    break;    /*   "Stand-By"                 */
-		case 0x4c:  map_led (LED_SUSPEND);  break;    /*   "System Suspend"           */
-		case 0x09:  map_led (LED_MUTE);     break;    /*   "Mute"                     */
-		case 0x4b:  map_led (LED_MISC);     break;    /*   "Generic Indicator"        */
-		case 0x19:  map_led (LED_MAIL);     break;    /*   "Message Waiting"          */
-		case 0x4d:  map_led (LED_CHARGING); break;    /*   "External Power Connected" */
+		case 0x01:  map_led(LED_NUML);     break;    /*   "Num Lock"                 */
+		case 0x02:  map_led(LED_CAPSL);    break;    /*   "Caps Lock"                */
+		case 0x03:  map_led(LED_SCROLLL);  break;    /*   "Scroll Lock"              */
+		case 0x04:  map_led(LED_COMPOSE);  break;    /*   "Compose"                  */
+		case 0x05:  map_led(LED_KANA);     break;    /*   "Kana"                     */
+		case 0x27:  map_led(LED_SLEEP);    break;    /*   "Stand-By"                 */
+		case 0x4c:  map_led(LED_SUSPEND);  break;    /*   "System Suspend"           */
+		case 0x09:  map_led(LED_MUTE);     break;    /*   "Mute"                     */
+		case 0x4b:  map_led(LED_MISC);     break;    /*   "Generic Indicator"        */
+		case 0x19:  map_led(LED_MAIL);     break;    /*   "Message Waiting"          */
+		case 0x4d:  map_led(LED_CHARGING); break;    /*   "External Power Connected" */
 
 		default: goto ignore;
 		}
@@ -1066,29 +1066,61 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 	case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
 		set_bit(EV_REP, input->evbit);
 		switch (usage->hid & HID_USAGE) {
-		case 0x021: map_key_clear(KEY_PRINT);           break;
-		case 0x070: map_key_clear(KEY_HP);		break;
-		case 0x071: map_key_clear(KEY_CAMERA);		break;
-		case 0x072: map_key_clear(KEY_SOUND);		break;
-		case 0x073: map_key_clear(KEY_QUESTION);	break;
-		case 0x080: map_key_clear(KEY_EMAIL);		break;
-		case 0x081: map_key_clear(KEY_CHAT);		break;
-		case 0x082: map_key_clear(KEY_SEARCH);		break;
-		case 0x083: map_key_clear(KEY_CONNECT);	        break;
-		case 0x084: map_key_clear(KEY_FINANCE);		break;
-		case 0x085: map_key_clear(KEY_SPORT);		break;
-		case 0x086: map_key_clear(KEY_SHOP);	        break;
-		default:    goto ignore;
+		case 0x021:
+			map_key_clear(KEY_PRINT);
+			break;
+		case 0x070:
+			map_key_clear(KEY_HP);
+			break;
+		case 0x071:
+			map_key_clear(KEY_CAMERA);
+			break;
+		case 0x072:
+			map_key_clear(KEY_SOUND);
+			break;
+		case 0x073:
+			map_key_clear(KEY_QUESTION);
+			break;
+		case 0x080:
+			map_key_clear(KEY_EMAIL);
+			break;
+		case 0x081:
+			map_key_clear(KEY_CHAT);
+			break;
+		case 0x082:
+			map_key_clear(KEY_SEARCH);
+			break;
+		case 0x083:
+			map_key_clear(KEY_CONNECT);
+			break;
+		case 0x084:
+			map_key_clear(KEY_FINANCE);
+			break;
+		case 0x085:
+			map_key_clear(KEY_SPORT);
+			break;
+		case 0x086:
+			map_key_clear(KEY_SHOP);
+			break;
+		default:
+			goto ignore;
 		}
 		break;
 
 	case HID_UP_HPVENDOR2:
 		set_bit(EV_REP, input->evbit);
 		switch (usage->hid & HID_USAGE) {
-		case 0x001: map_key_clear(KEY_MICMUTE);		break;
-		case 0x003: map_key_clear(KEY_BRIGHTNESSDOWN);	break;
-		case 0x004: map_key_clear(KEY_BRIGHTNESSUP);	break;
-		default:    goto ignore;
+		case 0x001:
+			map_key_clear(KEY_MICMUTE);
+			break;
+		case 0x003:
+			map_key_clear(KEY_BRIGHTNESSDOWN);
+			break;
+		case 0x004:
+			map_key_clear(KEY_BRIGHTNESSUP);
+			break;
+		default:
+			goto ignore;
 		}
 		break;
 
@@ -1108,13 +1140,16 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 
 	case HID_UP_PID:
 		switch (usage->hid & HID_USAGE) {
-		case 0xa4: map_key_clear(BTN_DEAD);	break;
-		default: goto ignore;
+		case 0xa4:
+			map_key_clear(BTN_DEAD);
+			break;
+		default:
+			goto ignore;
 		}
 		break;
 
 	default:
-	unknown:
+unknown:
 		if (field->report_size == 1) {
 			if (field->report->type == HID_OUTPUT_REPORT) {
 				map_led(LED_MISC);
@@ -1383,7 +1418,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 	 * skip the keycode translation and only forward real events.
 	 */
 	if (!(field->flags & (HID_MAIN_ITEM_RELATIVE |
-	                      HID_MAIN_ITEM_BUFFERED_BYTE)) &&
+			      HID_MAIN_ITEM_BUFFERED_BYTE)) &&
 			      (field->flags & HID_MAIN_ITEM_VARIABLE) &&
 	    usage->usage_index < field->maxusage &&
 	    value == field->value[usage->usage_index])
-- 
2.27.0

