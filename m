From: Julian Sikorski <belegdol@gmail.com>
Subject: Logitech Alto Cordless
Date: Mon, 01 Dec 2008 14:21:00 +0100
Message-ID: <4933E4BC.5090801@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.184]:15861 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751111AbYLANVE (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 1 Dec 2008 08:21:04 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1289104nfc.21
        for <linux-input@vger.kernel.org>; Mon, 01 Dec 2008 05:21:01 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

Hi,

during a discussion on fedora-devel-list, I was suggested to check if
the said keyboard is compliant with the standards before requesting
xkeyboard-config changes. The problem exists with two keys:
- Fn-F3, has MSIE logo on it, emits XF86HomePage, should emit XF86WWW
- Fn-F4, has a tune on it, emit XF86Tools, should XF86AudioMedia
This is under Fedora 10 x86_64, using evdev driver and evdev-managed
keyboard map.

Regards,
Julian
