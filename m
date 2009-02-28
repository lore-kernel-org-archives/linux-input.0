From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input notifier support
Date: Sat, 28 Feb 2009 14:30:05 -0800
Message-ID: <20090228223004.GB16208@dtor-d630.eng.vmware.com>
References: <20090225044730.GA9106@july>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.246]:34060 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbZB1WaR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 Feb 2009 17:30:17 -0500
Content-Disposition: inline
In-Reply-To: <20090225044730.GA9106@july>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Kyungmin Park <kmpark@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Trilok Soni <soni.trilok@gmail.com>

Hi Kyungmin,

On Wed, Feb 25, 2009 at 01:47:30PM +0900, Kyungmin Park wrote:
> Some hardware doesn't connected with key button and led. In this case
> key should be connected with led by software. Of course each application
> can control it however it's too big burden to application programmer.
> 
> So add input notifier and then use it at other frameworks such as led.
> Of course, other input device can use this one.
> 
> Any commnets are welcome.
> 

I don't think we need to do the notifier route. It is very easy to add
another input handler in style of rfkill-input or apm-power that would
listen to events from all ungrabbed input devices and act accordingly.
Your LED trigger example should work very well if implemented as another
input handler.

Thanks.

-- 
Dmitry
