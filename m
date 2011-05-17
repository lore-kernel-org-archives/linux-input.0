From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] Input: sc_keysc - only compile PM code if PM is enabled
Date: Tue, 17 May 2011 18:42:41 +0900
Message-ID: <BANLkTimFZbdot82Uq_tq4TMLfo=fAzpO9g@mail.gmail.com>
References: <20110503074002.2380.6883.stgit@hammer.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58505 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753626Ab1EQJmn (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 05:42:43 -0400
Received: by wwa36 with SMTP id 36so347307wwa.1
        for <linux-input@vger.kernel.org>; Tue, 17 May 2011 02:42:41 -0700 (PDT)
In-Reply-To: <20110503074002.2380.6883.stgit@hammer.corenet.prv>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Dmitry,

On Tue, May 3, 2011 at 4:40 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>

I just tried linux-next 20110517 with Suspend-to-RAM patches on AP4EVB
and it seems to work well.

So for these patches...
9cc7c80 Input: sh_keysc - only compile PM code if PM is enabled
12d0cef70 Input: sh_keysc - make sh_keysc_device_driver static

... feel free to add:
Acked-by: Magnus Damm <damm@opensource.se>

If it means extra work and little gain feel free to leave them as-is too.

Thanks for your help!

/ magnus
