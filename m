From: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH] edt_ts: EDT Touchscreen driver
Date: Thu, 15 Dec 2011 03:49:35 +0400
Message-ID: <4EE9360F.8030706@emcraft.com>
References: <1320795279-2018-1-git-send-email-yanok@emcraft.com> <4ED5F8BE.90100@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ocean.emcraft.com ([213.221.7.182]:56869 "EHLO
	ocean.emcraft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754960Ab1LNXtG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Dec 2011 18:49:06 -0500
In-Reply-To: <4ED5F8BE.90100@kernelconcepts.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Simon Budig <simon.budig@kernelconcepts.de>
Cc: linux-input@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Anatolij Gustshin <agust@denx.de>

Hi Simon,

On 30.11.2011 13:34, Simon Budig wrote:
>> Driver for touchscreen controllers found on EDT Displays. Originally
>> developed by Anatolij Gustshin.
> 
> Sorry for not noticing earlier, but I'd like to point out that there
> already is a patch for this family of touch controllers, which also
> already provides support for setting parameters and reading raw data
> from the sensor.

Great. Are you going to address the comments and resend your patch? I'd
really like to see some version of the driver accepted into the mainline.

Regards, Ilya.
