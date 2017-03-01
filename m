From: Avraham Shukron <avraham.shukron@gmail.com>
Subject: Re: [PATCH] hid: usbhid: usbkbd: fix checkpatch.pl issues
Date: Wed, 1 Mar 2017 21:59:31 +0200
Message-ID: <3c67c4db-9b59-82f1-9406-3dfdb2ac0a48@gmail.com>
References: <48d55583-6f2d-cfda-c6dd-0e789f4bf6f1@gmail.com>
 <20170301181628.GD30349@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33070 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdCAUg6 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 1 Mar 2017 15:36:58 -0500
In-Reply-To: <20170301181628.GD30349@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: jikos@kernel.org, benjamin.tissoires@redhat.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> 
> This kind of change is definitely not helpful. The original table was
> Nx16, you converted it to Nx14. Why do you think original table used 16
> columns?
> 
> Regardless, it's a very old driver, just let it be.
> 
> Thanks.
> 

I can make it Nx8 :)

Seriously now - I don't understand what is so wrong with checkpatch fixes?
I'm a new to kernel development, and the natural place to start is to do some
coding style fixes.
I thought fixing a driver that I actually use daily will be more satisfying.
Why driver being old is a good reason to ignore the coding style conventions?

