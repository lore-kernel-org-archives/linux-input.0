From: Trilok Soni <soni.trilok@gmail.com>
Subject: Re: [PATCH] input: add suspend wakeup support to sh_keysc
Date: Tue, 10 Mar 2009 16:13:30 +0530
Message-ID: <5d5443650903100343x1d997179r578207509be43412@mail.gmail.com>
References: <20090310062421.22328.68726.sendpatchset@rx1.opensource.se>
	 <5d5443650903100124g2bbc4837gaa5d9a9f17cd56f0@mail.gmail.com>
	 <aec7e5c30903100301n3ed24395i3d72fd956b4b7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <aec7e5c30903100301n3ed24395i3d72fd956b4b7f@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-input@vger.kernel.org, lethal@linux-sh.org, linux-sh@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Magnus,

>>
>> Please add device_init_wakeup(&pdev->dev, 0) in sh_keysc_remove.
>
> Isn't this just flagging the device as wakeup capable? My first guess
> would be that the the wakeup state of a removed device is irrelevant
> since it won't be suspended anyway. Or am I misunderstanding? Please
> explain in more detail.

I may not have complete answer, but I am thinking of someone depending/reading
on wakeup file state to determine the state of your device in userspace will get
confused, so better to disable to wakeup capability on remove.

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
