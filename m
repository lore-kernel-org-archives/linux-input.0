From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH 5/5] input: twl6040-vibra: remove mutex
Date: Tue, 19 Apr 2016 10:08:00 +0200
Message-ID: <3B181EC4-29FA-4C65-B33A-CC0D09E26E4D@goldelico.com>
References: <cover.1461009340.git.hns@goldelico.com> <592912a81a86fe0c9b5eaf3407cc5c4e1bfef9fe.1461009340.git.hns@goldelico.com> <20160418212048.GB1006@dtor-ws> <6E9FA6EF-660C-44AE-8BF4-03A21F0DB043@goldelico.com> <20160419080150.GB13933@dtor-ws>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.218]:38081 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752463AbcDSIIy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Apr 2016 04:08:54 -0400
In-Reply-To: <20160419080150.GB13933@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pyra-handheld.com, letux-kernel@openphoenux.org


> Am 19.04.2016 um 10:01 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
> 
> On Tue, Apr 19, 2016 at 09:49:01AM +0200, H. Nikolaus Schaller wrote:
>> 
>>> Am 18.04.2016 um 23:20 schrieb Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>>> 
>>> On Mon, Apr 18, 2016 at 09:55:41PM +0200, H. Nikolaus Schaller wrote:
>>>> The mutex does not seem to be needed.
>>> 
>>> twl6040_vibra_suspend() and vibra_play_work() may run concurrently, no?
>> 
>> Hm. I don't know about the rule that would give an answer to this question...
> 
> Sorry, that was actually a statement, not really a question.

Indeed. In doubt about the answer we should take measures for the worst case.

> It is
> possible (although very unlikely) that userspace posts play request and
> workqueue will not run until after suspend callback.
> 
> Thinking about it some more I wonder if we better do what
> twl6040_vibra_close() does and cancel the work before shutting off the
> device, so that there is no chance of work executing after suspend
> callback and reenabling the device. This way we can indeed remove the
> mutex.

Ok, I am fine with this.

Will post an update ASAP.

BR and thanks,
Nikolaus

