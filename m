From: Gregor Riepl <onitake@gmail.com>
Subject: Re: Chipone icn85xx support in x86 linux kernel
Date: Tue, 1 Mar 2016 11:07:52 +0100
Message-ID: <56D569F8.6070209@gmail.com>
References: <CA+V1LzoXvWO1FROO2z7tFc-0zoM_Ur+B1iiar+EJ4uvn+DWGdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36953 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752374AbcCAKIA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 1 Mar 2016 05:08:00 -0500
Received: by mail-wm0-f41.google.com with SMTP id p65so26038547wmp.0
        for <linux-input@vger.kernel.org>; Tue, 01 Mar 2016 02:07:59 -0800 (PST)
In-Reply-To: <CA+V1LzoXvWO1FROO2z7tFc-0zoM_Ur+B1iiar+EJ4uvn+DWGdQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: sergk sergk2mail <sergk.admin@gmail.com>, linux-input@vger.kernel.org

> 2) Could be icn8318 by Hans de Goede be adopted for icn85xx?

chipone_icn8318.c lacks ACPI support. It may not be difficult to add though.

The question is if both chips are sufficiently compatible.

> how it is possible to use atmel_mxt_ts module for chipone? or what is the trick?

That sounds very odd. Perhaps they share the same control interface?
Or perhaps Chipone just cloned the Atmel chips...

I'm pretty certain that a specific firmware is required for your chip, though.

