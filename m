From: "Magnus Damm" <magnus.damm@gmail.com>
Subject: Re: [PATCH] Touch screen driver for the SuperH MigoR board V2
Date: Wed, 7 May 2008 21:14:57 +0900
Message-ID: <aec7e5c30805070514w5c983d0ai8ddc1d8e0d1ea009@mail.gmail.com>
References: <20080328095101.8825.48353.sendpatchset@rx1.opensource.se>
	 <20080402060819.GB14189@anvil.corenet.prv>
	 <aec7e5c30804040121k584a0ae5o909b48fbd970245d@mail.gmail.com>
	 <20080404120837.ZZRA012@mailhub.coreip.homeip.net>
	 <aec7e5c30804250329m5fc62921y4da1cd0f6ee6b215@mail.gmail.com>
	 <20080427050739.GA8218@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:43501 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbYEGMPF (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 May 2008 08:15:05 -0400
Received: by yw-out-2324.google.com with SMTP id 9so134946ywe.1
        for <linux-input@vger.kernel.org>; Wed, 07 May 2008 05:14:57 -0700 (PDT)
In-Reply-To: <20080427050739.GA8218@anvil.corenet.prv>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-sh@vger.kernel.org, lethal@linux-sh.org, broonie@sirena.org.uk, akpm@linux-foundation.org

Hi again Dmitry,

On Sun, Apr 27, 2008 at 2:07 PM, Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>  Almost done ;) I also wanted to start the controller only when there are
>  users for the interface, by defining ->open and ->close methods for the
>  input device. Could you please take a look at the updated patch and if
>  it still works I will aplly it.

I just tested your improved version with evtest and it works just fine. Thanks!

/ magnus
