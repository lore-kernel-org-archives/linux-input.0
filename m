From: Anssi Hannula <anssi.hannula@gmail.com>
Subject: Re: hid-pidff bug: fails to find all required reports of saitek
 gamepad
Date: Sat, 07 Feb 2009 14:28:49 +0200
Message-ID: <498D7E81.4060007@gmail.com>
References: <78f5d6bf0901301145g591a713agc8aafa66fe27b19f@mail.gmail.com>	 <49871663.4060605@gmail.com> <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000106030803010502010902"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mta-out.inet.fi ([195.156.147.13]:42263 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752420AbZBGM2y (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 7 Feb 2009 07:28:54 -0500
In-Reply-To: <78f5d6bf0902021029g7e53f16ble27500b52f9498ba@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitriy Geels <dmitriy.geels@gmail.com>
Cc: linux-input@vger.kernel.org

This is a multi-part message in MIME format.
--------------000106030803010502010902
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dmitriy Geels wrote:
> 2009/2/2 Anssi Hannula <anssi.hannula@gmail.com>:
>>> I don't understand yet, how to fix this bug, so I'm posting this to
>>> maillist with hope on someones help.
>> The error message means that it can't find reports 0xab (create new
>> effect), 0x89 (pid block load), 0x90 (pid block free), that according to
>> your html page are in fact there.
>>
>> Could you provide the output with parameter debug=1 for hid module when
>> device is initialized? It prints the raw HID descriptor and the kernel's
>> interpretation of it.
>> (If you have the hid module built-in, you can use "echo 1 >
>> /sys/modules/hid/parameters/debug")
> 
> I'm discovering this situation, but haven't got much progress. Now I
> consider, that problem is not in hid-pidff, but somewhere deeper, like
> in hid_parse_report().
> 
> I saw strange things: report for usage 0x90 has empty field->logical
> field (should be 0x000f0090, was seen as "checking field->logical ==
> 0x00000000" earlier), that's why it's ignored. Reports, which are 0x25
> and 0x8b, are feature reports and I have no clue yet, why wrong usages
> were put into field->logical.

It is because those collections are defined as "Report collections"
instead of "Logical collections". Linux doesn't know about "Report
collections", but according to HID spec it is also a Logical collection:

"Defines a logical collection that wraps all the fields in a report. A
unique report ID will be contained in this collection. An
application can easily determine whether a device supports a
certain function. Note that any valid Report ID value can be
declared for a Report collection."

Try the attached patch, which simply changes the collection type for
such collections.

> Here is decoded hid descriptor with raw data:
> http://docs.google.com/Doc?id=dhk68r8j_2gvttgsr8
> Here is just raw data: http://docs.google.com/Doc?id=dhk68r8j_38stwrngm

-- 
Anssi Hannula

--------------000106030803010502010902
Content-Type: text/plain;
 name="hid-logical-subtypes.diff"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="hid-logical-subtypes.diff"

LS0tIGxpbnV4L2RyaXZlcnMvaGlkL2hpZC1jb3JlLmMub2xkCTIwMDktMDItMDcgMTQ6MTc6
NDkuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC9kcml2ZXJzL2hpZC9oaWQtY29yZS5jCTIw
MDktMDItMDcgMTQ6MjI6NDUuMDAwMDAwMDAwICswMjAwCkBAIC0xNDIsNiArMTQyLDEyIEBA
CiAJcGFyc2VyLT5jb2xsZWN0aW9uX3N0YWNrW3BhcnNlci0+Y29sbGVjdGlvbl9zdGFja19w
dHIrK10gPQogCQlwYXJzZXItPmRldmljZS0+bWF4Y29sbGVjdGlvbjsKIAorCS8qIFJlcG9y
dCBjb2xsZWN0aW9ucyAoMHgwMyksIE5hbWVkIEFycmF5IGNvbGxlY3Rpb25zICgweDA0KSBh
bmQgVXNhZ2UKKwkgKiBTd2l0Y2ggY29sbGVjdGlvbnMgKDB4MDUpIGFyZSBzdWJ0eXBlcyBv
ZiBsb2dpY2FsIGNvbGxlY3Rpb25zCisJICogYWNjb3JkaW5nIHRvIHRoZSBISUQgc3BlY2lm
aWNhdGlvbiAqLworCWlmICh0eXBlID49IDB4MDMgJiYgdHlwZSA8PSAweDA1KQorCQl0eXBl
ID0gSElEX0NPTExFQ1RJT05fTE9HSUNBTDsKKwogCWNvbGxlY3Rpb24gPSBwYXJzZXItPmRl
dmljZS0+Y29sbGVjdGlvbiArCiAJCXBhcnNlci0+ZGV2aWNlLT5tYXhjb2xsZWN0aW9uKys7
CiAJY29sbGVjdGlvbi0+dHlwZSA9IHR5cGU7Cg==
--------------000106030803010502010902--
