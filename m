From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH] generic GPIO driven matrix keypad
Date: Sat, 2 Aug 2008 16:22:02 +0200
Message-ID: <200808021622.02686.marek.vasut@gmail.com>
References: <200808011950.26388.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.186]:52726 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751003AbYHBOTB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 2 Aug 2008 10:19:01 -0400
Received: by fk-out-0910.google.com with SMTP id 18so1231855fkq.5
        for <linux-input@vger.kernel.org>; Sat, 02 Aug 2008 07:18:59 -0700 (PDT)
In-Reply-To: <200808011950.26388.marek.vasut@gmail.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

Dne Friday 01 of August 2008 19:50:26 Marek Vasut napsal(a):
> Hi,
> the following patch adds the generic GPIO driven matrix keypad driver. I
> tested this on two devices I had available - palmtc and palmt3. It should
> be able to replace corgikbd.c later as well, but I dont have that device.
> And since this is platform independent driver, any chip that makes it's
> GPIOs available through gpiolib should be OK with this driver as well.
> Please consider applying.

Just to be exact, I was reported by Ian Molton, that the matrix keypad driver 
works on Toshiba e800 as well.
