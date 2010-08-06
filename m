From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 0/1] mouse: add qci touchpad driver
Date: Fri, 6 Aug 2010 13:44:11 -0700
Message-ID: <201008061344.13326.dmitry.torokhov@gmail.com>
References: <4C5C713D.8010902@codeaurora.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4C5C713D.8010902@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Neil Leeder <nleeder@codeaurora.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Horace Fu <horace.fu@quantatw.com>, Mandeep Singh Baines <msb@chromium.org>
List-Id: linux-input@vger.kernel.org

On Friday, August 06, 2010 01:31:57 pm Neil Leeder wrote:
> This is an update of the driver that Quanta posted here a few days ago.
> Quanta wrote the original version of the driver and I am picking up
> maintenance for code aurora forum.
> 
> I've addressed the review comments. The only one that's outstanding is
> the use of the sensitivity value. I don't see an easy way that userspace
> would be able to apply the sensitivity scaling between the driver and
> say xorg, so for now I've left it in the driver, but I'd welcome any
> suggestions for improvement.
> 

Doesn't "xset mouse" do what you want?

-- 
Dmitry
