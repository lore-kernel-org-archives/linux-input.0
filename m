From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 3/3] ARM: DTS: da850: add DT node for tps6507x-ts
Date: Thu, 7 Apr 2016 15:06:14 +0530
Message-ID: <57062A0E.6070501@ti.com>
References: <1454308130-12452-1-git-send-email-sushaanth.s@ti.com>
 <1454308130-12452-5-git-send-email-sushaanth.s@ti.com>
 <56C474EF.5040006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:39973 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753931AbcDGJiJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 7 Apr 2016 05:38:09 -0400
In-Reply-To: <56C474EF.5040006@ti.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sushaanth Srirangapathi <sushaanth.s@ti.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Joe Perches <joe@perches.com>, Javier Martinez Canillas <javier@osg.samsung.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org

On Wednesday 17 February 2016 06:56 PM, Sekhar Nori wrote:
> On Monday 01 February 2016 11:58 AM, Sushaanth Srirangapathi wrote:
>> add tps6507x touchscreen device tree node information to
>> DA850 EVM
>>
>> Signed-off-by: Sushaanth Srirangapathi <sushaanth.s@ti.com>
> 
> Acked-by: Sekhar Nori <nsekhar@ti.com>
> 
> I can queue 3/3 once driver changes are accepted (let me know about that
> because I am not copied on this series).

This missed v4.6 merge window. So it should probably be resent for v4.7
after rebasing to v4.6-rc1

Thanks,
Sekhar
