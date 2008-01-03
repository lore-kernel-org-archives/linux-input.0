From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [RFC, PATCH] horizontal mouse wheel in mousedrv
Date: Thu, 3 Jan 2008 11:25:21 -0500
Message-ID: <d120d5000801030825s5d87c2eflc712979e587d4d6a@mail.gmail.com>
References: <20071225164921.16bccae3@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:55956 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbYACQZX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Jan 2008 11:25:23 -0500
Received: by nf-out-0910.google.com with SMTP id g13so403250nfb.21
        for <linux-input@vger.kernel.org>; Thu, 03 Jan 2008 08:25:22 -0800 (PST)
In-Reply-To: <20071225164921.16bccae3@poseidon.drzeus.cx>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: linux-input@vger.kernel.org

Hi Pierre,

On Dec 25, 2007 10:49 AM, Pierre Ossman <drzeus-list@drzeus.cx> wrote:
> From: Pierre Ossman <drzeus@drzeus.cx>
>
> Support the horizontal wheel present on many mice via the
> /dev/input/mice device by using the somewhat odd protocol extension
> of sending double wheel movements for the extra wheel.
>
> This is of course a rather error prone protocol extension, but it is
> found in some hardware and works well enough in practice. It is also
> the only horizontal wheel protocol supported by Xorg's mouse driver.
>

I'd rather not change the legacy mousedev driver. The extension is
rather non-standard and there is no telling what applications might
break. Please use evdev driver, it should support horizontal scrolling
AFAIK.

-- 
Dmitry
