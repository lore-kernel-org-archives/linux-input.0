From: Chase Douglas <chase.douglas@canonical.com>
Subject: Re: [PATCH resend] bcm5974: Add pointer and buttonpad properties
Date: Tue, 14 Feb 2012 06:40:35 +0100
Message-ID: <4F39F3D3.3020903@canonical.com>
References: <1329193448-15219-1-git-send-email-chase.douglas@canonical.com> <4F39EC1B.5070605@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41040 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab2BNFkS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Feb 2012 00:40:18 -0500
In-Reply-To: <4F39EC1B.5070605@cn.fujitsu.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: gaowanlong@cn.fujitsu.com
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org

On 02/14/2012 06:07 AM, Wanlong Gao wrote:
> On 02/14/2012 12:24 PM, Chase Douglas wrote:
> 
>> Signed-off-by: Chase Douglas <chase.douglas@canonical.com>
>> ---
>> I sent to the wrong mailing list address the first time. Sorry!
> 
> 
> Please add some comments here.
> This shouldn't be the change log of this patch.

I'm not sure what you want... The driver should expose these properties
because of the intrinsic nature of the device. Documentation for the
properties is found elsewhere.

-- Chase
