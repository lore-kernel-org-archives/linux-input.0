From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: [PATCH 3/4] Input-gameport: Add the macro "pr_fmt" for module
 "joydump"
Date: Sat, 24 Sep 2016 18:55:41 +0200
Message-ID: <a9d9e2fc-4369-ba1a-e1a1-97b0873c28ce@users.sourceforge.net>
References: <d8da8333-d83a-ca61-b887-7fd7528c63a4@users.sourceforge.net>
 <3345f7c1-b823-a819-aabf-5b4990068075@users.sourceforge.net>
 <20160924164108.GB40187@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160924164108.GB40187@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-Id: linux-input@vger.kernel.org

>> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
> 
> Why did you split it off from the patch where you attempt to use it?

I chose a special patch granularity once again.


> What good does this change do on its own?

I find that it is a preparation. - If this addition could not be accepted,
the following update step would also be discussed under an other perspective,
wouldn't it?

Regards,
Markus
