Return-Path: <SRS0=Nr1y=6I=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E86C54FD0
	for <linux-input@archiver.kernel.org>; Fri, 24 Apr 2020 12:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F3B20706
	for <linux-input@archiver.kernel.org>; Fri, 24 Apr 2020 12:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgDXMyu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-input@archiver.kernel.org>);
        Fri, 24 Apr 2020 08:54:50 -0400
Received: from mail.eclipso.de ([217.69.254.104]:36900 "EHLO mail.eclipso.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726699AbgDXMyu (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Fri, 24 Apr 2020 08:54:50 -0400
Received: from mail.eclipso.de (www1.eclipso.de [217.69.254.102])
        by mail.eclipso.de with ESMTP id 505D7EC4
        for <linux-input@vger.kernel.org>; Fri, 24 Apr 2020 14:54:47 +0200 (CEST)
Date:   Fri, 24 Apr 2020 14:54:47 +0200
MIME-Version: 1.0
Message-ID: <8e6813b24107abe9e6d79c3dd23d3e2a@mail.eclipso.de>
X-Mailer: eclipso / 7.4.0
From:   " " <denk@eclipso.email>
Subject: Re: Add a second working PNP_ID for a T470s
Reply-To: " " <denk@eclipso.email>
To:     <linux-input@vger.kernel.org>
In-Reply-To: <ff770543cd53ae818363c0fe86477965@mail.eclipso.de>
References: <ff770543cd53ae818363c0fe86477965@mail.eclipso.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

I'd like to ask, if my proposed small patch can be incorporated. Is there anything missing or to be improved?

Thanks and best
denk


--- Ursprüngliche Nachricht ---
Von: " " <denk@eclipso.email>
Datum: 30.03.2020 18:21:47
An: <linux-input@vger.kernel.org>
Betreff: Add a second working PNP_ID for a T470s

The Lenovo Thinkpad T470s I own has a different touchpad with "LEN007a"
instead of the already included PNP ID "LEN006c". However, my touchpad
seems to work well without any problems using RMI. So this patch adds the
other PNP ID.

Signed-off-by: Dennis Kadioglu <denk@eclipso.email>
---
 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c

index 4d2036209b45d..758dae8d65006 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -170,6 +170,7 @@ static const char * const smbus_pnp_ids[] = {
 	"LEN005b", /* P50 */
 	"LEN005e", /* T560 */
 	"LEN006c", /* T470s */
+	"LEN007a", /* T470s */
 	"LEN0071", /* T480 */
 	"LEN0072", /* X1 Carbon Gen 5 (2017) - Elan/ALPS trackpoint */

 	"LEN0073", /* X1 Carbon G5 (Elantech) */
---­

---

________________________________________________________
Ihre E-Mail-Postfächer sicher & zentral an einem Ort. Jetzt wechseln
und alte E-Mail-Adresse mitnehmen! https://www.eclipso.de


---

________________________________________________________
Ihre E-Mail-Postfächer sicher & zentral an einem Ort. Jetzt wechseln und alte E-Mail-Adresse mitnehmen! https://www.eclipso.de


