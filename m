From: "Dmitriy Vasil'ev" <tech@digiton.ru>
Subject: Re: rotary encoder
Date: Wed, 30 Jun 2010 13:33:25 +0400
Message-ID: <30BA0A72AA534DE289E9DA5963938449@tech>
References: <20100617101021.GB17833@buzzloop.caiaq.de> <B221BAA24375436992F7587DF15BB812@tech> <20100617112135.GC17833@buzzloop.caiaq.de> <B111F158EBCF48779A16E4EF5FAA2F84@tech> <20100617113725.GD17833@buzzloop.caiaq.de> <1E284238E08046EFA4038129CEA2527F@tech> <20100617120005.GF17833@buzzloop.caiaq.de> <20100628182225.GB7427@core.coreip.homeip.net> <20100628183229.GI2698@buzzloop.caiaq.de> <6F142F21F5134B03BDACDD706E7BCA3C@tech> <20100630084001.GE4154@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33895 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755252Ab0F3Jde (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 05:33:34 -0400
Received: by bwz1 with SMTP id 1so252463bwz.19
        for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 02:33:32 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

> the separate gpio/irq for press button is
> better handled as a separate input device by gpio_keys driver.
> 
> Thanks.
> 
> -- 
> Dmitry

Small note:

if you use two separate drivers for rotary encoder and it's button,
you must work with two device nodes in user space.
If user space driver working with one device node, this more usable.


