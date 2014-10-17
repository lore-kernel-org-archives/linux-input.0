From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/1] input: Expose states of gpio keypad
Date: Fri, 17 Oct 2014 09:22:06 -0700
Message-ID: <20141017162206.GA37325@dtor-ws>
References: <1413540646-8455-1-git-send-email-clark.li86@gmail.com>
 <1413540646-8455-2-git-send-email-clark.li86@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:36775 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751289AbaJQQWK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 17 Oct 2014 12:22:10 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so1040270pde.22
        for <linux-input@vger.kernel.org>; Fri, 17 Oct 2014 09:22:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1413540646-8455-2-git-send-email-clark.li86@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Clark Li <clark.li86@gmail.com>
Cc: linux-input@vger.kernel.org

Hi Clark,

On Fri, Oct 17, 2014 at 08:40:46PM +1030, Clark Li wrote:
> Allow user to poll the gpio keypad states in sysfs

The justification for the change is missing from the description.
Anyway, all this data is accessible through /dev/input/eventX, so Id;
rather not add new driver-specific interface for that.

Thanks.

-- 
Dmitry
