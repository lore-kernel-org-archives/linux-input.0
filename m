From: "M G" <lists.mg@googlemail.com>
Subject: xpad - led/rumble completely disables controller
Date: Fri, 21 Mar 2008 18:52:58 +0100
Message-ID: <74d457500803211052l1beada9by3a72a240a3602dfe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_14507_21092229.1206121978542"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.181]:50938 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760338AbYCURxB (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 21 Mar 2008 13:53:01 -0400
Received: by py-out-1112.google.com with SMTP id u52so2127971pyb.10
        for <linux-input@vger.kernel.org>; Fri, 21 Mar 2008 10:52:59 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

------=_Part_14507_21092229.1206121978542
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi, I'm trying to use my Xbox360 Controller with the xpad driver. But
as soon as the led status is set (i.e. right after pluging it in) it
becomes completely unresponsive. If I comment out the led-setting code
in xpad.c the controller works but only until a rumble effect is
played, then it will become unresponsive again.

I have found that this does not occur if transfer_buffer_length is set
to the exact value, 3 for the led and 8 for rumble.

------=_Part_14507_21092229.1206121978542
Content-Type: text/x-diff; name=xpad-transferlength.patch
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fe31rwzf0
Content-Disposition: attachment; filename=xpad-transferlength.patch

LS0tIGEveHBhZC5jCTIwMDgtMDMtMjEgMTY6Mzk6NTguMDAwMDAwMDAwICswMTAwCisrKyBiL3hw
YWQuYwkyMDA4LTAzLTIxIDE2OjM4OjQxLjAwMDAwMDAwMCArMDEwMApAQCAtNDY5LDYgKzQ2OSw3
IEBACiAJCXhwYWQtPm9kYXRhWzVdID0gMHgwMDsKIAkJeHBhZC0+b2RhdGFbNl0gPSAweDAwOwog
CQl4cGFkLT5vZGF0YVs3XSA9IDB4MDA7CisJCXhwYWQtPmlycV9vdXQtPnRyYW5zZmVyX2J1ZmZl
cl9sZW5ndGggPSA4OwogCQl1c2Jfc3VibWl0X3VyYih4cGFkLT5pcnFfb3V0LCBHRlBfS0VSTkVM
KTsKIAl9CiAKQEAgLTUwMiw2ICs1MDMsNyBAQAogCQl4cGFkLT5vZGF0YVswXSA9IDB4MDE7CiAJ
CXhwYWQtPm9kYXRhWzFdID0gMHgwMzsKIAkJeHBhZC0+b2RhdGFbMl0gPSBjb21tYW5kOworCQl4
cGFkLT5pcnFfb3V0LT50cmFuc2Zlcl9idWZmZXJfbGVuZ3RoID0gMzsKIAkJdXNiX3N1Ym1pdF91
cmIoeHBhZC0+aXJxX291dCwgR0ZQX0tFUk5FTCk7CiAJCW11dGV4X3VubG9jaygmeHBhZC0+b2Rh
dGFfbXV0ZXgpOwogCX0K
------=_Part_14507_21092229.1206121978542--
