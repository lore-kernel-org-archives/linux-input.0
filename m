From: Dmitriy Geels <dmitriy.geels@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
	gamepad
Date: Mon, 2 Feb 2009 21:29:40 +0300
Message-ID: <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>
	 <49871663.4060605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.156]:20628 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758086AbZBBS3n (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Feb 2009 13:29:43 -0500
Received: by fg-out-1718.google.com with SMTP id 16so673635fgg.17
        for <linux-input@vger.kernel.org>; Mon, 02 Feb 2009 10:29:41 -0800 (PST)
In-Reply-To: <49871663.4060605@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anssi Hannula <anssi.hannula@gmail.com>, linux-input@vger.kernel.org

Hello!

2009/2/2 Anssi Hannula <anssi.hannula@gmail.com>:
>> I don't understand yet, how to fix this bug, so I'm posting this to
>> maillist with hope on someones help.
>
> The error message means that it can't find reports 0xab (create new
> effect), 0x89 (pid block load), 0x90 (pid block free), that according to
> your html page are in fact there.
>
> Could you provide the output with parameter debug=1 for hid module when
> device is initialized? It prints the raw HID descriptor and the kernel's
> interpretation of it.
> (If you have the hid module built-in, you can use "echo 1 >
> /sys/modules/hid/parameters/debug")

I'm discovering this situation, but haven't got much progress. Now I
consider, that problem is not in hid-pidff, but somewhere deeper, like
in hid_parse_report().

I saw strange things: report for usage 0x90 has empty field->logical
field (should be 0x000f0090, was seen as "checking field->logical ==
0x00000000" earlier), that's why it's ignored. Reports, which are 0x25
and 0x8b, are feature reports and I have no clue yet, why wrong usages
were put into field->logical.

Here is decoded hid descriptor with raw data:
http://docs.google.com/Doc?id=dhk68r8j_2gvttgsr8
Here is just raw data: http://docs.google.com/Doc?id=dhk68r8j_38stwrngm
