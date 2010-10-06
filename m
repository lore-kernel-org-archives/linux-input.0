From: Trilok Soni <tsoni@codeaurora.org>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Wed, 06 Oct 2010 14:02:11 +0530
Message-ID: <4CAC340B.90207@codeaurora.org>
References: <33A307AF30D7BF4F811B1568FE7A9B180460D32FE2@EXDCVYMBSTM006.EQ1STM.local> <20101005174106.GA21399@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:58128 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932184Ab0JFIcR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Oct 2010 04:32:17 -0400
In-Reply-To: <20101005174106.GA21399@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Sundar R IYER <sundar.iyer@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-pm@lists.osdl.org

Hi Sundar,

On 10/5/2010 11:11 PM, Dmitry Torokhov wrote:
> Hi Sundar,
> 
> On Tue, Oct 05, 2010 at 06:54:42PM +0200, Sundar R IYER wrote:
>> Hi Dmitry,
>>
>> Meego folks have a requirement for dynamic sysfs switches
>> for input drivers. I saw a patch from Samu (Nokia) for the same but which
>> lost its way out.  Here is a small modified patch set for the SKE
>> driver *only* which completes this requirement and hence a question for
>> you. (The idea is only a sysfs implemention; its not yet synced in with the
>> mainline code)
>>
>> Would you be okay to accept a stand-alone patch like the below for all the
>> input drivers that we would be pushing in or do you have some comments
>> or improvements suggested to be folded in the original patch set from Nokia,
>> so that it can get through into the generic tree?
> 
> I am not the biggest fan of such solution and I would prefer having this
> facility on a more generic level, maybe tied in with a special for of PM
> (something like user-controlled)?  Then most of the devices would simply
> reuse existing suspend/resume hooks without the need to add more and
> more pretty much duplicate code.

I agree with Dmitry. Meego people or you should explain the real end-to-end
usecase first. Why it can't fit anywhere else?

We should not fill in features very specific to userspace frameworks. I see lately
lot of Android and Meego specific bits into TS and Keypad drivers from many folks.

---Trilok Soni

-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
