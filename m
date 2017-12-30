From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 16:26:16 +0100
Message-ID: <20171230152616.GA26378@kroah.com>
References: <f1fb1612-2d16-25a4-b57e-c56a01b729c2@canonical.com>
 <20171229190529.GA2108@marax.lan.yath.de>
 <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
 <20171230095705.GA1861@marax.lan.yath.de>
 <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
 <20171230141138.GA23284@marax.lan.yath.de>
 <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
 <20171230144040.GB23284@marax.lan.yath.de>
 <20171230150235.GA19890@kroah.com>
 <4eeea63f-3131-0571-26e4-0f645dd3bc62@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:60352 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751026AbdL3P1c (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 10:27:32 -0500
Content-Disposition: inline
In-Reply-To: <4eeea63f-3131-0571-26e4-0f645dd3bc62@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Sebastian Schmidt <yath@yath.de>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org


A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Sat, Dec 30, 2017 at 11:08:44PM +0800, Aaron Ma wrote:
> Greg, Please check my last e-mail.

Define "last" :)

> My patch will enable the synaptic trackpoint features like scroll mode
> with middle button and trackpoint stick.
> 
> Even there is a firmware issue that it can not be set speed on sysfs.

What does that mean?

> But it is not driver issue.
> We can NOT to make wrong code than facing the real issue.

Again, I can not parse this, sorry.

If reverting a patch causes the device to work properly again, it needs
to be reverted, right?  Otherwise it is a regression, and we don't like
those at all.

thanks,

greg k-h
