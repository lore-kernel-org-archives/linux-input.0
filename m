Return-Path: <linux-input-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A852C433E9
	for <linux-input@archiver.kernel.org>; Sun,  7 Feb 2021 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4F4464E02
	for <linux-input@archiver.kernel.org>; Sun,  7 Feb 2021 12:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbhBGMi5 (ORCPT <rfc822;linux-input@archiver.kernel.org>);
        Sun, 7 Feb 2021 07:38:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51905 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229717AbhBGMi5 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 7 Feb 2021 07:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612701451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ELvHiaBlhKLzgE9HSBpMDYMf36fcWhvvt5qxg4NkYR0=;
        b=Q6f7YwANZ3JDl1WcNsdVWVSDFAZK1XgQp9w5D0NUiM3vS1hiGigxEJfqokesfgAb+Oy++l
        qnH3MKU/2XZcFRSZXyKI8L9QoKCBMoXjMtUP5T8p+A0Tup1WIVQiHWFkLhoMFZYQpAy4r5
        X02/2kChWChKHrICDkjmzSsF+Rxh0EM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-9IqLBAhqNwiVsl4_nOIWSw-1; Sun, 07 Feb 2021 07:37:27 -0500
X-MC-Unique: 9IqLBAhqNwiVsl4_nOIWSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4556F80197A;
        Sun,  7 Feb 2021 12:37:26 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 37D7019D9D;
        Sun,  7 Feb 2021 12:37:24 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Pearson <mpearson@lenovo.com>,
        Bastien Nocera <hadess@hadess.net>
Subject: [PATCH 2/2] iio: documentation: Document accelerometer label use
Date:   Sun,  7 Feb 2021 13:37:20 +0100
Message-Id: <20210207123720.8357-2-hdegoede@redhat.com>
In-Reply-To: <20210207123720.8357-1-hdegoede@redhat.com>
References: <20210207123720.8357-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-input.vger.kernel.org>
X-Mailing-List: linux-input@vger.kernel.org

Some 2-in-1 laptops / convertibles with 360° (yoga-style) hinges,
have 2 accelerometers, 1 in their base and 1 in their display.

In many cases the kernel can detect the location of each accelerometer
based on e.g. information from the ACPI tables.

It is important for userspace to know the location of the 2 accelerometers.
Rather then adding a new sysfs-attribute for this we can relay this
information to userspace by using standardized label strings for this.
This mirrors how this is done for proximity sensors.

This commit documents 2 new standardized label strings for this purpose:
"accel-base"
"accel-display"

Note the "base" and "display" suffixes were chosen to match the values
used for the systemd/udev hwdb.d/60-sensor.hwdb file's ACCEL_LOCATION
property.

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Mark Pearson <mpearson@lenovo.com>
Cc: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index f2f090f8bd2f..a39a1c25488e 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -74,6 +74,13 @@ Description:
 		calculated by firmware from other sensor readings, rather then
 		being a raw sensor reading.
 
+		For accelerometers used in 2-in-1s with 360° (yoga-style) hinges,
+		which have an accelerometer in both their base and their display,
+		the following standardized labels are used:
+
+		* "accel-base"
+		* "accel-display"
+
 What:		/sys/bus/iio/devices/iio:deviceX/current_timestamp_clock
 KernelVersion:	4.5
 Contact:	linux-iio@vger.kernel.org
-- 
2.30.0

