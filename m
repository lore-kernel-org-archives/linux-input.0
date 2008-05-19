From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 01/10] modpost: add support for hid
Date: Mon, 19 May 2008 15:38:46 +0200
Message-ID: <483182E6.1020709@gmail.com>
References: <1210931362-18422-1-git-send-email-jirislaby@gmail.com> <Pine.LNX.4.64.0805191535071.6718@jikos.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.180]:22350 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765415AbYESNjW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 19 May 2008 09:39:22 -0400
Received: by ik-out-1112.google.com with SMTP id c28so477164ika.5
        for <linux-input@vger.kernel.org>; Mon, 19 May 2008 06:39:20 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0805191535071.6718@jikos.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, marcel@holtmann.org, linux-kernel@vger.kernel.org, anssi.hannula@gmail.com

On 05/19/2008 03:36 PM, Jiri Kosina wrote:
> On Fri, 16 May 2008, Jiri Slaby wrote:
>> Generate aliases for hid device modules to support autoloading.

> Hi Jiri,

Hi!

> thanks for rebasing the series and fixing the comments raised during 
> review.

BTW. this patch (01) needs fix. It breaks crossbuilds. I will repost the 01 
patch in few moments.

> However, I seem to miss the 10/10 patch from this series, and it doesn't 
> seem to be even in my lkml/linux-input folder.

:) It should have been X/9. The 10th patch is only my testing patch.
