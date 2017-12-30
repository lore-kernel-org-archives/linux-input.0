From: Aaron Ma <aaron.ma@canonical.com>
Subject: Re: PROBLEM: Changing speed on ThinkPad X1 Carbon 5th trackpoint
 causes "failed to enable mouse"
Date: Sat, 30 Dec 2017 23:08:44 +0800
Message-ID: <4eeea63f-3131-0571-26e4-0f645dd3bc62@canonical.com>
References: <c6427787-112c-d6f7-4f77-ae44c6aebb2f@canonical.com>
 <20171228142855.GA2007@marax.lan.yath.de>
 <f1fb1612-2d16-25a4-b57e-c56a01b729c2@canonical.com>
 <20171229190529.GA2108@marax.lan.yath.de>
 <f8795209-1b95-81a5-5fbe-f3e3fdc0d18f@canonical.com>
 <20171230095705.GA1861@marax.lan.yath.de>
 <4ca11d3d-4e7c-5bef-1811-9bc95b6e901a@canonical.com>
 <20171230141138.GA23284@marax.lan.yath.de>
 <d8770041-baf4-205e-7818-7ea477f69a29@canonical.com>
 <20171230144040.GB23284@marax.lan.yath.de> <20171230150235.GA19890@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:43195 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdL3PIu (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 30 Dec 2017 10:08:50 -0500
In-Reply-To: <20171230150235.GA19890@kroah.com>
Content-Language: en-US
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>, Sebastian Schmidt <yath@yath.de>
Cc: dmitry.torokhov@gmail.com, linux-input@vger.kernel.org

Greg, Please check my last e-mail.

My patch will enable the synaptic trackpoint features like scroll mode
with middle button and trackpoint stick.

Even there is a firmware issue that it can not be set speed on sysfs.
But it is not driver issue.
We can NOT to make wrong code than facing the real issue.

Regards,
Aaron

On 12/30/2017 11:02 PM, Greg KH wrote:
> On Sat, Dec 30, 2017 at 03:40:40PM +0100, Sebastian Schmidt wrote:
>> Because reverting your commit fixes the issue for me.
> 
> Great, it should be reverted then.  Care to send the patch that does the
> revert to make it easy for Dmitry to apply it?
> 
> thanks,
> 
> greg k-h
> 
