From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [v1.1,3/3] modify raydium firmware update rule
Date: Fri, 8 Jul 2016 11:52:37 -0700
Message-ID: <20160708185237.GC28589@dtor-ws>
References: <1467909578-43578-1-git-send-email-jeffrey.lin@rad-ic.com>
 <1467988739-44544-1-git-send-email-jeffrey.lin@rad-ic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36750 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755400AbcGHSwk (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Jul 2016 14:52:40 -0400
Content-Disposition: inline
In-Reply-To: <1467988739-44544-1-git-send-email-jeffrey.lin@rad-ic.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "jeffrey.lin" <yajohn@gmail.com>
Cc: rydberg@euromail.se, groeck@chromium.org, robh@kernel.org, jeffrey.lin@rad-ic.com, ealin.chiu@rad-ic.com, jason.yeh@rad-ic.com, KP.li@rad-ic.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Jeffrey,

On Fri, Jul 08, 2016 at 07:38:59AM -0700, jeffrey.lin wrote:
> Hi dmitry:
> >> modify raydium touch firmware update rule.
> 
> >Why? You need to explain why you are proposing a change (but as I
> >mentioned I see no reason for using custom file names for firmware. Have
> >userspace adjust name as needed by the driver.
> 
> >Thanks.
> 
> Just want to easy to do firmware update version control in the factory. If do this,
> factory do not easy update wrong version.

Just have your factory image rename firmware to canonical name before
initiating update. There is no need to encumber kernel code with this.

Thanks.

-- 
Dmitry
