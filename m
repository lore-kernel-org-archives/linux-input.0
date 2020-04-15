Return-Path: <SRS0=mEKT=57=vger.kernel.org=linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11684C2BB55
	for <linux-input@archiver.kernel.org>; Wed, 15 Apr 2020 12:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E544E206D5
	for <linux-input@archiver.kernel.org>; Wed, 15 Apr 2020 12:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955285;
	bh=vkQZmf+zD+ArKC+EwWvdATC5JyOKWkdALl4rkDZGb2o=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=fpQY5ODy51F6/5KSvHrLo0gTjEdmc2stx1aGnxXdea6ss1R6tPVnIUq1sLoA3M31B
	 ZGmRXGyrbmEs0Uzz46O9tOk/iiIjqHcMKtdE9za6U2tgh7froWd8meP/927H9RSA0e
	 DchX8ybQ76FU4iSmTBTS/VMQTzYYPH2GpLqwvdJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898280AbgDOMyo (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:37274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2897211AbgDOMyi (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Wed, 15 Apr 2020 08:54:38 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A43EA206D5;
        Wed, 15 Apr 2020 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586955278;
        bh=vkQZmf+zD+ArKC+EwWvdATC5JyOKWkdALl4rkDZGb2o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IiCKWJvZJ+CWEJub7UXbp6ayjiB1HAgLK3ioO6igV41b2KjhzPC389Qox0Z6Lro13
         kMOfTzAWO/6kCzNZ2FNgsTFPrP8eFMRKu4aOWEXUItDHpH0c9hWJOlRuIpqVDQZ6a5
         vwBhDtM+zIj4yr7fI0vfkBfeZztpU0tEthsFzseE=
Date:   Wed, 15 Apr 2020 14:54:34 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Xiaojian Cao <xiaojian.cao@cn.alps.com>
cc:     Artem Borisov <dedsa2002@gmail.com>,
        Masaki Ota <masaki.ota@alpsalpine.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tetsuya Nomura <tetsuya.nomura@alpsalpine.com>,
        "vadim@cirque.com" <vadim@cirque.com>,
        "pod.alcht@cn.alps.com" <pod.alcht@cn.alps.com>
Subject: RE: [PATCH 2/2] HID: alps: Refactor axis resolution logic
In-Reply-To: <OSAPR01MB30571BF938FF882F7FB22853C8DB0@OSAPR01MB3057.jpnprd01.prod.outlook.com>
Message-ID: <nycvar.YFH.7.76.2004151447330.19713@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2004100019450.19713@cbobk.fhfr.pm> <20200409230009.22551-1-dedsa2002@gmail.com> <TYAPR01MB3871E974EFE06EBF40074470ECDE0@TYAPR01MB3871.jpnprd01.prod.outlook.com> <OSAPR01MB3057C2FB967974B98B224610C8DE0@OSAPR01MB3057.jpnprd01.prod.outlook.com>
 <TYAPR01MB387100BC93864B0A93598BFBECDE0@TYAPR01MB3871.jpnprd01.prod.outlook.com> <OSAPR01MB3057C914C96A8DCC47925502C8DE0@OSAPR01MB3057.jpnprd01.prod.outlook.com> <CAMr=fxLXT2fMdhmnfj3ZH2Ptc50nvMVU0nAvW-3fw-wAKb9rYQ@mail.gmail.com>
 <OSAPR01MB305753C5B0DD35DE7001436DC8DB0@OSAPR01MB3057.jpnprd01.prod.outlook.com> <CAMr=fxKfJBWb45PuA-1t=-ZysyUVZZmXJH=D2bSacoh2akJ0Zw@mail.gmail.com> <OSAPR01MB30571BF938FF882F7FB22853C8DB0@OSAPR01MB3057.jpnprd01.prod.outlook.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-input-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

On Wed, 15 Apr 2020, Xiaojian Cao wrote:

> Thanks for your checking, my feedbacks are as below:
>
> 1.It is about the coding style that we should not use HWID in the string 
> "HID_DEVICE_ID_ALPS_1657", there are a large number of HWIDs using this 
> touchpad. We should use the device type information in this string, such 
> as "U1_UNICORN_LEGACY".

Ok, thanks for the feedback. Based on it, I am queuing the patch below.

HID_DEVICE_ID_ALPS_1657 PID is too specific, as there are many other
ALPS hardware IDs using this particular touchpad.

Rename the identifier to HID_DEVICE_ID_ALPS_U1_UNICORN_LEGACY in order
to describe reality better.

Fixes: 640e403b1fd24 ("HID: alps: Add AUI1657 device ID")
Reported-by: Xiaojian Cao <xiaojian.cao@cn.alps.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---
 drivers/hid/hid-alps.c | 2 +-
 drivers/hid/hid-ids.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
index c2a2bd528890..b2ad319a74b9 100644
--- a/drivers/hid/hid-alps.c
+++ b/drivers/hid/hid-alps.c
@@ -802,7 +802,7 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		break;
 	case HID_DEVICE_ID_ALPS_U1_DUAL:
 	case HID_DEVICE_ID_ALPS_U1:
-	case HID_DEVICE_ID_ALPS_1657:
+	case HID_DEVICE_ID_ALPS_U1_UNICORN_LEGACY:
 		data->dev_type = U1;
 		break;
 	default:
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index e3e2fa6733fb..6eb25b9e8575 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -79,9 +79,9 @@
 #define HID_DEVICE_ID_ALPS_U1_DUAL_PTP	0x121F
 #define HID_DEVICE_ID_ALPS_U1_DUAL_3BTN_PTP	0x1220
 #define HID_DEVICE_ID_ALPS_U1		0x1215
+#define HID_DEVICE_ID_ALPS_U1_UNICORN_LEGACY         0x121E
 #define HID_DEVICE_ID_ALPS_T4_BTNLESS	0x120C
 #define HID_DEVICE_ID_ALPS_1222		0x1222
-#define HID_DEVICE_ID_ALPS_1657         0x121E
 
 #define USB_VENDOR_ID_AMI		0x046b
 #define USB_DEVICE_ID_AMI_VIRT_KEYBOARD_AND_MOUSE	0xff10


-- 
Jiri Kosina
SUSE Labs

