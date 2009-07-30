From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Asus G1S noloop exception V2
Date: Wed, 29 Jul 2009 19:45:37 -0700
Message-ID: <20090730031946.C7F1F526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0 (iPhone Mail 7A341)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.230]:43616 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750903AbZG3Cpw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jul 2009 22:45:52 -0400
Received: by rv-out-0506.google.com with SMTP id f6so322689rvb.1
        for <linux-input@vger.kernel.org>; Wed, 29 Jul 2009 19:45:50 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "Jory A. Pratt" <geekypenguin@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "akpm@linux-foundation.org" <akpm@linux-foundation.org>

Hi Jory,

On Tue, Jul 28, 2009 at 10:11:46PM -0500, Jory A. Pratt wrote:
> After further testing I realized there was a mistake in the patch. The
> DMI_BOARD_VENDOR should have been
> ASUSTeK Computer Inc. instead of ASUSTeK Computer INC. Patch has been
> fully tested with 20+ reboots and cold
> boots to ensure it is working properly.
>

Since you are saying that AUX loop detection usually works on your
laptop simply disabling it is not the best solution. Could you please
provide me with dmesg of booting with i8042.debug=1 when touchpad
is not detected?

-- 
Dmitry
