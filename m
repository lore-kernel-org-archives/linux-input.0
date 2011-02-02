From: Thomas Chou <thomas@wytron.com.tw>
Subject: Re: [PATCH v2] altera_ps2: Add devicetree support
Date: Wed, 02 Feb 2011 19:48:58 +0800
Message-ID: <4D4944AA.5040900@wytron.com.tw>
References: <20110117220415.GB17963@angua.secretlab.ca> <1295848693-28472-1-git-send-email-thomas@wytron.com.tw> <20110202043121.GF29148@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from www.wytron.com.tw ([211.75.82.101]:60369 "EHLO
	www.wytron.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753016Ab1BBLsZ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 2 Feb 2011 06:48:25 -0500
In-Reply-To: <20110202043121.GF29148@angua.secretlab.ca>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, nios2-dev@sopc.et.ntust.edu.tw, linux-input@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Walter Goossens <waltergoossens@home.nl>

On 02/02/2011 12:31 PM, Grant Likely wrote:
>> +static const struct of_device_id altera_ps2_match[] = {
>> +	{ .compatible = "altr,ps2-1.0", },
>
> I thought I had seen 'altera' instead of an abbreviation being used in
> a previous patch.  I don't care much whether 'altr' or 'altera' is
> used, but I'd like to know that there is consensus from the Altera
> users so that all the drivers use the same prefix.
>

We had discussed on nios2-dev mailing list, and decided to use 'altr' as 
Walter suggested that it saves space.

About the documentation on dts binding, shall we have a single 
altera.txt to describe all Altera related binding, and opencores.txt to 
describe all OpenCores binding? Or separate file for each core in its 
driver class?

- Thomas
