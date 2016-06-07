From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v7 0/4] i2c-smbus: add support for HOST NOTIFY
Date: Tue, 7 Jun 2016 16:01:45 +0200
Message-ID: <20160607140145.GA19237@mail.corp.redhat.com>
References: <1464688985-19102-1-git-send-email-benjamin.tissoires@redhat.com>
 <20160605071325.GB2722@katana>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160605071325.GB2722@katana>
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Corey Minyard <minyard@acm.org>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Duggan <aduggan@synaptics.com>, Christopher Heiny <cheiny@synaptics.com>, linux-i2c@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Wolfram,

On Jun 05 2016 or thereabouts, Wolfram Sang wrote:
> Hi Benjamin,
> 
> > this is mostly a resubmission of the v6 with the acks, tested-by and few typos
> > here and there.
> 
> I actually reviewed v6 but got an NMI so writing the mails fell through
> the cracks :( Sorry about that! Good news is that the code is fine from
> my point of view, some documentation updates I'd request. After updating
> those, I will pick up the core patches right away. Note that while the

Great, many thanks!
The documentation fixes look simple enough to do. However, I just
realized a conflict in the i801 which requires tests (in the resume
call).

> i801 patch looks good to me, I need Jean's review here. There are other
> patches pending for i801, that needs to be coordinated by him.

OK. I'll try to fetch those pending patches on patchwork and see how the
merge would behave.

Cheers,
Benjamin

> 
> Thanks,
> 
>    Wolfram
> 
