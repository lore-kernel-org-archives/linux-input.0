From: Georgi Chorbadzhiyski <gf@unixsol.org>
Subject: Re: [PATCH] input: Add support for Rotronic silver/white handset
 in cm109 driver
Date: Tue, 01 Sep 2009 11:32:23 +0300
Message-ID: <4A9CDC17.8060207@unixsol.org>
References: <4A9ACD69.5030501@unixsol.org> <20090901021017.26A96526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ns.unixsol.org ([193.110.159.2]:40498 "EHLO ns.unixsol.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752013AbZIAIcW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Sep 2009 04:32:22 -0400
In-Reply-To: <20090901021017.26A96526EA5@mailhub.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Gimpelevich <daniel@gimpelevich.san-francisco.ca.us>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Dmitry Torokhov scribbled:
> Hi Georgi,
> 
> On Sun, Aug 30, 2009 at 10:05:13PM +0300, Georgi Chorbadzhiyski wrote:
>> The following patch adds support for yet another keymap in
>> cm109 driver. Rotronic silver/white is USB "Skype" handset
>> sold in Bulgaria and Serbia (according to Google). With this
>> cheap stuff a picture is the only way to identify what you've
>> got, so here is one:
>>    http://www.reset.bg/catalog/images/skyphoneusbbelihcek.jpg
>>
> 
> While there is nothing wrong with the patch I am hesitant to apply it.
> Any chance we could push it onto HAL or maybe have your application to
> load appropriate keymap? I know we can't do it automatically because
> vendor and product IDs are the same for all these devices... It's just
> putting every keymap into the kernel is not sustainable.

Sure, no problem.

-- 
Georgi Chorbadzhiyski
http://georgi.unixsol.org/
