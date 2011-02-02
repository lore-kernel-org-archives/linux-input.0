From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH v2] altera_ps2: Add devicetree support
Date: Thu, 03 Feb 2011 07:35:39 +0800
Message-ID: <4D49EA4B.9000703@wytron.com.tw>
References: <20110117220415.GB17963@angua.secretlab.ca> <1295848693-28472-1-git-send-email-thomas@wytron.com.tw> <20110202043121.GF29148@angua.secretlab.ca> <4D4944AA.5040900@wytron.com.tw> <20110202153959.GD20275@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:47596 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523Ab1BBXfA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 18:35:00 -0500
In-Reply-To: <20110202153959.GD20275@angua.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Walter Goossens <waltergoossens@home.nl>, Tobias Klauser <klto@zhaw.ch>

On 02/02/2011 11:39 PM, Grant Likely wrote:
> On Wed, Feb 02, 2011 at 07:48:58PM +0800, Thomas Chou wrote:
>> On 02/02/2011 12:31 PM, Grant Likely wrote:
>>>> +static const struct of_device_id altera_ps2_match[] = {
>>>> +	{ .compatible = "altr,ps2-1.0", },
>>>
>>> I thought I had seen 'altera' instead of an abbreviation being used in
>>> a previous patch.  I don't care much whether 'altr' or 'altera' is
>>> used, but I'd like to know that there is consensus from the Altera
>>> users so that all the drivers use the same prefix.
>>>
>>
>> We had discussed on nios2-dev mailing list, and decided to use
>> 'altr' as Walter suggested that it saves space.
>
> Is altr the stock ticker symbol?  The convention is to either use the
> stock ticker in all uppercase (although the uppercase bit hasn't been
> consistently applied), or to use the full name in lowercase.

Yes, it is the stock ticker symbol. Then we shall follow the convention, 
and change it to uppercase.

- Thomas

>
> g.
>
>

