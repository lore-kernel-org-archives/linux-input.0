From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Problems with Wacom Intuos PT M (CTH680) on FreeBSD
Date: Tue, 21 Oct 2014 15:33:11 -0700
Message-ID: <20141021223311.GG8609@dtor-ws>
References: <54424770.9090600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:55479 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933387AbaJUWdQ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Oct 2014 18:33:16 -0400
Received: by mail-pa0-f66.google.com with SMTP id rd3so143735pab.9
        for <linux-input@vger.kernel.org>; Tue, 21 Oct 2014 15:33:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <54424770.9090600@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Denis Akiyakov <d.akiyakov@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Denis,

On Sat, Oct 18, 2014 at 05:56:48PM +0700, Denis Akiyakov wrote:
> Hello,
> 
> I'm using FreeBSD 10.1 and FreeBSD use webcamd witch contain linux
> wacom driver to provide wacom tablets support. More info here:
> http://www.selasky.org/hans_petter/video4bsd/ or
> http://www.freshports.org/multimedia/webcamd/
> 
> I've got latest version of webcamd and Wacom device CTH680, but
> device isn't working correct.

Have you tried the device with Linux instead of FreeBSD? If it works in
Linux that means that the port of linux drivers to BSD is to blame and
you need to contact its authors, otherwise we need to adjust wacom
driver in kernel for this device.

Thanks.

-- 
Dmitry
