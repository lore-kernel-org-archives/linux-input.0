From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 03/17] serio_raw: add support for translated
	(SERIO_I8042XL) ports
Date: Sat, 10 Jan 2009 23:50:18 -0800
Message-ID: <20090110234945.ZZRA012@mailhub.coreip.homeip.net>
References: <200901092019.n09KJhLP017131@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.247]:30094 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750998AbZAKHu7 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 11 Jan 2009 02:50:59 -0500
Received: by an-out-0708.google.com with SMTP id d40so3323567and.1
        for <linux-input@vger.kernel.org>; Sat, 10 Jan 2009 23:50:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <200901092019.n09KJhLP017131@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, niels.devos@wincor-nixdorf.com

On Fri, Jan 09, 2009 at 12:19:42PM -0800, akpm@linux-foundation.org wrote:
> From: "Niels de Vos" <niels.devos@wincor-nixdorf.com>
> 
> serio_raw only binds to non-translated devices. Enable serio_raw to
> bind to normal (translated) keyboards which can have non-standard
> extensions (like POS Keyboards). With this it is possible to send
> commands to the device over /dev/serio_raw<n>.
> 

Andrew, this one has been in mainline ofr a while, please drop from mm.

Thanks.

-- 
Dmitry
