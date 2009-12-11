From: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Subject: Re: [PATCH] Support for 3M multitouch panel
Date: Fri, 11 Dec 2009 13:42:26 +0100
Message-ID: <20091211124226.GD17995@ibawizard.net>
References: <20091211101258.CD35D951F5@smtp.lii-enac.fr>
Reply-To: Petr =?iso-8859-2?Q?=A9tetiar?= <ynezz@true.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ibawizard.net ([82.208.49.253]:45651 "EHLO
	mengele.ibawizard.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732AbZLKMmY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 11 Dec 2009 07:42:24 -0500
Content-Disposition: inline
In-Reply-To: <20091211101258.CD35D951F5@smtp.lii-enac.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Stephane Chatty <chatty@lii-enac.fr>
Cc: linux-input@vger.kernel.org, dsuljic@mmm.com

Stephane Chatty <chatty@lii-enac.fr> [2009-12-11 11:12:58]:

> Added support for 3M multitouch panel.

Hi,

you maybe forget to run checkpatch on it :-)

WARNING: space prohibited between function name and open parenthesis '('
#131: FILE: drivers/hid/hid-3m-pct.c:122:
+static void mmm_filter_event (struct mmm_data *md, struct input_dev *input)

WARNING: space prohibited between function name and open parenthesis '('
#195: FILE: drivers/hid/hid-3m-pct.c:186:
+static int mmm_event (struct hid_device *hid, struct hid_field *field,

ERROR: code indent should use tabs where possible
#196: FILE: drivers/hid/hid-3m-pct.c:187:
+^I^I                        struct hid_usage *usage, __s32 value)$

ERROR: code indent should use tabs where possible
#199: FILE: drivers/hid/hid-3m-pct.c:190:
+        /* Strangely, this function can be called before$

ERROR: code indent should use tabs where possible
#202: FILE: drivers/hid/hid-3m-pct.c:193:
+        if (hid->claimed & HID_CLAIMED_INPUT) {$

WARNING: space prohibited between function name and open parenthesis '('
#227: FILE: drivers/hid/hid-3m-pct.c:218:
+                       mmm_filter_event (md, input);

ERROR: code indent should use tabs where possible
#233: FILE: drivers/hid/hid-3m-pct.c:224:
+        if (hid->claimed & HID_CLAIMED_HIDDEV && hid->hiddev_hid_event)$

ERROR: code indent should use tabs where possible
#234: FILE: drivers/hid/hid-3m-pct.c:225:
+                hid->hiddev_hid_event(hid, field, usage, value);$

WARNING: space prohibited between function name and open parenthesis '('
#256: FILE: drivers/hid/hid-3m-pct.c:247:
+               kfree (md);

total: 5 errors, 4 warnings, 328 lines checked 
