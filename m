From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: i8042 - add Dell Vostro 1520 and 1720 to the
	reset list
Date: Wed, 25 Nov 2009 12:17:37 -0800
Message-ID: <20091125201737.GB20732@core.coreip.homeip.net>
References: <20091124151250.03e185d1@destiny.ordissimo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:36724 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932409AbZKYURh (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 25 Nov 2009 15:17:37 -0500
Content-Disposition: inline
In-Reply-To: <20091124151250.03e185d1@destiny.ordissimo>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anisse Astier <anisse@astier.eu>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Anisse,

On Tue, Nov 24, 2009 at 03:12:50PM +0100, Anisse Astier wrote:
> These laptops may have i8042 in a bad state at very first boot or if you plug
> in a non-Dell power supply.
> Thus this patch is needed for proper keyboard and touchpad function.
> 

Could youplease explain in more detail what the "bad state" is. And what
exactly do you mean by "first boot"? Cold boot? The very first boot
after assembling? Something else?

Thanks.

-- 
Dmitry
