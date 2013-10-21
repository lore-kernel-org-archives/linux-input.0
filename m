From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 01/02] input: serio: use DEVICE_ATTR_RO()
Date: Mon, 21 Oct 2013 09:25:32 -0700
Message-ID: <20131021162531.GC4575@core.coreip.homeip.net>
References: <20131008010823.GA27012@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35096 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085Ab3JUQZf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 21 Oct 2013 12:25:35 -0400
Received: by mail-pd0-f169.google.com with SMTP id q10so6466853pdj.0
        for <linux-input@vger.kernel.org>; Mon, 21 Oct 2013 09:25:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20131008010823.GA27012@kroah.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-input@vger.kernel.org

Hi Greg,

On Mon, Oct 07, 2013 at 06:08:23PM -0700, Greg Kroah-Hartman wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Convert the serio sysfs fiels to use the DEVICE_ATTR_RO() macros to make
> it easier to audit the correct sysfs file permission usage.

Sorry for the delay. Frankly I am not a fan of DEVICE_ATTR macros as it
forces particular naming of the attribute structures and methods and
forces us to lose the module prefix in names. I prefer all functions and
file-scope variables have module prefix because in the absence of
language-supported namespaces this is the one thing that insulates
drivers from changes in shared headers.

Thanks.

-- 
Dmitry
