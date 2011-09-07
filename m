From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: INPUT_COMPAT_TEST
Date: Wed, 07 Sep 2011 11:40:46 -0700
Message-ID: <4E67BAAE.9060605@zytor.com>
References: <4E17504F.5070806@zytor.com> <20110708204630.GA28623@core.coreip.homeip.net> <4E178320.7050401@zytor.com> <20110708223709.GB28623@core.coreip.homeip.net> <4E179033.9050806@zytor.com> <20110709003508.GC28623@core.coreip.homeip.net> <4E180BA5.4080808@zytor.com> <20110907181641.GA5678@core.coreip.homeip.net> <4E67B652.5010406@zytor.com> <20110907183745.GB2874@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from terminus.zytor.com ([198.137.202.10]:58747 "EHLO mail.zytor.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289Ab1IGSk6 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 Sep 2011 14:40:58 -0400
In-Reply-To: <20110907183745.GB2874@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Philip Langdale <philipl@overt.org>, linux-input@vger.kernel.org, "H.J. Lu" <hjl.tools@gmail.com>

On 09/07/2011 11:37 AM, Dmitry Torokhov wrote:
>>
>> I thought there were pointers, (or longs) there too.
>>
>> In fact, we might have had the worst of both worlds here...
>
> The pointers are in ioctl paths (upload of force-feedback effects with
> custom waveforms - noone actually uses them in real life).
>

Ah... we might have lucked out then!

The proc/sysfs issue is still HUGE, however, because that affects all 
the read/write paths *indirectly*.

	-hpa
