From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: multi-input quirk and skip output reports quirk
Date: Tue, 01 Apr 2008 14:25:27 +0300
Message-ID: <47F21BA7.8030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from pne-smtpout3-sn2.hy.skanova.net ([81.228.8.111]:55030 "EHLO
	pne-smtpout3-sn2.hy.skanova.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756423AbYDALZf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Apr 2008 07:25:35 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@jikos.cz>
Cc: linux-input@vger.kernel.org

Hi!

I've encountered another multi-input device that needs the skip output
reports quirk (as it contains force feedback output reports), 0925:8866.

However, maybe we should use another approach, dropping
HID_QUIRK_SKIP_OUTPUT_REPORTS. Why not just *not* register the input
device for that report in case the report didn't contain anything that
was mapped by hidinput_configure_usage(), in hidinput_connect()?

-- 
Anssi Hannula
