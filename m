From: Sebastian Schmidt <yath@yath.de>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 16:53:58 +0100
Message-ID: <20171230155358.GE23284@marax.lan.yath.de>
References: <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
 <20171230095705.GA1861@marax.lan.yath.de>
 <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
 <20171230141138.GA23284@marax.lan.yath.de>
 <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
 <20171230144040.GB23284@marax.lan.yath.de>
 <20171230150235.GA19890@kroah.com>
 <4eeea63f-3131-0571-26e4-0f645dd3bc62@canonical.com>
 <20171230152616.GA26378@kroah.com>
 <0eb65344-d160-bb14-723a-1d06ac3e1b33@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from karr.yath.de ([144.76.4.50]:48150 "EHLO karr.yath.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750931AbdL3PyG (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 10:54:06 -0500
Content-Disposition: inline
In-Reply-To: <0eb65344-d160-bb14-723a-1d06ac3e1b33@canonical.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Ma <aaron.ma@canonical.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

On Sat, Dec 30, 2017 at 11:46:53PM +0800, Aaron Ma wrote:
> Without my commit the trackpoint is identified to "generic PS/2 mouse",
> some features like the scroll mode (middle button and trackpoint) can
> not work.

Actually, this used to work even prior to your patch for me. So we
apparently have different types of Trackpoint.
