From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: tsc2007: Don't require an interrupt to load
Date: Tue, 31 Mar 2015 14:35:18 -0700
Message-ID: <20150331213518.GC29015@dtor-ws>
References: <1959876509.19488.1427814135809.JavaMail.zimbra@xes-inc.com>
 <2054629675.19924.1427814365859.JavaMail.zimbra@xes-inc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:35339 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752661AbbCaVfX (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 31 Mar 2015 17:35:23 -0400
Received: by igcau2 with SMTP id au2so31286851igc.0
        for <linux-input@vger.kernel.org>; Tue, 31 Mar 2015 14:35:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <2054629675.19924.1427814365859.JavaMail.zimbra@xes-inc.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Aaron Sierra <asierra@xes-inc.com>
Cc: Kwangwoo Lee <kwangwoo.lee@gmail.com>, Thierry Reding <thierry.reding@avionic-design.de>, Philip Rakity <prakity@marvell.com>, linux-input@vger.kernel.org

Hi Aaron,

On Tue, Mar 31, 2015 at 10:06:05AM -0500, Aaron Sierra wrote:
> When an IRQ isn't available, poll the device based on poll_period.

What is the point in using such mode? Why would not IRQ be available?
If this is for device bringup I'd say just carry this locally.

Thanks.

-- 
Dmitry
