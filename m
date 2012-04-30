From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH 2/2] Input: matrix_keymap - wire up device tree support
Date: Mon, 30 Apr 2012 10:00:42 -0600
Message-ID: <4F9EB72A.10403@wwwdotorg.org>
References: <20120426081909.GA2726@core.coreip.homeip.net> <4F99642E.1010305@wwwdotorg.org> <20120430041955.GC1055@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:37637 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044Ab2D3QBF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 30 Apr 2012 12:01:05 -0400
In-Reply-To: <20120430041955.GC1055@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>, devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org, Rob Herring <rob.herring@calxeda.com>, Rakesh Iyer <riyer@nvidia.com>

On 04/29/2012 10:19 PM, Dmitry Torokhov wrote:
> On Thu, Apr 26, 2012 at 09:05:18AM -0600, Stephen Warren wrote:
>> On 04/26/2012 02:19 AM, Dmitry Torokhov wrote:
>>> When platform keymap is not supplied to matrix_keypad_build_keymap()
>>> and device tree support is enabled, try locating specified property
>>> and load keymap from it. If property name is not defined, try using
>>> "linux,keymap".
>>>
>>> Based on earlier patch by Viresh Kumar <viresh.kumar@st.com>
>>
>> I think this series looks mostly OK. A few comments below.
>>
>> We don't actually have the KBC driver hooked up on any boards yet, so I
>> can't actually test this yet.
>>
>> How will the linux,fn-keymap handling work? It looks like this code is
>> allocating a keymap data structure with one additional row to represent
>> fn-not-pressed vs. fn-pressed.
> 
> No, it loads 2x rows (therefore giving you twice original keymap size).

Yes, I mean an extra row signal, so therefore twice as many rows.

>> I assume this will work without issue
>> even though the second half is not filled in. Won't this allow the
>> linux,keymap property entries to pass validation "if (row >= rows)" for
>> one more row than it should?
> 
> Maybe... I think we should revisit this when you actually have
> linux,fn-keymap. Probably will need to export matrix_keypad_parse_

Would it be better to just drop the support for the linux,fn-keymap
property, until the full support is there? That wouldn't lose any
functionality, but would avoid this potential error-checking issue.
