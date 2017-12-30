From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 16:02:35 +0100
Message-ID: <20171230150235.GA19890@kroah.com>
References: <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
 <20171228142855.GA2007@marax.lan.yath.de>
 <f1fb1612-2d16-25a4-b57e-c56a01b729c2@canonical.com>
 <20171229190529.GA2108@marax.lan.yath.de>
 <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
 <20171230095705.GA1861@marax.lan.yath.de>
 <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
 <20171230141138.GA23284@marax.lan.yath.de>
 <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
 <20171230144040.GB23284@marax.lan.yath.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:58378 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdL3PCb (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 10:02:31 -0500
Content-Disposition: inline
In-Reply-To: <20171230144040.GB23284@marax.lan.yath.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sebastian Schmidt <yath@yath.de>
Cc: Aaron Ma <aaron.ma@canonical.com>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Sat, Dec 30, 2017 at 03:40:40PM +0100, Sebastian Schmidt wrote:
> Because reverting your commit fixes the issue for me.

Great, it should be reverted then.  Care to send the patch that does the
revert to make it easy for Dmitry to apply it?

thanks,

greg k-h
