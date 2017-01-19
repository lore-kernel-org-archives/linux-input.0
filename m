From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 00/33] Input: Automated coccinelle cleanup
Date: Wed, 18 Jan 2017 21:04:01 -0800
Message-ID: <2226a8e4-6d44-a50e-c3ca-03311e79c6a7@roeck-us.net>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484790156.9538.18.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:57451 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751123AbdASFE1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 19 Jan 2017 00:04:27 -0500
In-Reply-To: <1484790156.9538.18.camel@perches.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Joe Perches <joe@perches.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On 01/18/2017 05:42 PM, Joe Perches wrote:
> On Wed, 2017-01-18 at 09:46 -0800, Guenter Roeck wrote:
>> The conversion was done automatically with coccinelle using several semantic
>> patches. The semantic patches and the scripts used to generate this commit
>> log are available at https://github.com/groeck/coccinelle-patches.
>
> It'd be better to include the script in this 0/n patch
> so that if github entry changes, the 0/n patch is useful.
>

For this set it would have been possible, though even the rules used here add
up to more than 1,000 lines. The underlying larger set (the one I am using
to generate devm transformations) currently has ~5,000 lines of coccinelle rules.
Are you sure you want to see that in an e-mail ? It might make more sense if I
add the reference SHA from the repository.

Thanks,
Guenter

