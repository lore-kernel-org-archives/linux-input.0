From: Chris Bagwell <chris@cnpbagwell.com>
Subject: Re: [PATCH 5/5] input: wacom - retrieve maximum number of contacts
Date: Sun, 14 Aug 2011 22:37:48 -0500
Message-ID: <CAGzDe_Zih_GWOPYmS74S68JNc-RkQ_-zg3+DY1+2zUmr6=Ocow@mail.gmail.com>
References: <1313194205-5098-1-git-send-email-pinglinux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-iy0-f170.google.com ([209.85.210.170]:46825 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371Ab1HODht (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 14 Aug 2011 23:37:49 -0400
Received: by iye16 with SMTP id 16so6627483iye.1
        for <linux-input@vger.kernel.org>; Sun, 14 Aug 2011 20:37:49 -0700 (PDT)
In-Reply-To: <1313194205-5098-1-git-send-email-pinglinux@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

On Fri, Aug 12, 2011 at 7:10 PM, Ping Cheng <pinglinux@gmail.com> wrote:
> Retrieve it from the HID descriptor when it is available

Were you going to use touch_max for something (since its not referenced)?

Related to Bamboo's and pressure, does this happen to report 4 touches
on the newer Bamboo's that do not support pressure?  I haven't looked
at my 0xd1 Bamboo but I suspect  either contact count is not returned
or returns 2 (or maybe 3) contacts.

I'm hoping there is a way to detect differences in touch packet format
besides resorting to a quirks list.

Chris
