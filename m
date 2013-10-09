From: Nikolai Kondrashov <spbnick@gmail.com>
Subject: Unit Exponent value storage
Date: Wed, 09 Oct 2013 10:53:42 +0300
Message-ID: <52550B86.9070307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:61441 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751508Ab3JIHxq (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 9 Oct 2013 03:53:46 -0400
Received: by mail-wi0-f179.google.com with SMTP id hm2so462471wib.6
        for <linux-input@vger.kernel.org>; Wed, 09 Oct 2013 00:53:45 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: hidcomments@usb.org
Cc: linux-input@vger.kernel.org

Hello,

Could you please clarify how the "Unit Exponent" global item value should be
encoded in report descriptors, according to Device Class Definition for HID
1.11?

In my understanding it is encoded similarly to the rest of the signed integer
items, i.e. two's complement 1, 2, or 4 byte integer.

However, the "HID Descriptor Tool" available on the HID page [1] encodes it as
a two's complement nibble, limited to [-8, 7] range accordingly.

Which encoding is meant by the specification?

I'm CC'ing this message to the "linux-input" maillist where I'm trying to
raise discussion about how "Unit Exponent" value should be interpreted for the
purposes of resolution calculation for HID devices in the Linux kernel.
Could you please keep this CC in your answer, so others get posted?

Thank you very much.

Sincerely,
Nikolai Kondrashov
