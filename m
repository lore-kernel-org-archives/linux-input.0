From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch 1/9] input: mousedev: distinguish a moving finger from
	a tapping finger
Date: Wed, 13 May 2009 20:22:47 -0700
Message-ID: <20090514032246.GB12778@dtor-d630.eng.vmware.com>
References: <200905122102.n4CL2KWY006881@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.238]:50668 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752821AbZENDW4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 13 May 2009 23:22:56 -0400
Received: by rv-out-0506.google.com with SMTP id f9so613118rvb.1
        for <linux-input@vger.kernel.org>; Wed, 13 May 2009 20:22:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <200905122102.n4CL2KWY006881@imap1.linux-foundation.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-input@vger.kernel.org, rydberg@euromail.se

Hi Andrew,

On Tue, May 12, 2009 at 01:43:04PM -0700, akpm@linux-foundation.org wrote:
> From: Henrik Rydberg <rydberg@euromail.se>
> 
> The tap functionality of mousedev does not distinguish between a tap
> (on/off localized in time and space) and a quick move (on/off localized in
> time only).  This patch improves the tap detection by testing also for
> space locality.
> 

I will not be applying this patch. Mousedev is legacy interface and we
should not be extending it; synaptics X driver does properly handle
advanced touchpad and is included in every [major] distribution.

Thanks.

-- 
Dmitry
