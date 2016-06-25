From: Manuel Reimer <mail+linux-input@m-reimer.de>
Subject: Re: [PATCH] Fix effect aborting in ff-memless
Date: Sat, 25 Jun 2016 14:23:44 +0200
Message-ID: <8aa55974-2d18-511d-d876-2c408307d965@m-reimer.de>
References: <c2278d36-993b-402f-dd07-635980112bbe@m-reimer.de>
 <20160620173303.GA22426@dtor-ws> <20160621032410.GA35864@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:59735 "EHLO mx1.mailbox.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751132AbcFYMXx (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 25 Jun 2016 08:23:53 -0400
In-Reply-To: <20160621032410.GA35864@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input <linux-input@vger.kernel.org>, Cameron Gutman <aicommander@gmail.com>, jikos@kernel.org

On 06/21/2016 05:24 AM, Dmitry Torokhov wrote:
> Actually, I wonder if the patch below will fix the issue you are seeing.

At first: Thank you for helping with fixing this issue.

And sorry for the late answer.

I did a complete kernel rebuild with your patch and now I can say, that 
your patch doesn't make any difference. The problem still exists.

Manuel
