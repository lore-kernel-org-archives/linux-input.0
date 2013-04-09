From: Bastian Hecht <hechtb@gmail.com>
Subject: Re: [PATCH v2 2/2] ARM: shmobile: Armadillo800EVA: Move st1232 reset
 pin handling
Date: Tue, 9 Apr 2013 11:16:18 +0200
Message-ID: <CABYn4sxsDtSdMEQqkPzi5CojsJcvqXbBKMm2wXtCLHPZYh1AiQ@mail.gmail.com>
References: <1365425547-10391-1-git-send-email-hechtb+renesas@gmail.com>
	<1365425547-10391-2-git-send-email-hechtb+renesas@gmail.com>
	<1534841.hHClRQAXMk@avalon>
	<20130409082644.GD18478@verge.net.au>
	<20130409091130.GA3401@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130409091130.GA3401@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: Simon Horman <horms@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Linux-SH <linux-sh@vger.kernel.org>, linux-input@vger.kernel.org, Tony SIM <chinyeow.sim.xt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
List-Id: linux-input@vger.kernel.org

2013/4/9 Simon Horman <horms@verge.net.au>:
> On Tue, Apr 09, 2013 at 05:26:44PM +0900, Simon Horman wrote:
>> On Mon, Apr 08, 2013 at 04:17:22PM +0200, Laurent Pinchart wrote:
>> > Hi Bastian,
>> >
>> > Thanks for the patch.
>> >
>> > On Monday 08 April 2013 14:52:27 Bastian Hecht wrote:
>> > > We no longer need to set up the reset pin for the st1232 in the board
>> > > code, but can pass the GPIO number via the platform data to the driver.
>> > > This results in a cleaner grouping of the device setup.
>> > >
>> > > Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>> >
>> > Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>
>> Thanks.
>>
>> I have queued this up in the boards-armadillo800eva branch.
>>
>> There were some conflicts when I applied the code which
>> I fixed manually. Bastian, can you please check that the
>> following is correct? If it is not please send an incremental patch.
>
> I was trying to apply your patch to an old branch.
> It applies cleanly to the correct new branch :)

Ah sweet, I was indeed a bit confused about going back to the INTC as
primary controller.
